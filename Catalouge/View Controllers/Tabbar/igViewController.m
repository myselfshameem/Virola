//
//  igViewController.m
//  ScanBarCodes
//
//  Created by Torrey Betts on 10/10/13.
//  Copyright (c) 2013 Infragistics. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "igViewController.h"
#import "AddToCartViewController.h"
CustomeAlert *alert;
@interface igViewController () <AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *_session;
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureVideoPreviewLayer *_prevLayer;

    UIView *_highlightView;
    UILabel *_label;
}
@end

@implementation igViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _highlightView = [[UIView alloc] init];
    _highlightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _highlightView.layer.borderColor = [UIColor greenColor].CGColor;
    _highlightView.layer.borderWidth = 3;
    [self.view addSubview:_highlightView];

    _label = [[UILabel alloc] init];
    _label.frame = CGRectMake(0, self.view.bounds.size.height - 29-64, self.view.bounds.size.width, 40);
    _label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _label.backgroundColor = [UIColor colorWithWhite:0.15 alpha:0.65];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"";
    [self.view addSubview:_label];

    _session = [[AVCaptureSession alloc] init];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;

    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (_input) {
        [_session addInput:_input];
    } else {
        NSLog(@"Error: %@", error);
    }

    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_output];

    _output.metadataObjectTypes = [_output availableMetadataObjectTypes];

    _prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _prevLayer.frame = self.view.bounds;
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:_prevLayer];

    [_session startRunning];

    [self.view bringSubviewToFront:_highlightView];
    [self.view bringSubviewToFront:_label];
    
    
    [self setTitle:@"Barcode Scanner"];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
            AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
            AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];

    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[_prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                highlightViewRect = barCodeObject.bounds;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }

        if (detectionString != nil)
        {
            
            [_session stopRunning];

            //_label.text = detectionString;
            
            if (self.barcodeTYpe == QR_CODE) {
                
                NSArray *arr = [detectionString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
                if ([arr count]) {
                    
                    NSArray *newArr = [[arr lastObject] componentsSeparatedByString:@":"];
                    if ([newArr count]) {
                        detectionString = [[newArr lastObject] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        _label.text = detectionString;
                    }else{
                    
                        alert = [[CustomeAlert alloc] init];
                        [alert showAlertWithTitle:nil message:[NSString stringWithFormat:@"Article not found for Scanned Barcode : [%@]",detectionString] cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                            
                            [[self navigationController] popViewControllerAnimated:YES];
                            
                        }];

                        
                    }

                }else{
                
                    alert = [[CustomeAlert alloc] init];
                    [alert showAlertWithTitle:nil message:[NSString stringWithFormat:@"Article not found for Scanned Barcode : [%@]",detectionString] cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                        
                        [[self navigationController] popViewControllerAnimated:YES];
                        
                    }];

                    
                }
            }
            
            NSArray *arr = [[CXSSqliteHelper sharedSqliteHelper]runQuery:[NSString stringWithFormat:@"SELECT * FROM Article_Master WHERE articleid='%@'",detectionString] asObject:[Articles class]];
            
            if ([arr count]) {
                
                Articles *article = [arr firstObject];
                [self showActivityIndicator:@"Loading Article..."];

                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                    
                    AddToCartViewController *addToCartViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"AddToCartViewController"];
                    [[AppDataManager sharedAppDatamanager] newTransactionWithArticleId:article.articleid withNewDevelopment:NO];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [self hideActivityIndicator];
                            
                            [self.navigationController pushViewController:addToCartViewController animated:YES];
                            
                            
                        });
                    
                });
                
                
                
            }else{
                
                alert = [[CustomeAlert alloc] init];
                [alert showAlertWithTitle:nil message:[NSString stringWithFormat:@"Article not found for Scanned Barcode : [%@]",detectionString] cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                    
                    [[self navigationController] popViewControllerAnimated:YES];
                    
                }];
                
            }

            
            
            break;
        }
        else
            _label.text = @"";
    }

    _highlightView.frame = highlightViewRect;
}

- (void)barcodeScanned:(BarcodeScanned)barcodeScanned1{
    _barcodeScanned = barcodeScanned1;
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