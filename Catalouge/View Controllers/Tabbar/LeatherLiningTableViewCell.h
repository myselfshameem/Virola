//
//  LeatherLiningTableViewCell.h
//  Catalouge
//
//  Created by Shameem Ahamad on 8/5/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeatherLiningTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_Title1;
@property (weak, nonatomic) IBOutlet UIView *vw_1;
@property (weak, nonatomic) IBOutlet UITextField *txt_1;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Title2;
@property (weak, nonatomic) IBOutlet UIView *vw_2;
@property (weak, nonatomic) IBOutlet UITextField *txt_2;
@property (assign, nonatomic) Rawmaterials *rawmaterials;
@property (assign, nonatomic) NSInteger cellType;
@property (assign, nonatomic) NSInteger indexOfCell;


- (void)initilizeCell;
- (IBAction)dropDwonSelectedLeather:(id)sender;
- (IBAction)dropDwonSelectedLeatherColor:(id)sender;
typedef void(^Callback)(__weak LeatherLiningTableViewCell *cell, NSInteger tag,NSInteger indexOfCell);

@property (strong, nonatomic) Callback callback;

- (void)callbackForDropdown:(Callback)callback;

@end
