//
//  AssetTypeVC.m
//  Homepwner
//
//  Created by David Clark on 3/25/21.
//

#import "AssetTypeVC.h"
#import "Item+CoreDataClass.h"
#import "ItemStore.h"



@interface AssetTypeVC ()

@end



@implementation AssetTypeVC

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        self.navigationItem.title = NSLocalizedString(@"Asset Type", @"AssetTypeVC title");
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:UITableViewCell.class
           forCellReuseIdentifier:@"Cell"];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return ItemStore.sharedStore.allAssetTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                            forIndexPath:indexPath];
    
    NSArray *allAssets = ItemStore.sharedStore.allAssetTypes;
    AssetType *assetType = allAssets[indexPath.row];
    NSString *assetLabel = [(NSManagedObject *)assetType valueForKey:@"label"];
    
    cell.textLabel.text = assetLabel;
    
    cell.accessoryType = assetType == self.item.assetType ?
        UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    NSArray *allAssets = ItemStore.sharedStore.allAssetTypes;
    AssetType *assetType = allAssets[indexPath.row];
    
    self.item.assetType = assetType;
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
