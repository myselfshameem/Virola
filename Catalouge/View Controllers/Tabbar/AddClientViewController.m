//
//  AddClientViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "AddClientViewController.h"
CustomeAlert *alert;

@interface AddClientViewController ()
@property (weak, nonatomic) IBOutlet UIView *view_Name;
@property (weak, nonatomic) IBOutlet UIView *view_EmailAddress;
@property (weak, nonatomic) IBOutlet UIView *view_ContactNumber;
@property (weak, nonatomic) IBOutlet UIView *view_Address;
@property (weak, nonatomic) IBOutlet UIView *view_Address1;
@property (weak, nonatomic) IBOutlet UIView *view_State;
@property (weak, nonatomic) IBOutlet UIView *view_Country;
@end

@implementation AddClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view_Name.layer.cornerRadius = 20;
    self.view_EmailAddress.layer.cornerRadius = 20;
    self.view_ContactNumber.layer.cornerRadius = 20;
    self.view_Address.layer.cornerRadius = 20;
    self.view_Address1.layer.cornerRadius = 20;

    self.view_State.layer.cornerRadius = 20;
    self.view_Country.layer.cornerRadius = 20;
    self.btn_AddClient.layer.cornerRadius = 18;

    CGColorRef borderColor = [UIColor grayColor].CGColor;
    self.view_Name.layer.borderColor = borderColor;
    self.view_EmailAddress.layer.borderColor = borderColor;
    self.view_ContactNumber.layer.borderColor = borderColor;
    self.view_Address.layer.borderColor = borderColor;
    self.view_Address1.layer.borderColor = borderColor;

    self.view_State.layer.borderColor = borderColor;
    self.view_Country.layer.borderColor = borderColor;
    //self.btn_AddClient.layer.borderColor = borderColor;

    self.view_Name.layer.borderWidth = 1;
    self.view_EmailAddress.layer.borderWidth = 1;
    self.view_ContactNumber.layer.borderWidth = 1;
    self.view_Address.layer.borderWidth = 1;
    self.view_Address1.layer.borderWidth = 1;

    self.view_State.layer.borderWidth = 1;
    self.view_Country.layer.borderWidth = 1;
    //self.btn_AddClient.layer.borderWidth = 1;

    [self setTitle:@"Add New Client"];
    
    [self refreshUI];

}

- (Clients*)client{

    if (!_client) {
        _client = [[Clients alloc] init];
    }
    return _client;
}


- (UIToolbar*)toolbar{
    
    if (!_toolbar) {

        _toolbar = [[[NSBundle mainBundle] loadNibNamed:@"ToolbarForKeyBoard" owner:self options:nil] firstObject];
        UIBarButtonItem *last = [[_toolbar items] lastObject];
        [last setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"MyriadPro-Regular" size:18],NSFontAttributeName, nil] forState:UIControlStateNormal];
        [last setTarget:self];
        [last setAction:@selector(DoneInput)];
    }
    
    return _toolbar;
}

- (void)refreshUI{

    [[self txt_Company] setText:[[self client] company]];
    [[self txt_Email] setText:[[self client] email]];
    [[self txt_ContactPerson] setText:[[self client] contactperson]];
    [[self txt_Address1] setText:[[self client] address1]];
    [[self txt_Address2] setText:[[self client] address2]];
    [[self txt_City] setText:[[self client] country]];
    [[self txt_Country] setText:[[self client] city]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

      [textField setTintColor:[UIColor blueColor]];
    return YES;
}       // return NO to disallow editing.
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField nextResponder];
    
    [self updateClientModelData:textField];
    
}

- (void)updateClientModelData:(UITextField*)textField{

    switch ([textField tag]) {
        case 1:
            self.client.company = textField.text;
            break;
        case 2:
             self.client.contactperson = textField.text;

            break;
        case 3:
             self.client.email = textField.text;

            break;
        case 6:
            self.client.city = textField.text;

            break;
        case 7:
             self.client.country = textField.text;
            
            break;

        default:
            break;
    }

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    
    
    return YES;
    
}


#pragma mark - UITextView delegates
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
   
    [textView setTintColor:[UIColor blueColor]];

    textView.inputAccessoryView = self.toolbar;
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    return YES;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{

    if ([textView tag] == 4) {
        self.client.address1 = textView.text;

    }else{
        self.client.address2 = textView.text;

    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - AddClient 
- (IBAction)addClient:(id)sender{

    [[self txt_Email] resignFirstResponder];
    
    //Save into DB
    if ([[[self client] company] length]) {
        
        

        [self showActivityIndicator:@"Adding Client..."];
        
        [[ApiHandler sharedApiHandler] addClientsApiHandlerWithApiCallBlock:^(id data, NSError *error) {
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [self hideActivityIndicator];
            });

            
            if (error) {
                
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    alert = [[CustomeAlert alloc] init];
                    [alert showAlertWithTitle:nil message:@"Error in connection." cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                    }];

                });

            }else{
            
                dispatch_sync(dispatch_get_main_queue(), ^{
                    alert = [[CustomeAlert alloc] init];
                    [alert showAlertWithTitle:nil message:[data objectForKey:@"message"] cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                        
                        [[self navigationController] popViewControllerAnimated:YES];
                        
                    }];
                });

            }
            
            
        } withClient:self.client];
        
    }else{
    
        //Error
        
        alert = [[CustomeAlert alloc] init];
        [alert showAlertWithTitle:nil message:@"Company can not be left blank." cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
           
            
        }];
        
    }
    
    
    

}


#pragma mark - Toolbar
- (void)DoneInput{
    
    [[self txt_Address2] resignFirstResponder];
    [[self txt_Address1] resignFirstResponder];
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
