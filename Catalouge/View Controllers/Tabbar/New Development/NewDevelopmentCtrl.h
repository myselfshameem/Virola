//
//  NewDevelopmentCtrl.h
//  Catalouge
//
//  Created by Shameem Ahamad on 8/4/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewDevelopmentCtrl : UIViewController

@property(nonatomic,strong) IBOutlet UIButton *cameraBtn;
@property(nonatomic,strong) IBOutlet UIImageView *imageThumb;
@property(nonatomic,strong) IBOutlet UIView *imageThumbView;
@property(nonatomic,strong) IBOutlet UITableView *tblMain;
@property(nonatomic,strong) IBOutlet UITableView *tblLeather;
@property(nonatomic,strong) IBOutlet UITableView *tblLining;

- (IBAction)openCamera:(id)sender;

@end
