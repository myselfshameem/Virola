//
//  CustomeAlert.h
//  Catalouge
//
//  Created by Shameem Ahamad on 5/21/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CustomeAlert : NSObject<UIAlertViewDelegate>


typedef void (^AlertButtonPressedCallBlock)(NSInteger buttonIndex);
@property(nonatomic,strong) AlertButtonPressedCallBlock alertButtonPressedCallBlock;
@property(nonatomic,strong) UIAlertView *alertView;


- (void)showAlertWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles withButtonHandler:(AlertButtonPressedCallBlock)alertButtonPressedCallBlock;

@end
