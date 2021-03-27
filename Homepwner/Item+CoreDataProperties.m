//
//  Item+CoreDataProperties.m
//  Homepwner
//
//  Created by David Clark on 3/22/21.
//
//

#import "Item+CoreDataProperties.h"

@implementation Item (CoreDataProperties)

+ (NSFetchRequest<Item *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Item"];
}

@dynamic itemName;
@dynamic serialNumber;
@dynamic valueDollars;
@dynamic dateCreated;
@dynamic itemKey;
@dynamic thumbnail;
@dynamic orderingValue;
@dynamic assetType;

@end
