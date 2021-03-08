//
//  ItemStore.m
//  Homepwner
//
//  Created by David Clark on 2/16/21.
//

#import "ItemStore.h"
#import "Item.h"
#import "ImageStore.h"



@interface ItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

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
        _privateItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *)allItems {
    return [self.privateItems copy];
}

- (Item *)createItem {
    Item *item = [Item randomItem];
    
    [self.privateItems addObject:item];
    
    return item;    
}

- (void)removeItem:(Item *)item {
    [self.privateItems removeObjectIdenticalTo:item];
    [ImageStore.sharedStore deleteImageForKey:item.itemKey];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) { return; }
    
    Item *item = self.privateItems[fromIndex];
    
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end
