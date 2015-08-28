//
//  NewDevelopmentCtrl.m
//  Catalouge
//
//  Created by Shameem Ahamad on 8/4/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "NewDevelopmentCtrl.h"
#import <AVFoundation/AVFoundation.h>
#import "RawMatarialCell.h"
#import "LeatherLiningTableViewCell.h"
#import "LastSoleTableViewCell.h"
#import "SearchViewController.h"
#import "AddMoreLeatherTableViewCell.h"
#import "BottomTableViewCell.h"
#import "CartViewController.h"
#import "UIImage+Resize.h"
@interface NewDevelopmentCtrl ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) TrxTransaction *localTransaction;

@end

@implementation NewDevelopmentCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.localTransaction = [[AppDataManager sharedAppDatamanager] transaction];
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        // do your logic
    } else if(authStatus == AVAuthorizationStatusDenied){
        // denied
    } else if(authStatus == AVAuthorizationStatusRestricted){
        // restricted, normally won't happen
    } else if(authStatus == AVAuthorizationStatusNotDetermined){
        // not determined?!
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){
                NSLog(@"Granted access to %@", AVMediaTypeVideo);
            } else {
                NSLog(@"Not granted access to %@", AVMediaTypeVideo);
            }
        }];
    } else {
        // impossible, unknown authorization status
    }

    
    [self imageThumbView].layer.cornerRadius = 3;
    [self imageThumbView].layer.borderWidth = 1;
    [self imageThumbView].layer.borderColor = [UIColor blackColor].CGColor;
    self.tblMain.delegate = self;
    self.tblMain.dataSource = self;
    self.tblMain.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)openCamera:(id)sender{


    [self performSelectorOnMainThread:@selector(openCameraMainThread) withObject:nil waitUntilDone:NO];
    
    

}
- (void)openCameraMainThread{

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
        myAlertView = nil;
        return;
    }
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.showsCameraControls = YES;
    [self presentViewController:picker animated:YES completion:NULL];

}
#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];

    [self.activityIndicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        //self.imageView.image = chosenImage;
        UIImage *newImage =  [UIImage imageWithImage:chosenImage scaledToSize:CGSizeMake(320, 568)];
        
        NSData *data = UIImagePNGRepresentation(newImage);
        
        NSString *filePath = [NSString stringWithFormat:@"%@/%@.png",[[AppDataManager sharedAppDatamanager] DevelopmentImageDir],[[[AppDataManager sharedAppDatamanager] transaction] TransactionId]];
        
        [[AppDataManager sharedAppDatamanager]writeDataToImageFileName:filePath withData:data];
        
        [data writeToFile:filePath atomically:YES];
        [[[AppDataManager sharedAppDatamanager] transaction] setTakeAPicturePath:filePath];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[self imageThumb] setImage:newImage];
            [self.activityIndicator stopAnimating];

        });

    });
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self.activityIndicator stopAnimating];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    TrxTransaction *localTrx = [[AppDataManager sharedAppDatamanager] transaction];

    if (tableView == [self tblLeather]){
    
        NSInteger count = [[localTrx rawmaterialsForLeathers] count];
        return count;

    }
    
    else if(tableView == [self tblLining]){
        
        NSInteger count = [[localTrx rawmaterialsForLinings] count];
        return count;
        
    }
    else
        return 3;
}

