//
//  Item+CoreDataClass.h
//  Homepwner
//
//  Created by David Clark on 3/22/21.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@class AssetType, NSObject;

NS_ASSUME_NONNULL_BEGIN

@interface Item : NSManagedObject

- (void)setThumbnailFromImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END

#import "Item+CoreDataProperties.h"
