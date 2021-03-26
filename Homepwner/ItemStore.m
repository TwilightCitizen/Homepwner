//
//  ItemStore.m
//  Homepwner
//
//  Created by David Clark on 2/16/21.
//

#import "ItemStore.h"
#import "Item+CoreDataClass.h"
#import "ImageStore.h"
#import <CoreData/CoreData.h>



@interface ItemStore ()

@property (nonatomic) NSMutableArray *privateItems;
@property (nonatomic, strong) NSMutableArray *privateAssetTypes;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;

@end



@implementation ItemStore

+ (ItemStore *)sharedStore {
    static ItemStore *sharedStore;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    
    return sharedStore;
}

- (ItemStore *)initPrivate {
    self = [super init];
    
    if (self) {
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc =
            [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        
        NSString *path = self.itemArchivePath;
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error])
        {
            [NSException raise:@"Open Failure"
                        format:@"%@", [error localizedDescription]];
        }
        
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _context.persistentStoreCoordinator = psc;
        
        [self loadAllItems];
    }
    
    return self;
}

- (NSArray *)allItems {
    return [self.privateItems copy];
}

- (Item *)createItem {
    double order =
        self.allItems.count == 0 ? 1.0 :
        [self.privateItems.lastObject orderingValue] + 1.0;
    
    NSLog(@"Adding after %lu items, order = %.2f",
          (unsigned long)self.privateItems.count, order);
    
    Item *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item"
                                               inManagedObjectContext:self.context];
    item.orderingValue = order;
    
    [self.privateItems addObject:item];
    
    return item;    
}

- (void)removeItem:(Item *)item {
    [ImageStore.sharedStore deleteImageForKey:item.itemKey];
    [self.context deleteObject:item];
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) { return; }
    
    Item *item = self.privateItems[fromIndex];
    
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
    
    double lowBound = toIndex > 0 ?
        [self.privateItems[toIndex - 1] orderingValue] :
        [self.privateItems[1] orderingValue] - 2.0;
    
    double hiBound = toIndex < self.privateItems.count - 1 ?
        [self.privateItems[toIndex + 1] orderingValue] :
        [self.privateItems[toIndex - 1] orderingValue] + 2.0;
    
    double orderValue = (lowBound + hiBound) / 2.0;
    
    NSLog(@"Moving to order %f", orderValue);
    
    item.orderingValue = orderValue;
}

- (NSString *)itemArchivePath {
    NSArray *docDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [docDirs firstObject];
    
    return [docDir stringByAppendingPathComponent:@"store.data"];
}

- (BOOL)saveChanges {
    NSError *error = nil;
    BOOL successful = [self.context save:&error];
    
    if (!successful) {
        NSLog(@"Error saving: %@", error.localizedDescription);
    }
    
    return successful;
}

- (void)loadAllItems {
    if (!self.privateItems) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Item"
                                                  inManagedObjectContext:self.context];
        
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue"
                                                               ascending:YES];
        
        request.entity = entity;
        request.sortDescriptors = @[sort];
        
        NSError *error = nil;
        
        NSArray *result = [self.context executeFetchRequest:request
                                                      error:&error];
        
        if (!result) {
            [NSException raise:@"Fetch Failed"
                        format:@"Reason: %@", error.localizedDescription];
        }
        
        self.privateItems = [[NSMutableArray alloc] initWithArray:result];
    }
}

- (NSArray *)privateAssetTypes {
    if (!_privateAssetTypes) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"AssetType"
                                                  inManagedObjectContext:self.context];
        
        request.entity = entity;
        
        NSError *error = nil;
        NSArray *result = [self.context executeFetchRequest:request
                                                      error:&error];
        
        if (!result) {
            [NSException raise:@"Fetch Failed"
                        format:@"Reason: %@", error.localizedDescription];
        }
        
        _privateAssetTypes = [result mutableCopy];
    }
    
    if (_privateAssetTypes.count == 0) {
        NSManagedObject *type;
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AssetType" inManagedObjectContext:self.context];
        
        [type setValue:@"Furniture" forKey:@"label"];
        [_privateAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AssetType" inManagedObjectContext:self.context];
        
        [type setValue:@"Jewelry" forKey:@"label"];
        [_privateAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AssetType" inManagedObjectContext:self.context];
        
        [type setValue:@"Electronics" forKey:@"label"];
        [_privateAssetTypes addObject:type];
    }
    
    return _privateAssetTypes;
}

- (NSArray *)allAssetTypes {
    return [self.privateAssetTypes copy];
}

@end
