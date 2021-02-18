//
//  Item.h
//  RandomItems
//
//  Created by David Clark on 11/24/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Item : NSObject

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueDollars;
@property (nonatomic, strong) NSDate *dateCreated;

+ (instancetype)randomItem;

- (instancetype)initWithItemName:(NSString*)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)serial NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithItemName:(NSString*)name
                    serialNumber:(NSString *)serial;

- (instancetype)initWithItemName:(NSString*)name;

@end

NS_ASSUME_NONNULL_END
