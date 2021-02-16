//
//  ItemsVC.m
//  Homepwner
//
//  Created by David Clark on 2/10/21.
//

#import "ItemsVC.h"
#import "ItemStore.h"
#import "Item.h"


@interface ItemsVC ()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end



@implementation ItemsVC

- (instancetype)init
{
    return [self initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        for (int i = 0; i < 5; i++) {
            [[ItemStore sharedStore] createItem];
        }
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    
    UIView *header = self.headerView;
    
    [self.tableView setTableHeaderView:header];
    
    self.navigationController.navigationBar.hidden = true;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[[ItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    NSArray *items = [[ItemStore sharedStore] allItems];
    Item *item = items[indexPath.row];
    
    cell.textLabel.text = item.description;
    
    return cell;
}

- (UIView *)headerView {
    if (!_headerView) {
        [[NSBundle mainBundle] loadNibNamed:@"ItemsHeader"
                                      owner:self
                                    options:nil];
    }
    
    return _headerView;
}

- (IBAction)addNewItem:(id)sender {
    
}

- (IBAction)toggleEditingMode:(id)sender {
    
}

@end
