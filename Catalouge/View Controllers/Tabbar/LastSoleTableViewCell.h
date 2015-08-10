//
//  LastSoleTableViewCell.h
//  Catalouge
//
//  Created by Shameem Ahamad on 8/7/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LastSoleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_Last;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Sole;
@property (weak, nonatomic) IBOutlet UILabel *lbl_SoleColor;
@property (weak, nonatomic) IBOutlet UILabel *lbl_SoleMatarial;
@property (weak, nonatomic) IBOutlet UIView *vw_Last;
@property (weak, nonatomic) IBOutlet UIView *vw_Sole;
@property (weak, nonatomic) IBOutlet UIView *vw_SoleColor;
@property (weak, nonatomic) IBOutlet UIView *vw_SoleMatarial;
@property (weak, nonatomic) IBOutlet UITextField *txt_Last;
@property (weak, nonatomic) IBOutlet UITextField *txt_Sole;
@property (weak, nonatomic) IBOutlet UITextField *txt_SoleColor;
@property (weak, nonatomic) IBOutlet UITextField *txt_SoleMatarial;


@property (nonatomic,strong) Lasts *last;
@property (nonatomic,strong) Rawmaterials *Sole;
@property (nonatomic,strong) Rawmaterials *SoleMaterial;





typedef void(^CallbackForLastSole)(__weak LastSoleTableViewCell *cell, NSInteger tag);
@property (strong, nonatomic) CallbackForLastSole callbackForLastSole;

- (void)callbackForDropdown:(CallbackForLastSole)callback;
- (IBAction)dropDwonSelected:(id)sender;
@end
