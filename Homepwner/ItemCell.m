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
    [self updateInterfaceForDynamicTypeSize];
    
    NSNotificationCenter *ns = [NSNotificationCenter defaultCenter];
    
    [ns addObserver:self selector:@selector(updateInterfaceForDynamicTypeSize)
               name:UIContentSizeCategoryDidChangeNotification
             object:nil];
}

- (void)dealloc{
    NSNotificationCenter *ns = [NSNotificationCenter defaultCenter];
    
    [ns removeObserver:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)showImage:(id)sender {
    if (self.actionBlock) { self.actionBlock(); }
}

- (void)updateInterfaceForDynamicTypeSize {
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    self.nameLabel.font = font;
    self.serialLabel.font = font;
    self.valueLabel.font = font;
}

@end
