//
//  CartTableViewCell.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/19/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "CartTableViewCell.h"

@implementation CartTableViewCell

- (void)awakeFromNib {
    // Initialization code


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnPressed:(id)sender{

    __weak CartTableViewCell *wealSelf = self;
    _cellEventBlock ? _cellEventBlock(wealSelf.row,[sender tag]) : @"";
    
}

- (void)cellEventCallback:(CellEventBlock)cellEventBlock1{

    _cellEventBlock = cellEventBlock1;

}

@end
