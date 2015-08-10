//
//  SearchViewController.h
//  Catalouge
//
//  Created by Shameem Ahamad on 6/14/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *view_SearchBox;
@property (strong, nonatomic) IBOutlet UITextField *txtField_Search_Clients;
@property (strong, nonatomic) IBOutlet UITableView *tbl_ClientList;
@property (strong, nonatomic) NSMutableArray *arr_ClientList;
@property (strong, nonatomic) NSMutableArray *arr_Common_List;

@property (strong, nonatomic) NSString *strSearchString;
@property (assign, nonatomic) NSInteger tag;
@property (assign, nonatomic) UITextField *common_TxtField;
typedef void(^OptionSelectedCallBack)(id selectedData);
@property (strong, nonatomic) OptionSelectedCallBack optionSelectedCallBack;
- (void)registerOptionSelectionCallback:(OptionSelectedCallBack)optionSelectedCallBack;



@end
