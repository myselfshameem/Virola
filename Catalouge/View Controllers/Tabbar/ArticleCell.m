//
//  ArticleCell.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/18/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "ArticleCell.h"

@implementation ArticleCell

- (void)awakeFromNib {
    // Initialization code

    [self.imgV_Logo setImage:nil];
    [self.lbl_Title setText:@""];
    [self.lbl_Description setText:@""];
    [self.lbl_Price setText:@""];
}

- (void)initilizeCell{
    
    self.vw_ImageHolder.layer.cornerRadius = 2;
    self.vw_ImageHolder.layer.borderWidth = 1;
    self.vw_ImageHolder.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
