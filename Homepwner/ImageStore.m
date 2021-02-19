//
//  ImageStore.m
//  Homepwner
//
//  Created by David Clark on 2/18/21.
//

#import "ImageStore.h"


@interface ImageStore ()

@property (nonatomic, strong) NSMutableDictionary *images;

@end



@implementation ImageStore

+ (ImageStore *)sharedStore {
    static ImageStore *sharedStore;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

- (ImageStore *)initPrivate {
    self = [super init];
    
    if (self) {
        _images = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    self.images[key] = image;
}
- (UIImage *)imageForKey:(NSString *)key {
    return self.images[key];
}

- (void)deleteImageForKey:(NSString *)key {
    [self.images removeObjectForKey:key];
}

@end
