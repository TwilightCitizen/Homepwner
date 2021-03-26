//
//  ImageTransformer.m
//  Homepwner
//
//  Created by David Clark on 3/21/21.
//

#import "ImageTransformer.h"
#import <UIKit/UIKit.h>

@implementation ImageTransformer

+ (Class)transformedValueClass {
    return NSData.class;
}

- (id)transformedValue:(id)value {
    if (!value) { return nil; }
    
    if ([value isKindOfClass:NSData.class]) { return value; }
    
    return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value {
    return [UIImage imageWithData:value];
}

@end
