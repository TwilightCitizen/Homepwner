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

@property (nonatomic, readonly, copy) NSArray *allItems;

+ (instancetype)sharedStore;
- (Item *)createItem;
- (void)removeItem:(Item *)item;

@end

NS_ASSUME_NONNULL_END
