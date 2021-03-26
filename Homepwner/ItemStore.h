//
//  ItemStore.h
//  Homepwner
//
//  Created by David Clark on 2/16/21.
//

#import <Foundation/Foundation.h>

@class Item;

NS_ASSUME_NONNULL_BEGIN

@interface ItemStore : NSObject

@property (class, nonatomic, readonly) ItemStore *sharedStore;
@property (nonatomic, readonly, copy) NSArray *allItems;
@property (nonatomic, readonly, copy) NSArray *allAssetTypes;

- (instancetype)init NS_UNAVAILABLE;
- (Item *)createItem;
- (void)removeItem:(Item *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;
- (BOOL)saveChanges;

@end

NS_ASSUME_NONNULL_END
