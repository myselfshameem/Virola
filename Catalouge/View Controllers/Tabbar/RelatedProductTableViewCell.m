//
//  RelatedProductTableViewCell.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/23/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "RelatedProductTableViewCell.h"

@implementation RelatedProductTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initilizeCell{

    self.imgV_Logo_Holder.layer.cornerRadius = 2.0f;
    self.imgV_Logo_Holder.layer.borderWidth = 1.0f;
    self.imgV_Logo_Holder.layer.borderColor = [UIColor grayColor].CGColor;
}
@end
