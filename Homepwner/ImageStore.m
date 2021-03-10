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
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    
    return sharedStore;
}

- (ImageStore *)initPrivate {
    self = [super init];
    
    if (self) {
        _images = [[NSMutableDictionary alloc] init];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        
        [nc addObserver:self
               selector:@selector(clearCache)
                   name:UIApplicationDidReceiveMemoryWarningNotification
                 object:nil];
    }
    
    return self;
}

- (void)clearCache {
    [self.images removeAllObjects];
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    self.images[key] = image;
    
    NSString *imagePath = [self imagePathForKey:key];
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    [data writeToFile:imagePath atomically:YES];
}
- (UIImage *)imageForKey:(NSString *)key {
    UIImage *image = self.images[key];
    
    if (!image) {
        NSString *imagePath = [self imagePathForKey:key];
        
        image = [UIImage imageWithContentsOfFile:imagePath];
        
        if (image) { self.images[key] = image; }
    }
    
    return image;
}

- (void)deleteImageForKey:(NSString *)key {
    [self.images removeObjectForKey:key];
    
    NSString *imagePath = [self imagePathForKey:key];
    
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}

- (NSString *)imagePathForKey:(NSString *)key {
    NSArray *docDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [docDirs firstObject];
    
    return [docDir stringByAppendingPathComponent:key];
}

@end
