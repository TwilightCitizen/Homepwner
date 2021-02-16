//
//  ItemStore.m
//  Homepwner
//
//  Created by David Clark on 2/16/21.
//

#import "ItemStore.h"
#import "Item.h"



@interface ItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end



@implementation ItemStore

+ (instancetype)sharedStore {
    static ItemStore *sharedStore;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

- (instancetype)init {
    [NSException raise:@"Singleton" format:@"Use +[ItemStore sharedStore]"];
    
    return nil;
}

- (instancetype)initPrivate {
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

@end
