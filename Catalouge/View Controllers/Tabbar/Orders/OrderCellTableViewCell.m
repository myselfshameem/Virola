//
//  OrderCellTableViewCell.m
//  Catalouge
//
//  Created by Shameem Ahamad on 8/22/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "OrderCellTableViewCell.h"

@implementation OrderCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)registerResendOrderCallBlock:(ResendOrderBlock)resendOrderBlock{

    self.resendOrderBlock = resendOrderBlock;
    
}

- (IBAction)resendOrder:(id)sender{

    
    if (self.resendOrderBlock) {
        self.resendOrderBlock(self.tag);
    }

}

@end
