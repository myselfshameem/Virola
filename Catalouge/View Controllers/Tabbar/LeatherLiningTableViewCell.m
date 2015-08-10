//
//  LeatherLiningTableViewCell.m
//  Catalouge
//
//  Created by Shameem Ahamad on 8/5/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "LeatherLiningTableViewCell.h"
@implementation LeatherLiningTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)initilizeCell{

    self.vw_1.layer.cornerRadius = 1;
    self.vw_1.layer.borderWidth = 1;
    self.vw_1.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    self.vw_2.layer.cornerRadius = 1;
    self.vw_2.layer.borderWidth = 1;
    self.vw_2.layer.borderColor = [UIColor grayColor].CGColor;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)dropDwonSelectedLeather:(id)sender{
    
    __weak LeatherLiningTableViewCell *myself = self;
    _callback ? _callback(myself,1,myself.indexOfCell) : @"";

}
- (IBAction)dropDwonSelectedLeatherColor:(id)sender{

    __weak LeatherLiningTableViewCell *myself = self;
    _callback ? _callback(myself,2,myself.indexOfCell) : @"";

}

- (IBAction)dropDwonSelected:(id)sender{


    switch ([sender tag]) {
        case 1:
        {
            __weak LeatherLiningTableViewCell *myself = self;
            _callback ? _callback(myself,[sender tag],myself.indexOfCell) : @"";

        }
            break;
        case 2:
        {
            __weak LeatherLiningTableViewCell *myself = self;
            _callback ? _callback(myself,[sender tag],myself.indexOfCell) : @"";
            
        }
            break;

        default:
            break;
    }


}
- (void)callbackForDropdown:(Callback)callback{

    _callback = callback;
}
@end
