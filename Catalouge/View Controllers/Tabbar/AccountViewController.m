//
//  AccountViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/18/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "AccountViewController.h"
#import "AppDelegate.h"
#import "ApiHandler.h"
#import "MBProgressHUD.h"
#import "MainTabbarController.h"
#import "LoginViewController.h"
#import "ChangePasswordViewController.h"
#define API_SUCCESS_CODE @"200"

CustomeAlert *alert;

@interface AccountViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lbl_Account_Name;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Account_Email;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Account_Contact_Num;
@property (strong, nonatomic) IBOutlet UITextView *txt_Address;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{

    
    [self setTitle:@"Account"];

    User *user = [[[AppDataManager sharedAppDatamanager] account] user];
    [[self lbl_Account_Name] setText:[user username]];
    [[self lbl_Account_Email] setText:[user email]];
    [[self lbl_Account_Contact_Num] setText:[user contactNumber]];
    [[self txt_Address] setText:@""];
    [[self txt_Address] setTextColor:TEXT_COLOR];


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)changePassword:(id)sender {
    
    ChangePasswordViewController *password = [[self storyboard] instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    [[self navigationController] pushViewController:password animated:YES];
    
}

- (IBAction)doLogout:(id)sender {
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:NO];

    [[ApiHandler sharedApiHandler] logoutApiHandlerWithLogoutApiCallBlock:^(id data, NSError *error) {
        
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
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    
                    alert = [[CustomeAlert alloc] init];
                    [alert showAlertWithTitle:@"Logout" message:[data objectForKey:@"message"] cancelButtonTitle:nil otherButtonTitles:@"OK" withButtonHandler:^(NSInteger buttonIndex) {
                    }];

                    [[AppDataManager sharedAppDatamanager] setAccount:nil];
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:(isIPad() ? @"LoginViewController_iPad" : @"LoginViewController")];
                    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:loginViewController];
                    [NSUserDefaults setIsUserLoggedIn:NO];
                    [[AppDataManager sharedAppDatamanager] deleteLoggedInUserDetails];

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
@end
