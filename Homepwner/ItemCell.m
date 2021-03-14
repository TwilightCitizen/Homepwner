//
//  ItemCell.m
//  Homepwner
//
//  Created by David Clark on 3/11/21.
//

#import "ItemCell.h"

@implementation ItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)showImage:(id)sender {
    if (self.actionBlock) { self.actionBlock(); }
}

@end
