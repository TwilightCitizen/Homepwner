//
//  Item.m
//  RandomItems
//
//  Created by David Clark on 11/24/20.
//

#import "Item.h"
#import <UIKit/UIKit.h>

@implementation Item

+ (instancetype)randomItem {
    NSArray *adjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    NSArray *nounList = @[@"Bear", @"Spork", @"MacBook"];
    
    NSInteger adjectiveIndex = arc4random() % [adjectiveList count];
    NSInteger nounIndex = arc4random() % [nounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                            adjectiveList[adjectiveIndex],
                            nounList[nounIndex]];
    
    int randomValue = arc4random() % 100;
    
    NSString *randomSerial = [NSString stringWithFormat:@"%c%c%c%c%c",
                              '0' + arc4random() % 10,
                              'A' + arc4random() % 26,
                              '0' + arc4random() % 10,
                              'A' + arc4random() % 26,
                              '0' + arc4random() % 10];
    
    Item *item = [[self alloc] initWithItemName:randomName
                                 valueInDollars:randomValue
                                   serialNumber:randomSerial];
    
    return item;
}

- (instancetype)initWithItemName:(NSString*)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)serial {
    self = [super init];
    
    if (self) {
        _itemName = name;
        _valueDollars = value;
        _serialNumber = serial;
        _dateCreated = [[NSDate alloc] init];
        _itemKey = [[[NSUUID alloc] init] UUIDString];
    }
    
    return self;
}

- (instancetype)initWithItemName:(NSString*)name
                    serialNumber:(NSString *)serial {
    return [self initWithItemName:name
                   valueInDollars:0
                     serialNumber:serial];
}

- (instancetype)initWithItemName:(NSString*)name {
    return [self initWithItemName:name
                   valueInDollars:0
                     serialNumber:@""];
}

- (instancetype)init {
    return [self initWithItemName:@"Item"];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (%@): $%d [%@]",
            self.itemName, self.serialNumber, self.valueDollars, self.dateCreated];
    
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.itemName forKey:@"itemName"];
    [coder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [coder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [coder encodeObject:self.itemKey forKey:@"itemKey"];
    [coder encodeInt:self.valueDollars forKey:@"valueDollars"];
    [coder encodeObject:self.thumbnail forKey:@"thumbnail"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    
    if (self) {
        _itemName = [coder decodeObjectForKey:@"itemName"];
        _serialNumber = [coder decodeObjectForKey:@"serialNumber"];
        _dateCreated = [coder decodeObjectForKey:@"dateCreated"];
        _itemKey = [coder decodeObjectForKey:@"itemKey"];
        _valueDollars = [coder decodeIntForKey:@"valueDollars"];
        _thumbnail = [coder decodeObjectForKey:@"thumbnail"];
    }
    
    return self;
}

- (void)setThumbnailFromImage:(UIImage *)image {
    CGSize origSize = image.size;
    CGRect newRect = CGRectMake(0, 0, 44, 44);
    
    float ratio = MAX(newRect.size.width / origSize.width,
                      newRect.size.height / origSize.height);
    
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect
                                                    cornerRadius:5.0];
    
    [path addClip];
    
    CGRect projectRect;
    
    projectRect.size.width = ratio * origSize.width;
    projectRect.size.height = ratio * origSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;
    
    [image drawInRect:projectRect];
    
    UIImage *thumb = UIGraphicsGetImageFromCurrentImageContext();
    self.thumbnail = thumb;
    
    UIGraphicsEndImageContext();
}

@end
