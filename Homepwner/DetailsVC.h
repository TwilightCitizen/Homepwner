//
//  DetailsVC.h
//  Homepwner
//
//  Created by David Clark on 2/17/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Item;

@interface DetailsVC : UIViewController <
    UITextFieldDelegate,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate,
    UIPopoverControllerDelegate
>

@property (nonatomic, strong) Item *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

- (instancetype)initForNewItem:(BOOL)isNew NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                         bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
@end

NS_ASSUME_NONNULL_END
