//
//  SyncTableViewCell.h
//  Catalouge
//
//  Created by Shameem Ahamad on 5/19/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SynModelClass;
@interface SyncTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblClient_Name;
@property (strong, nonatomic) IBOutlet UIButton *checkBox;
@property (assign, nonatomic) SynModelClass *synModel;
-(IBAction)btnPressed:(id)sender;
@end
