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


@interface ItemsVC ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end



@implementation ItemsVC

- (instancetype)init
{
    return [self initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStylePlain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    
    [self.tableView setTableHeaderView:self.headerView];
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
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"UITableViewCell"
                             forIndexPath:indexPath];
    
    if (indexPath.row < ItemStore.sharedStore.allItems.count) {
        NSArray *items = ItemStore.sharedStore.allItems;
        Item *item = items[indexPath.row];
        cell.textLabel.text = item.description;
    } else {
        cell.textLabel.text = @"No More Items";
    }
    
    return cell;
}

/* - (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = ItemStore.sharedStore.allItems;
        Item *item = items[indexPath.row];
        
        [ItemStore.sharedStore removeItem:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
} */

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

- (UIView *)headerView {
    if (!_headerView) {
        [[NSBundle mainBundle] loadNibNamed:@"ItemsHeader"
                                      owner:self
                                    options:nil];
    }
    
    return _headerView;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsVC *details = [[DetailsVC alloc] init];
    NSArray *items = ItemStore.sharedStore.allItems;
    Item *item = items[indexPath.row];
    details.item = item;
    
    [self.navigationController pushViewController:details animated:YES];
}

- (IBAction)addNewItem:(id)sender {
    Item *newItem = [ItemStore.sharedStore createItem];
    NSInteger lastRow = [ItemStore.sharedStore.allItems indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
}

- (IBAction)toggleEditingMode:(id)sender {
    if (self.isEditing) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    } else {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}

@end
