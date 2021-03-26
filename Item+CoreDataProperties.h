//
//  Item+CoreDataProperties.h
//  Homepwner
//
//  Created by David Clark on 3/22/21.
//
//

#import "Item+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Item (CoreDataProperties)

+ (NSFetchRequest<Item *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *itemName;
@property (nullable, nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueDollars;
@property (nullable, nonatomic, copy) NSDate *dateCreated;
@property (nullable, nonatomic, copy) NSString *itemKey;
@property (nullable, nonatomic, retain) UIImage *thumbnail;
@property (nonatomic) double orderingValue;
@property (nullable, nonatomic, retain) AssetType *assetType;

@end

NS_ASSUME_NONNULL_END
