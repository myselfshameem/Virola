//
//  CustomeAlert.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/21/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "CustomeAlert.h"

@implementation CustomeAlert
@synthesize alertView = _alert;

- (void)showAlertWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles withButtonHandler:(AlertButtonPressedCallBlock)alertButtonPressedCallBlock{

    _alertButtonPressedCallBlock = alertButtonPressedCallBlock;
    self.alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:otherButtonTitles otherButtonTitles:cancelButtonTitle,nil];
    [self.alertView show];
    

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    _alertButtonPressedCallBlock ? _alertButtonPressedCallBlock(buttonIndex) : @"";

}






@end
