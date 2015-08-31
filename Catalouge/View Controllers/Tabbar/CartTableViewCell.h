//
//  CartTableViewCell.h
//  Catalouge
//
//  Created by Shameem Ahamad on 5/19/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgVw_Logo;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Title;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Description;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Price;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Price_USD;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Price_GBP;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Quantity;
@property (strong, nonatomic) IBOutlet UIButton *btn_Close;
@property (strong, nonatomic) IBOutlet UIButton *btn_View_Details;
@property (strong, nonatomic) IBOutlet UIView *vw_qty;
@property (strong, nonatomic) IBOutlet UIView *vw_ImageHolder;

@property (assign, nonatomic) NSInteger row;
typedef void(^CellEventBlock)(NSInteger row,int callbackType);
@property (strong, nonatomic) CellEventBlock cellEventBlock;
- (void)cellEventCallback:(CellEventBlock)cellEventBlock;

- (IBAction)btnPressed:(id)sender;
- (void)initilizeCell;

@end
