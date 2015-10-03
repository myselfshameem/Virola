//
//  ChangePasswordViewController.h
//  Catalouge
//
//  Created by Shameem Ahamad on 9/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *view_OldPassword;
@property (weak, nonatomic) IBOutlet UITextField *txt_OldPassword;

@property (weak, nonatomic) IBOutlet UIView *view_NewPassword;
@property (weak, nonatomic) IBOutlet UITextField *txt_NewPassword;

- (IBAction)changePassword:(id)sender;
@end
