//
//  OrderCellTableViewCell.h
//  Catalouge
//
//  Created by Shameem Ahamad on 8/22/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCellTableViewCell : UITableViewCell
@property(nonatomic,weak) IBOutlet UILabel *lbl_OrderNo;
@property(nonatomic,weak) IBOutlet UILabel *lbl_ClientName;
@property(nonatomic,weak) IBOutlet UILabel *lbl_OrderDate;
@property(nonatomic,weak) IBOutlet UIButton *btn_ResendEmail;
@property(nonatomic,assign) NSInteger tag;

typedef void (^ResendOrderBlock)(NSInteger tag);
@property(nonatomic,strong) ResendOrderBlock resendOrderBlock;


- (void)registerResendOrderCallBlock:(ResendOrderBlock)resendOrderBlock;

- (IBAction)resendOrder:(id)sender;
@end
