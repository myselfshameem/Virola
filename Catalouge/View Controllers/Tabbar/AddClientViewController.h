//
//  AddClientViewController.h
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddClientViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *btn_AddClient;
@property (strong, nonatomic) Clients *client;
@property (assign, nonatomic) BOOL isNewClient;

@property (strong, nonatomic) IBOutlet UITextField *txt_Name;
@property (strong, nonatomic) IBOutlet UITextField *txt_Email;
@property (strong, nonatomic) IBOutlet UITextField *txt_ContactNum;
@property (strong, nonatomic) IBOutlet UITextView *txt_Address;
@property (strong, nonatomic) IBOutlet UITextField *txt_Country;
@property (strong, nonatomic) IBOutlet UITextField *txt_State;


@property (strong, nonatomic) UIToolbar *toolbar;
/***
 Man nahi kar rha code karne ka....
 FUCK THIS CODE
 ****/

- (IBAction)addClient:(id)sender;

@end
