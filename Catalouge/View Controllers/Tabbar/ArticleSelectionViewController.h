//
//  ArticleSelectionViewController.h
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXTableView;
@interface ArticleSelectionViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *view_SearchBox;
@property (strong, nonatomic) IBOutlet UITextField *txtField_Search_Clients;
@property (strong, nonatomic) IBOutlet CXTableView *tbl_ClientList;
@property (strong, nonatomic) NSMutableArray *arr_ClientList;
@property (strong, nonatomic) NSMutableArray *arr_Common_List;
@property (strong, nonatomic) NSString *strSearchString;
@property (strong, nonatomic) NSString *searchCriteria;
@property (strong, nonatomic) NSString *parentScreenName;
@end
