//
//  ArticleMasterViewController.h
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleMasterViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtField_barcode;
@property (strong, nonatomic) IBOutlet UITextField *txtField_QRCode;
@property (strong, nonatomic) IBOutlet UITextField *txtField_ArticleId;
@property (strong, nonatomic) IBOutlet UITextField *txtField_Last;
@property (strong, nonatomic) IBOutlet UITextField *txtField_Sole;

@property (assign, nonatomic) UITextField *common_TxtField;
- (IBAction)barcodeScanner:(id)sender;
- (IBAction)browseArticle:(id)sender;
@end
