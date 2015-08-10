//
//  AddMoreLeatherTableViewCell.m
//  Catalouge
//
//  Created by Shameem Ahamad on 8/8/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "AddMoreLeatherTableViewCell.h"

@implementation AddMoreLeatherTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)dropDwonSelected:(id)sender{
    
    
    __weak AddMoreLeatherTableViewCell *myself = self;
    _callbackAddMoreLeather ? _callbackAddMoreLeather(myself,[sender tag]) : @"";
    
}

- (void)callbackForDropdown:(CallbackAddMoreLeather)callback{
    _callbackAddMoreLeather = callback;
}
@end
