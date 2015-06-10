//
//  ClientViewController.h
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClientViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *view_SearchBox;
@property (strong, nonatomic) IBOutlet UITextField *txtField_Search;
@property (strong, nonatomic) IBOutlet UITableView *tbl_Clients;
@property (strong, nonatomic) IBOutlet UIButton *btn_AddClient;
- (IBAction)addNewClient:(id)sender;

typedef void(^ClientSelectedBlock)(NSString *clientid);
@property (strong, nonatomic) ClientSelectedBlock clientSelectedBlock;
- (void)callBackWhenClientSelected:(ClientSelectedBlock)clientCallBlock;

@end
