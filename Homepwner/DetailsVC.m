//
//  DetailsVC.m
//  Homepwner
//
//  Created by David Clark on 2/17/21.
//

#import "DetailsVC.h"
#import "Item.h"



@interface DetailsVC ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end



@implementation DetailsVC

- (void)setItem:(Item *)item {
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (void)viewDidLoad {
    _nameField.delegate = self;
    _serialField.delegate = self;
    _valueField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    Item *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueDollars];
    self.datePicker.date = item.dateCreated;
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


@end
