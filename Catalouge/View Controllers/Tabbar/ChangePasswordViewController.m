//
//  ChangePasswordViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 9/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "ChangePasswordViewController.h"

@implementation ChangePasswordViewController
- (void)viewDidLoad{

//    self.navigationItem.hidesBackButton = NO;
    
    self.title = @"Change Password";
    self.view_OldPassword.layer.cornerRadius = 20;
    self.view_NewPassword.layer.cornerRadius = 20;
    self.view_NewPassword.layer.cornerRadius = 20;
    self.view_OldPassword.layer.cornerRadius = 20;
    CGColorRef borderColor = [UIColor grayColor].CGColor;
    self.view_OldPassword.layer.borderColor = borderColor;
    self.view_NewPassword.layer.borderColor = borderColor;
    self.view_NewPassword.layer.borderWidth = 1;
    self.view_OldPassword.layer.borderWidth = 1;


}


- (IBAction)changePassword:(id)sender{

    
    ChangePasswordViewController __weak *wealSelf = self;
    
    NSString *oldPassword = [[[self txt_OldPassword] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *newPassword = [[[self txt_NewPassword] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if ([newPassword length] && [oldPassword length]) {
     
        [self showActivityIndicator:@"Please wait..."];

        [[ApiHandler sharedApiHandler] changePassword:^(id rawdata, NSError *error) {
            
            dispatch_sync(dispatch_get_main_queue(), ^{
               
                [self hideActivityIndicator];
                
                id data = [NSJSONSerialization JSONObjectWithData:rawdata options:NSJSONReadingMutableContainers error:nil];
                if (error) {
                    
                    UIAlertView *alertAview = [[UIAlertView alloc] initWithTitle:@"Virola" message:@"Error in network connection." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alertAview show];
                    alertAview = nil;
                    
                    return ;
                }
                
                
                if ([data isKindOfClass:[NSDictionary class]] && [[data objectForKey:@"errorcode"] isEqualToString:@"225"]) {
                    
                    UIAlertView *alertAview = [[UIAlertView alloc] initWithTitle:@"Virola" message:[data objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alertAview show];
                    alertAview = nil;
                    
                    [[wealSelf navigationController] popViewControllerAnimated:YES];
                    return;
                }
                
                UIAlertView *alertAview = [[UIAlertView alloc] initWithTitle:@"Virola" message:[data objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alertAview show];
                alertAview = nil;

                
            });
            

            
            
        } withOldPassword:oldPassword andNewPassword:newPassword];

    }else{
    
        UIAlertView *alertAview = [[UIAlertView alloc] initWithTitle:@"Virola" message:@"Please fill all the details" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertAview show];
        alertAview = nil;
    
    }
    

}

- (void)showActivityIndicator:(NSString*)msg{
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:msg];
    
    
}

- (void)hideActivityIndicator{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}

@end
