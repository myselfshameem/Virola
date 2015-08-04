//
//  SyncTableViewCell.h
//  Catalouge
//
//  Created by Shameem Ahamad on 5/19/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SyncTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblClient_Name;
@property (strong, nonatomic) IBOutlet UIButton *checkBox;
-(IBAction)btnPressed:(id)sender;
@end
