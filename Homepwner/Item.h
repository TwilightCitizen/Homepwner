//
//  Item.h
//  RandomItems
//
//  Created by David Clark on 11/24/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Item : NSObject <NSCoding>

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueDollars;
@property (nonatomic, strong) NSDate *dateCreated;
@property (nonatomic, copy) NSString *itemKey;
@property (nonatomic, strong) UIImage *thumbnail;

+ (instancetype)randomItem;

- (instancetype)initWithItemName:(NSString*)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)serial NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithItemName:(NSString*)name
                    serialNumber:(NSString *)serial;

- (instancetype)initWithItemName:(NSString*)name;

- (void)setThumbnailFromImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
