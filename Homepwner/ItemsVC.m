//
//  ItemsVC.m
//  Homepwner
//
//  Created by David Clark on 2/10/21.
//

#import "ItemsVC.h"
#import "ItemStore.h"
#import "Item.h"
#import "DetailsVC.h"
#import "ItemCell.h"

@implementation ItemsVC

- (instancetype)init {
    return [self initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                action:@selector(addNewItem:)];
        
        navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"ItemCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ItemCell"];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"OtherCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [ItemStore.sharedStore.allItems count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = ItemStore.sharedStore.allItems.count;
    
    if (indexPath.row < count) {
        NSArray *items = ItemStore.sharedStore.allItems;
        Item *item = items[indexPath.row];
        
        ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell"
                                                         forIndexPath:indexPath];
        
        cell.nameLabel.text = item.itemName;
        cell.serialLabel.text = item.serialNumber;
        cell.valueLabel.text = [NSString stringWithFormat:@"%d", item.valueDollars];
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherCell"
                                                            forIndexPath:indexPath];
    
    cell.textLabel.text = count == 0 ? @"No Items" : @"No More Items";
    
    return cell;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView
trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIContextualActionHandler handler = ^(UIContextualAction * _Nonnull action,
                                          __kindof UIView * _Nonnull sourceView,
                                          void (^ _Nonnull completionHandler)(BOOL))
    {
        NSArray *items = ItemStore.sharedStore.allItems;
        Item *item = items[indexPath.row];
        
        [ItemStore.sharedStore removeItem:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        
        NSInteger lastRow = ItemStore.sharedStore.allItems.count;
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:lastRow inSection:0];
        
        [self.tableView reloadRowsAtIndexPaths:@[lastIndex]
                              withRowAnimation:UITableViewRowAnimationNone];
        
        completionHandler(YES);
    };
    
    UIContextualAction *remove = [UIContextualAction
        contextualActionWithStyle:UIContextualActionStyleDestructive
        title:@"Remove"
        handler:handler];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration
                                           configurationWithActions:@[remove]];
    
    return config;
}

- (NSIndexPath *)tableView:(UITableView *)tableView
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (proposedDestinationIndexPath.row == ItemStore.sharedStore.allItems.count) {
        return sourceIndexPath;
    } else {
        return proposedDestinationIndexPath;
    }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [ItemStore.sharedStore moveItemAtIndex:sourceIndexPath.row
                                   toIndex:destinationIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView
canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row < ItemStore.sharedStore.allItems.count;
}

- (BOOL)tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row < ItemStore.sharedStore.allItems.count;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == ItemStore.sharedStore.allItems.count) { return; }
    
    DetailsVC *details = [[DetailsVC alloc] initForNewItem:NO];
    NSArray *items = ItemStore.sharedStore.allItems;
    Item *item = items[indexPath.row];
    details.item = item;
    
    [self.navigationController pushViewController:details animated:YES];
}

- (IBAction)addNewItem:(id)sender {
    Item *newItem = [ItemStore.sharedStore createItem];
    DetailsVC *details = [[DetailsVC alloc] initForNewItem:YES];
    
    details.item = newItem;
    
    details.dismissBlock = ^{
        NSInteger lastRow = [ItemStore.sharedStore.allItems indexOfObject:newItem];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
        
        [self.tableView insertRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationTop];
        
        indexPath = [NSIndexPath indexPathForRow:lastRow + 1 inSection:0];
        
        [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationNone];
    };
    
    UINavigationController *navContoller = [[UINavigationController alloc]
                                            initWithRootViewController:details];
    
    navContoller.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:navContoller animated:YES completion:nil];
}

@end
