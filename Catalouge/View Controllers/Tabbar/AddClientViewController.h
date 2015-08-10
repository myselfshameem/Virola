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

@property (strong, nonatomic) IBOutlet UITextField *txt_Company;
@property (strong, nonatomic) IBOutlet UITextField *txt_Email;
@property (strong, nonatomic) IBOutlet UITextField *txt_ContactPerson;
@property (strong, nonatomic) IBOutlet UITextView  *txt_Address1;
@property (strong, nonatomic) IBOutlet UITextView  *txt_Address2;
@property (strong, nonatomic) IBOutlet UITextField *txt_City;
@property (strong, nonatomic) IBOutlet UITextField *txt_Country;


@property (strong, nonatomic) UIToolbar *toolbar;
/***
 Man nahi kar rha code karne ka....
 FUCK THIS CODE
 ****/

- (IBAction)addClient:(id)sender;

@end
