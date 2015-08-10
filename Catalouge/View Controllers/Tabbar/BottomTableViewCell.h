//
//  BottomTableViewCell.h
//  Catalouge
//
//  Created by Shameem Ahamad on 8/8/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomTableViewCell : UITableViewCell<UITextViewDelegate>
@property(nonatomic,strong)  IBOutlet UIView *vw_Qty;
@property(nonatomic,strong)  IBOutlet UIView *vw_Pair;
@property(nonatomic,strong)  IBOutlet UIView *vw_Size;
@property(nonatomic,strong)  IBOutlet  UIView *vw_Remarks;

@property(nonatomic,strong)  IBOutlet UITextField *txt_Qty;
@property(nonatomic,strong)  IBOutlet UITextField *txt_Pair;
@property(nonatomic,strong)  IBOutlet UITextField *txt_Size;
@property(nonatomic,strong)  IBOutlet UITextView *txt_Remarks;
@property(nonatomic,strong)  IBOutlet UIButton *addTOcartbtn;
@property (strong, nonatomic) UIToolbar *toolbar;



- (IBAction)addToCart:(id)sender;
typedef void(^AddToCartCallBack)();
@property (strong, nonatomic) AddToCartCallBack addToCartCallBack;
- (void)registerCallbackForAddToCart:(AddToCartCallBack)addToCartCallBack;







- (IBAction)dropDwonSelected:(id)sender;
typedef void(^QtyPairSizeCallback)(__weak BottomTableViewCell *cell, NSInteger tag);
@property (strong, nonatomic) QtyPairSizeCallback qtyPairSizeCallback;
- (void)registerCallbackForQtyPairSize:(QtyPairSizeCallback)qtyPairSizeCallback;

@end
