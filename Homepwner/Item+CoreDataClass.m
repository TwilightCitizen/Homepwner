//
//  Item+CoreDataClass.m
//  Homepwner
//
//  Created by David Clark on 3/22/21.
//
//

#import "Item+CoreDataClass.h"

@implementation Item

- (void)awakeFromInsert {
    [super awakeFromInsert];
    
    NSUUID *uuid = [[NSUUID alloc] init];
    NSString *key = uuid.UUIDString;
    
    self.itemKey = key;
    self.dateCreated = NSDate.date;
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
