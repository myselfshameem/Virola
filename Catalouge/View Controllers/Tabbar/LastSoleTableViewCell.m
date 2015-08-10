//
//  LastSoleTableViewCell.m
//  Catalouge
//
//  Created by Shameem Ahamad on 8/7/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "LastSoleTableViewCell.h"
#define Leather_OR_Lining_TAG 1
#define Leather_COLOR_OR_Lining_COLOR_TAG 2

@implementation LastSoleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initilizeCell{
    
    self.vw_Last.layer.cornerRadius = 1;
    self.vw_Last.layer.borderWidth = 1.0;
    self.vw_Last.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    self.vw_Sole.layer.cornerRadius = 1;
    self.vw_Sole.layer.borderWidth = 1.0;
    self.vw_Sole.layer.borderColor = [UIColor grayColor].CGColor;

    self.vw_SoleColor.layer.cornerRadius = 1;
    self.vw_SoleColor.layer.borderWidth = 1.0;
    self.vw_SoleColor.layer.borderColor = [UIColor grayColor].CGColor;

    
    self.vw_SoleMatarial.layer.cornerRadius = 1;
    self.vw_SoleMatarial.layer.borderWidth = 1.0;
    self.vw_SoleMatarial.layer.borderColor = [UIColor grayColor].CGColor;
    
    
//    self.txt_Last.adjustsFontSizeToFitWidth = YES;
//    self.txt_Sole.adjustsFontSizeToFitWidth = YES;
//    self.txt_SoleColor.adjustsFontSizeToFitWidth = YES;
//    self.txt_SoleMatarial.adjustsFontSizeToFitWidth = YES;

}


- (IBAction)dropDwonSelected:(id)sender{
    
    
    __weak LastSoleTableViewCell *myself = self;
    _callbackForLastSole ? _callbackForLastSole(myself,[sender tag]) : @"";
    
}

- (void)callbackForDropdown:(CallbackForLastSole)callback{


    _callbackForLastSole = callback;
}

@end