- (float)calculateHeightOfRow{

    TrxTransaction *localTrx = [[AppDataManager sharedAppDatamanager] transaction];

    NSInteger liningCount = [[localTrx rawmaterialsForLinings] count];
    NSInteger leatherCount = [[localTrx rawmaterialsForLeathers] count];
    NSInteger totalCount = 0;
    if (liningCount == 0 && leatherCount == 0) {
        
        totalCount = 1;
    }else{
        liningCount > leatherCount ? (totalCount = liningCount  ): (totalCount = leatherCount );

    }
    
    
    float height = 130.0*totalCount+40;

    return height;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == [self tblMain]) {
        
        if (indexPath.row == 0) {
            return 210;
        }else if (indexPath.row == 1){
            return [self calculateHeightOfRow];
        }else if (indexPath.row == 2){
            return 490;
        }

    }
    
    return 130;
    
}
- (RawMatarialCell*)cellForTbl_RawMatarial:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
    static NSString *FirstCell  = @"FirstCell";
    static NSString *bottomTableViewCellIdentifier   = @"BottomTableViewCell";
    
    id cell = nil;
   if(indexPath.row == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"LastSoleCell"];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LastSoleTableViewCell" owner:self options:nil] objectAtIndex:1];
            [cell initilizeCell];
        }

       TrxTransaction *localTxr = [[AppDataManager sharedAppDatamanager] transaction];
       [[(LastSoleTableViewCell*)cell txt_Last] setText:localTxr.last.lastname];
       [[(LastSoleTableViewCell*)cell txt_Sole] setText:localTxr.Sole.name];
       [[(LastSoleTableViewCell*)cell txt_SoleColor] setText:localTxr.Sole.colors.colorname];
       [[(LastSoleTableViewCell*)cell txt_SoleMatarial] setText:localTxr.SoleMaterial.name];

       [cell callbackForDropdown:^(LastSoleTableViewCell *cell, NSInteger tag) {
          
           switch (tag) {
               
               case 1:{
                   //Last
               
                   [self showActivityIndicator:@"Fetching Lasts..."];
                   SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
                   [search registerOptionSelectionCallback:^(id selectedData) {
                       
                       [[[AppDataManager sharedAppDatamanager] transaction] setLast:(Lasts*)selectedData];
                       cell.txt_Last.text = [(Lasts*)selectedData lastname];
                       
                       
                   }];

                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                       search.tag = LAST_SELECTION;
                       search.arr_Common_List = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:@"SELECT * FROM Lasts_Master" asObject:[Lasts class]] mutableCopy];
                       
                       
                       dispatch_async(dispatch_get_main_queue(), ^{
                           
                           [self hideActivityIndicator];
                           [[self navigationController] pushViewController:search animated:YES];

                           
                       });
                   });
                   

                   
               }
                   break;
               case 2:{
                   //Sole
               
                   
                   [self showActivityIndicator:@"Fetching Sole..."];
                   
                   SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
                   [search registerOptionSelectionCallback:^(id selectedData) {
                       
                       [[[AppDataManager sharedAppDatamanager] transaction] setSole:(Rawmaterials*)selectedData];
                       cell.txt_Sole.text = [(Rawmaterials*)selectedData name];
                       cell.txt_SoleColor.text = [[(Rawmaterials*)selectedData colors] colorname];
                       
                       
                   }];

                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                       
                       search.tag = SOLE_SELECTION;
                       
                       search.arr_Common_List = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '10' GROUP BY name" asObject:[Rawmaterials class]] mutableCopy];

                       dispatch_async(dispatch_get_main_queue(), ^{
                           
                           [self hideActivityIndicator];
                           [[self navigationController] pushViewController:search animated:YES];
                           
                           
                       });
                   });

                   

               
               }
                   break;
               case 3:{
                   //Sole Color
                   
                   SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
                   search.tag = SOLE_COLOR_SELECTION;
                   
                   NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '10' and name = '%@'",[[[[AppDataManager sharedAppDatamanager] transaction] Sole] name]];

                   search.arr_Common_List = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]] mutableCopy];
                   [search registerOptionSelectionCallback:^(id selectedData) {
                       
                       [[[AppDataManager sharedAppDatamanager] transaction] setSole:(Rawmaterials*)selectedData];
                       cell.txt_Sole.text = [(Rawmaterials*)selectedData name];
                       cell.txt_SoleColor.text = [[(Rawmaterials*)selectedData colors] colorname];
                       
                       
                   }];
                   
                   [[self navigationController] pushViewController:search animated:YES];

               }
                   break;
               case 4:{
                   //Sole Material
               
                   
                   [self showActivityIndicator:@"Fetching Sole Materials..."];

                   SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
                   [search registerOptionSelectionCallback:^(id selectedData) {
                       
                       [[[AppDataManager sharedAppDatamanager] transaction] setSoleMaterial:(Rawmaterials*)selectedData];
                       cell.txt_SoleMatarial.text = [(Rawmaterials*)selectedData name];
                       
                   }];
                   
                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

                       search.tag = SOLE_SELECTION;
                       
                       search.arr_Common_List = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '23' GROUP BY name" asObject:[Rawmaterials class]] mutableCopy];

                   dispatch_async(dispatch_get_main_queue(), ^{
                       
                       [self hideActivityIndicator];
                       [[self navigationController] pushViewController:search animated:YES];
                       
                       
                   });
               });

               
               }
                   break;

               default:
                   break;
           }
           
           
           
       }];
       
   }
   else if (indexPath.row == 1) {
       
       cell = [tableView dequeueReusableCellWithIdentifier:FirstCell];
       
       if (!cell) {
           cell = [[[NSBundle mainBundle] loadNibNamed:@"RawMatarialCell" owner:self options:nil] firstObject];
           
       }
       self.tblLeather = [(RawMatarialCell*)cell tbl_AddLeather];
       
       self.tblLining = [(RawMatarialCell*)cell tbl_AddLining];
       
   }else if (indexPath.row == 2){
   
       cell = (BottomTableViewCell*)[tableView dequeueReusableCellWithIdentifier:bottomTableViewCellIdentifier];
       
       if (!cell) {
           cell = [[[NSBundle mainBundle] loadNibNamed:@"BottomTableViewCell" owner:self options:nil] objectAtIndex:0];
           [cell initilizeCell];
       }
       
       TrxTransaction *localTxr = [[AppDataManager sharedAppDatamanager] transaction];
       [[(BottomTableViewCell*)cell txt_Qty] setText:localTxr.qty];
       [[(BottomTableViewCell*)cell txt_Pair] setText:localTxr.qty_unit];
       [[(BottomTableViewCell*)cell txt_Size] setText:localTxr.size];
       [[(BottomTableViewCell*)cell txt_Remarks] setText:localTxr.remark];
       [cell registerCallbackForQtyPairSize:^(__weak BottomTableViewCell *cell, NSInteger tag) {
           
           switch (tag) {
                   
               case 1:{
                   //Last
                   
                   SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
                   search.tag = QTY_SELECTION;
                   search.arr_Common_List = [[AppDataManager sharedAppDatamanager] quantityOption];
                   [search registerOptionSelectionCallback:^(id selectedData) {
                       
                       [[[AppDataManager sharedAppDatamanager] transaction] setLast:(Lasts*)selectedData];
                       cell.txt_Qty.text = selectedData;
                       
                   }];
                   
                   [[self navigationController] pushViewController:search animated:YES];
                   
               }
                   break;
               case 2:{
                   //Sole
                   
                   SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
                   search.tag = PAIR_SELECTION;
                   
                   search.arr_Common_List = [NSMutableArray arrayWithObjects:@"ODD",@"PAIR", nil];
                   [search registerOptionSelectionCallback:^(id selectedData) {
                       
                       [[[AppDataManager sharedAppDatamanager] transaction] setSole:(Rawmaterials*)selectedData];
                       cell.txt_Pair.text = selectedData;
                   }];
                   
                   [[self navigationController] pushViewController:search animated:YES];
                   
                   
               }
                   break;
               case 3:{
                   //Sole Color
                   
                   SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
                   search.tag = SIZE_SELECTION;
                   
                   
                   search.arr_Common_List = [[AppDataManager sharedAppDatamanager] getSizeArr];
                   [search registerOptionSelectionCallback:^(id selectedData) {
                       
                       [[[AppDataManager sharedAppDatamanager] transaction] setSize:selectedData];

                       cell.txt_Size.text = selectedData;
                   }];
                   
                   [[self navigationController] pushViewController:search animated:YES];
                   
               }
                   break;
                   
               default:
                   break;
           }
           
           
           
       }];

       
       //Add To Cart Callback
       __block __weak NewDevelopmentCtrl *weakSelf = self;
       [cell registerCallbackForAddToCart:^{
           
//           CartViewController *cart =  [[weakSelf storyboard] instantiateViewControllerWithIdentifier:@"CartViewController"];
//           [[weakSelf navigationController] pushViewController:cart animated:YES];
           
           [[weakSelf tabBarController] setSelectedIndex:3];
       }];

       
   }
    
    return cell;
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if ((tableView == [self tblLeather]) || (tableView == [self tblLining]))
        return 40.0;

    return 0.0;

}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    
    if (tableView == [self tblLeather]) {
        AddMoreLeatherTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"AddMoreLeatherTableViewCell" owner:self options:nil] firstObject];
       
        [cell.lblTitle setAdjustsFontSizeToFitWidth:YES];
        [cell.lblTitle setText:@"Add more Leather"];
        [cell callbackForDropdown:^(AddMoreLeatherTableViewCell *__weak cell, NSInteger tag) {
            
            Rawmaterials *raw = [[Rawmaterials alloc] init];
            [[AppDataManager sharedAppDatamanager] addRawMaterialLeather:raw];
            [[self tblMain] reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
            [[self tblLeather] reloadData];
            [[self tblLining] reloadData];

        }];
        return cell;
    }else if (tableView == [self tblLining]) {
        AddMoreLeatherTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"AddMoreLeatherTableViewCell" owner:self options:nil] firstObject];
        [cell.lblTitle setAdjustsFontSizeToFitWidth:YES];
        [cell.lblTitle setText:@"Add more Lining"];

        [cell callbackForDropdown:^(AddMoreLeatherTableViewCell *__weak cell, NSInteger tag) {
            
            Rawmaterials *raw = [[Rawmaterials alloc] init];
            [[AppDataManager sharedAppDatamanager] addRawMaterialLining:raw];
            [[self tblMain] reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
            [[self tblLeather] reloadData];
            [[self tblLining] reloadData];

            
        }];
        return cell;
    }


    return nil;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __block TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];

    
    if (tableView == [self tblMain])
        return [self cellForTbl_RawMatarial:tableView cellForRowAtIndexPath:indexPath];
    
    
    if(tableView == [self tblLeather]){
        
        
        
            static NSString *FirstCell = @"LeatherCell";
            
            LeatherLiningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FirstCell];
            
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"LeatherLiningTableViewCell" owner:self options:nil] firstObject];
                [cell initilizeCell];
            }
            Rawmaterials *rawMaterial = [[local rawmaterialsForLeathers] objectAtIndex:indexPath.row];
            cell.lbl_Title1.text = [NSString stringWithFormat:@"Leather %i",indexPath.row+1];
            cell.lbl_Title2.text = [NSString stringWithFormat:@"Leather %i Color",indexPath.row+1];
            cell.txt_1.placeholder = [NSString stringWithFormat:@"Leather %i",indexPath.row+1];
            cell.txt_2.placeholder = [NSString stringWithFormat:@"Leather %i Color",indexPath.row+1];
            cell.txt_1.text = rawMaterial.name;
            cell.txt_2.text = rawMaterial.colors.colorname;
        cell.indexOfCell = indexPath.row;
        
        [cell callbackForDropdown:^(LeatherLiningTableViewCell *__weak cell , NSInteger tag, NSInteger indexOfCelllocal) {
            
            __block NSInteger indexOfCell = indexOfCelllocal;
            
            Rawmaterials *rawMaterial = [[local rawmaterialsForLeathers] objectAtIndex:indexOfCell];
            
            
            SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
            
            if (tag == 1) {
                
                [self showActivityIndicator:@"Fetching Leathers..."];

                [search registerOptionSelectionCallback:^(id selectedData) {
                    
                    [[local rawmaterialsForLeathers] replaceObjectAtIndex:indexOfCell withObject:selectedData];
                    
                    cell.txt_1.text = [(Rawmaterials*)selectedData name];
                    cell.txt_2.text = [[(Rawmaterials*)selectedData colors] colorname];
                    
                }];

                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    search.tag = LEATHER_SELECTION;
                    search.arr_Common_List = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '1' GROUP BY name" asObject:[Rawmaterials class]] mutableCopy];

                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self hideActivityIndicator];
                        [[self navigationController] pushViewController:search animated:YES];
                        
                        
                    });
                });

                
                
                
            }else{
                
                search.tag = LEATHER_COLOR_SELECTION;
                
                NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '1' and name = '%@' ",[rawMaterial name]];
                search.arr_Common_List = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]] mutableCopy];
                [search registerOptionSelectionCallback:^(id selectedData) {
                    
                    [[local rawmaterialsForLeathers] replaceObjectAtIndex:indexOfCell withObject:selectedData];
                    cell.txt_2.text = [[(Rawmaterials*)selectedData colors] colorname];
                    
                }];
                [[self navigationController] pushViewController:search animated:YES];

            }
            
            
            
            
            
            
        }];
        
        
            return cell;
        
    }else {

        static NSString *FirstCell = @"LeatherCell";
        
        LeatherLiningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FirstCell];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LeatherLiningTableViewCell" owner:self options:nil] firstObject];
            [cell initilizeCell];
        }
        
            Rawmaterials *rawMaterial = [[[[AppDataManager sharedAppDatamanager] transaction] rawmaterialsForLinings] objectAtIndex:indexPath.row];
            cell.lbl_Title1.text = [NSString stringWithFormat:@"Lining %i",indexPath.row+1];
            cell.lbl_Title2.text = [NSString stringWithFormat:@"Lining %i Color",indexPath.row+1];
            cell.txt_1.placeholder = [NSString stringWithFormat:@"Lining %i",indexPath.row+1];
            cell.txt_2.placeholder = [NSString stringWithFormat:@"Lining %i Color",indexPath.row+1];
            cell.txt_1.text = rawMaterial.name;
            cell.txt_2.text = rawMaterial.colors.colorname;
            cell.rawmaterials = rawMaterial;
            cell.indexOfCell = indexPath.row;
        [cell callbackForDropdown:^(LeatherLiningTableViewCell *__weak cell , NSInteger tag, NSInteger indexOfCell) {
            

            
            __block TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
            Rawmaterials *rawMaterial = [[local rawmaterialsForLinings] objectAtIndex:indexOfCell];

            
            SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
            
            if (tag == 1) {
                search.tag = LEATHER_SELECTION;
                [search registerOptionSelectionCallback:^(id selectedData) {
                    
                    [[local rawmaterialsForLinings] replaceObjectAtIndex:indexOfCell withObject:selectedData];
                    
                    cell.txt_1.text = [(Rawmaterials*)selectedData name];
                    cell.txt_2.text = [[(Rawmaterials*)selectedData colors] colorname];
                    
                }];
                
                
                
                [self showActivityIndicator:@"Fetching Linings..."];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    search.arr_Common_List = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '12' GROUP BY name" asObject:[Rawmaterials class]] mutableCopy];

                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self hideActivityIndicator];
                        [[self navigationController] pushViewController:search animated:YES];
                        
                        
                    });
                });

                

            }else{
                search.tag = LEATHER_COLOR_SELECTION;
               
                NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '12' and name = '%@' ",[rawMaterial name]];
                search.arr_Common_List = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]] mutableCopy];
                [search registerOptionSelectionCallback:^(id selectedData) {
                    
                    [[local rawmaterialsForLinings] replaceObjectAtIndex:indexOfCell withObject:selectedData];
                    cell.txt_2.text = [[(Rawmaterials*)selectedData colors] colorname];
                    
                }];

                [[self navigationController] pushViewController:search animated:YES];

            }
            
            

            
            
            
        }];
        
        return cell;
    }
        
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
