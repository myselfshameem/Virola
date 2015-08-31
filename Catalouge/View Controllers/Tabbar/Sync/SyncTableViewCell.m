//
//  ClientTableViewCell.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/19/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "SyncTableViewCell.h"
#import "SynModelClass.h"
@implementation SyncTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)btnPressed:(id)sender{
    BOOL flag = ![[[self synModel] selectedFlag] boolValue];
    [[self synModel] setSelectedFlag:[NSNumber numberWithBool:flag]];
    self.checkBox.selected = flag;
}
@end
