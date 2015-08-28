//
//  LoginViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "LoginViewController.h"
#import "ApiHandler.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "MainTabbarController.h"
#import "AppDataManager.h"
#import "Account.h"
#define  API_SUCCESS_CODE  @"200"
CustomeAlert *alert;
@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txt_Fld_UserName;
@property (weak, nonatomic) IBOutlet UITextField *Txt_Fld_Pwd;
@property (weak, nonatomic) IBOutlet UIButton *btn_Login;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Txt_Fld_Pwd.delegate = self;
    self.txt_Fld_UserName.delegate = self;
    
    NSString *versionName = [NSString stringWithFormat:@"Version - %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    NSString *versionNameBuild = [NSString stringWithFormat:@"Build Version - %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];

    [[self lbl_Version] setText:versionName];
    [[self lbl_Build_Version] setText:versionNameBuild];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{

//    if ([[UIDevice currentDevice] ]) {
//        
//    }

}
- (IBAction)doLogin:(id)sender {
    
    if (isIPad()) {
        
        
    }
    //Success
    NSLog(@"USER Name = %@",self.txt_Fld_UserName.text);
    NSLog(@"USER PWD = %@",self.Txt_Fld_Pwd.text);
    [[self Txt_Fld_Pwd] resignFirstResponder];
    [[self txt_Fld_UserName] resignFirstResponder];

    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[ApiHandler sharedApiHandler] loginApiHandlerWithUserName:self.txt_Fld_UserName.text password:self.Txt_Fld_Pwd.text LoginApiCallBlock:^(id data, NSError *error) {
        
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
        });
        
        
        if (error) {
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                alert = [[CustomeAlert alloc] init];
                [alert showAlertWithTitle:nil message:@"Error in network connection." cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                }];
            
            });


        }else{
        
            if ([[data objectForKey:@"errorcode"] isEqualToString:API_SUCCESS_CODE]) {
                
                
                Account *account = [[Account alloc] initWithDictionary:data];
                [[AppDataManager sharedAppDatamanager] setAccount:account];
                [[AppDataManager sharedAppDatamanager] saveLoggedInUserDetails:account];
                dispatch_sync(dispatch_get_main_queue(), ^{

                    
//                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                    MainTabbarController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainTabbarController"];
//                    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:loginViewController];
                    
                    
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    MainTabbarController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainTabbarController"];
                    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:loginViewController];

                    
                });


                
            }else{
                //Show Alert
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    alert = [[CustomeAlert alloc] init];
                    [alert showAlertWithTitle:nil message:[data objectForKey:@"message"] cancelButtonTitle:@"Ok" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                    }];
                });

            }
            
            
        }
        
        
        
    }];
    
    
}
- (IBAction)doForgetPwd:(id)sender {
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];

    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{

    [textField nextResponder];

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
