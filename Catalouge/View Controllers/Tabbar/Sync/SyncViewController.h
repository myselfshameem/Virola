//
//  SyncViewController.h
//  Catalouge
//
//  Created by Shameem Ahamad on 6/13/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SyncViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *view_SearchBox;
@property (strong, nonatomic) IBOutlet UITextField *txtField_Search;
@property (strong, nonatomic) IBOutlet UITableView *tbl_Clients;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) IBOutlet UILabel *lbl_ProgressHeader;
@property (strong, nonatomic) IBOutlet UIButton *btn_SelectAll;
typedef void(^ClientSelectedBlock)(NSString *clientid);
@property (strong, nonatomic) IBOutlet UIButton *btn_Sync;
- (IBAction)startSync:(id)sender;

@end
