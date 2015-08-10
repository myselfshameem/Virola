//
//  AddMoreLeatherTableViewCell.h
//  Catalouge
//
//  Created by Shameem Ahamad on 8/8/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMoreLeatherTableViewCell : UITableViewCell
@property(weak,nonatomic) IBOutlet UIButton *btnAddMore;
@property(weak,nonatomic) IBOutlet UILabel *lblTitle;
- (IBAction)dropDwonSelected:(id)sender;

typedef void(^CallbackAddMoreLeather)(__weak AddMoreLeatherTableViewCell *cell, NSInteger tag);

@property (strong, nonatomic) CallbackAddMoreLeather callbackAddMoreLeather;

- (void)callbackForDropdown:(CallbackAddMoreLeather)callback;

@end
