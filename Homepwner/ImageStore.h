//
//  ImageStore.h
//  Homepwner
//
//  Created by David Clark on 2/18/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageStore : NSObject

@property (class, nonatomic, readonly) ImageStore *sharedStore;

- (instancetype)init NS_UNAVAILABLE;
- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
