//
//  DetailsVC.h
//  Homepwner
//
//  Created by David Clark on 2/17/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Item;

@interface DetailsVC : UIViewController

@property (nonatomic, strong) Item *item;

@end

NS_ASSUME_NONNULL_END
