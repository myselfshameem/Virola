//
//  igViewController.h
//  ScanBarCodes
//
//  Created by Torrey Betts on 10/10/13.
//  Copyright (c) 2013 Infragistics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface igViewController : UIViewController
typedef void(^BarcodeScanned)(NSString *barcodeString);

@property(nonatomic,strong) BarcodeScanned barcodeScanned;

- (void)barcodeScanned:(BarcodeScanned)barcodeScanned;
@end