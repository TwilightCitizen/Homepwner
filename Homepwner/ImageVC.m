//
//  ImageVC.m
//  Homepwner
//
//  Created by David Clark on 3/13/21.
//

#import "ImageVC.h"

@implementation ImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIImageView *image = (UIImageView *)self.view;
    image.image = self.image;
}

- (void)loadView {
    UIImageView *image = [[UIImageView alloc] init];
    
    image.contentMode = UIViewContentModeScaleAspectFit;
    self.view = image;
}

@end
