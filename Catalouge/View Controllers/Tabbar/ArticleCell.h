//
//  ArticleCell.h
//  Catalouge
//
//  Created by Shameem Ahamad on 5/18/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgV_Logo;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Title;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Description;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Price;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Price_Usd;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Price_Gbp;

@property (strong, nonatomic) IBOutlet UIView *vw_ImageHolder;
- (void)initilizeCell;
@end
