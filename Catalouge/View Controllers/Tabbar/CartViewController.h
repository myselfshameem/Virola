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

//Header
@property (strong, nonatomic) IBOutlet UIView *vw_PaymentTerms;
@property (strong, nonatomic) IBOutlet UITextField *txt_PaymentTerms;
@property (strong, nonatomic) IBOutlet UIButton *btn_PaymentTerms;

@property (strong, nonatomic) IBOutlet UIView *vw_PaymentTermsRemarks;
@property (strong, nonatomic) IBOutlet UITextField *txt_PaymentTermsRemarks;
@property (strong, nonatomic) IBOutlet UIButton *btn_PaymentTermsRemarks;

@property (strong, nonatomic) IBOutlet UIView *vw_ShippingTerms;
@property (strong, nonatomic) IBOutlet UITextField *txt_ShippingTerms;
@property (strong, nonatomic) IBOutlet UIButton *btn_ShippingTerms;

@property (strong, nonatomic) IBOutlet UIView *vw_ShippingTermsRemarks;
@property (strong, nonatomic) IBOutlet UITextView *txt_ShippingTermsRemarks;

@property (strong, nonatomic) IBOutlet UIView *vw_ModeOfShipping;
@property (strong, nonatomic) IBOutlet UITextField *txt_ModeOfShipping;
@property (strong, nonatomic) IBOutlet UIButton *btn_ModeOfShipping;

@property (strong, nonatomic) UIToolbar *toolbar;


- (IBAction)chnageClient:(id)sender;
- (IBAction)placeOrder:(id)sender;
@end
