//
//  DetailsVC.m
//  Homepwner
//
//  Created by David Clark on 2/17/21.
//

#import "DetailsVC.h"
#import "Item+CoreDataClass.h"
#import "ImageStore.h"
#import "ItemStore.h"
#import "AssetTypeVC.h"



@interface DetailsVC ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *assetType;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *photoLabel;

@end



@implementation DetailsVC

- (instancetype)initForNewItem:(BOOL)isNew {
    self = [super initWithNibName:nil bundle:nil];
    
    if (self && isNew ) {
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]
             initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                  target:self
                                  action:@selector(save)];
        
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                 target:self
                                 action:@selector(cancel)];
        
        self.navigationItem.rightBarButtonItem = doneItem;
        self.navigationItem.leftBarButtonItem = cancelItem;
    }
    
    NSNotificationCenter *ns = [NSNotificationCenter defaultCenter];
    
    [ns addObserver:self selector:@selector(updateFonts)
               name:UIContentSizeCategoryDidChangeNotification
             object:nil];
    
    return self;
}

- (void)dealloc{
    NSNotificationCenter *ns = [NSNotificationCenter defaultCenter];
    
    [ns removeObserver:self];
}

- (void)save {
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:self.dismissBlock];
}

- (void)cancel {
    [ItemStore.sharedStore removeItem:self.item];
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
}

- (void)setItem:(Item *)item {
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _nameField.delegate = self;
    _serialField.delegate = self;
    _valueField.delegate = self;
}

- (void)updateFonts {
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    self.nameField.font = font;
    self.serialField.font = font;
    self.valueField.font = font;
    self.nameLabel.font = font;
    self.serialLabel.font = font;
    self.valueLabel.font = font;
    self.dateLabel.font = font;
    self.photoLabel.font = font;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self prepareViewsForOrientation:UIApplication
         .sharedApplication
         .windows
         .firstObject
         .windowScene
         .interfaceOrientation];
    
    Item *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueDollars];
    self.datePicker.date = item.dateCreated;
    self.imageView.image = [ImageStore.sharedStore imageForKey:item.itemKey];
    
    NSString *typeLabel = [(NSManagedObject *)self.item.assetType valueForKey:@"label"];
    NSString *assetTypeString = NSLocalizedString(@"Asset Type: ", "Prefix for selected asset type");
    NSString *typeNoneString = NSLocalizedString(@"None", "Asset type none");
    
    typeLabel = !typeLabel ?
        [NSString stringWithFormat:@"%@%@", assetTypeString, typeNoneString] :
        [NSString stringWithFormat:@"Asset Type: %@", typeLabel];
    
    [self.assetType setTitle:typeLabel
                    forState:UIControlStateNormal];
    
    [self updateFonts];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    Item *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialField.text;
    item.valueDollars = [self.valueField.text intValue];
    item.dateCreated = self.datePicker.date;
}

- (void)prepareViewsForOrientation:(UIInterfaceOrientation)io {
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return;
    }
    
    BOOL hideOrShow = UIInterfaceOrientationIsLandscape(io);
    self.imageView.hidden = hideOrShow;
    self.toolbar.hidden = hideOrShow;
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    void (^prepareBlock)(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) =
        ^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) {};
    
    void (^completeBlock)(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context) =
        ^(id<UIViewControllerTransitionCoordinatorContext> _Nonnull context)
    {
        [self prepareViewsForOrientation:UIApplication
             .sharedApplication
             .windows
             .firstObject
             .windowScene
             .interfaceOrientation];
    };
    
    [coordinator animateAlongsideTransition:prepareBlock
                                 completion:completeBlock];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}

- (IBAction)snapPhoto:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController
         isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        imagePicker.modalPresentationStyle = UIModalPresentationPopover;
        imagePicker.popoverPresentationController.barButtonItem = sender;
        imagePicker.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)clearPhoto:(id)sender {
    self.imageView.image = nil;
    
    [ImageStore.sharedStore deleteImageForKey:self.item.itemKey];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    
    [self.item setThumbnailFromImage:image];
    [ImageStore.sharedStore setImage:image forKey:self.item.itemKey];   
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showAssetTypePicker:(id)sender {
    [self.view endEditing:YES];
    
    AssetTypeVC *assetTypeVC = [[AssetTypeVC alloc] init];
    
    assetTypeVC.item = self.item;
    
    [self.navigationController pushViewController:assetTypeVC
                                         animated:YES];
}


@end
