//
//  Item.m
//  RandomItems
//
//  Created by David Clark on 11/24/20.
//

#import "Item.h"

@implementation Item

- (instancetype)initWithItemName:(NSString*)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)serial {
    self = [super init];
    
    if (self) {
        _itemName = name;
        _valueDollars = value;
        _serialNumber = serial;
        _dateCreated = [[NSDate alloc] init];
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

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (%@), Worth: %d, Recorded on %@",
            self.itemName, self.serialNumber, self.valueDollars, self.dateCreated];
    
}

@end
