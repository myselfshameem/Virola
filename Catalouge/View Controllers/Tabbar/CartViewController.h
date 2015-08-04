//
//  CartViewController.h
//  Catalouge
//
//  Created by Shameem Ahamad on 5/19/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lbl_Client_Name;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Total_Item;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Price;
@property (strong, nonatomic) IBOutlet UIButton *btn_PlaceOrder;
@property (strong, nonatomic) IBOutlet UIButton *btn_Refresh;
@property (strong, nonatomic) IBOutlet __block UITableView *tbl_List_Cart;
@property (strong, nonatomic) IBOutlet UILabel *lbl_UserName;



- (IBAction)chnageClient:(id)sender;
- (IBAction)placeOrder:(id)sender;
@end
