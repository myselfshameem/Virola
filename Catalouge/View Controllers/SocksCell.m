//
//  SocksCell.m
//  
//
//  Created by Shameem Ahamad on 10/13/15.
//
//

#import "SocksCell.h"

@implementation SocksCell

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


- (IBAction)dropDwonSelectedSocks:(id)sender{
    
    __weak SocksCell *myself = self;
    _callback ? _callback(myself,1,myself.indexOfCell) : @"";
    
}
- (IBAction)dropDwonSelectedSocksColor:(id)sender{
    
    __weak SocksCell *myself = self;
    _callback ? _callback(myself,2,myself.indexOfCell) : @"";
    
}


- (void)callbackForSelectedSocksAndColors:(CallbackForSocks)callback{
    
    _callback = callback;
}

@end
