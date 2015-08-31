//
//  ClientViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "SyncTableViewCell.h"
#import "SyncViewController.h"
#import "SynModelClass.h"

CustomeAlert *alert;
@interface SyncViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSArray *arr_Clients;
@property(nonatomic,strong) NSOperationQueue *synQueue;
@property(nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation SyncViewController

- (NSOperationQueue*)synQueue{

    if (!_synQueue) {
        
        _synQueue = [[NSOperationQueue alloc] init];
        [_synQueue setName:@"com.virola.syncQueue"];
    }
    
    return _synQueue;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.btn_Sync.layer.cornerRadius = 18;
    self.progressView.trackTintColor = [UIColor whiteColor];
    self.progressView.alpha = 0;
    CGRect rect = [self progressView].frame;
    rect.size.height = 20;
    [self progressView].frame = rect;
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"Sync" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"MyriadPro-Regular" size:18],NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    [[self btn_Sync] setAttributedTitle:string forState:UIControlStateNormal];

    [self setTitle:@"Sync"];
    
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"Select All" style:UIBarButtonItemStyleBordered target:self action:@selector(selectAllSyn)];
    [bar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"MyriadPro-Regular" size:16],NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [[self navigationItem] setRightBarButtonItem:bar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateProgress:) name:PROGRESS_COUNT object:nil];
    
    [[self lbl_ProgressHeader] setText:@""];
}

- (NSMutableArray*)dataArray{

    if (!_dataArray) {
       
        _dataArray = [[NSMutableArray alloc] init];
       
        SynModelClass *Raw = [[SynModelClass alloc] init];
        [Raw setCellTitle:@"Sync Raw Rawmaterials"];
        [Raw setSelectedFlag:[NSNumber numberWithBool:NO]];
        
        SynModelClass *Articles = [[SynModelClass alloc] init];
        [Articles setCellTitle:@"Sync Articles"];
        [Articles setSelectedFlag:[NSNumber numberWithBool:NO]];
        
        SynModelClass *Colors = [[SynModelClass alloc] init];
        [Colors setCellTitle:@"Sync Colors"];
        [Colors setSelectedFlag:[NSNumber numberWithBool:NO]];
        
        
        SynModelClass *Clients = [[SynModelClass alloc] init];
        [Clients setCellTitle:@"Sync Clients"];
        [Clients setSelectedFlag:[NSNumber numberWithBool:NO]];
        
        SynModelClass *Images = [[SynModelClass alloc] init];
        [Images setCellTitle:@"Sync Article Images"];
        [Images setSelectedFlag:[NSNumber numberWithBool:NO]];
        
        SynModelClass *Shipping = [[SynModelClass alloc] init];
        [Shipping setCellTitle:@"Sync Payment & Shipping Terms"];
        [Shipping setSelectedFlag:[NSNumber numberWithBool:NO]];
        
        SynModelClass *Orders = [[SynModelClass alloc] init];
        [Orders setCellTitle:@"Sync Orders"];
        [Orders setSelectedFlag:[NSNumber numberWithBool:NO]];
        
        
        
        
        [_dataArray addObject:Raw];
        [_dataArray addObject:Articles];
        [_dataArray addObject:Colors];
        [_dataArray addObject:Clients];
        [_dataArray addObject:Images];
        [_dataArray addObject:Shipping];
        [_dataArray addObject:Orders];

    }
    
    return _dataArray;
}
- (void)viewWillAppear:(BOOL)animated{
    
    
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



#pragma mark - TableView
#pragma mark   Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self dataArray] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"SyncTableViewCellIdentifier";
    SyncTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SyncableViewCell" owner:self options:nil] firstObject];
    }

    SynModelClass *sync = [[self dataArray] objectAtIndex:indexPath.row];
    cell.synModel = sync;
    cell.lblClient_Name.text = [sync cellTitle];
    cell.checkBox.selected = [[sync selectedFlag] boolValue];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
//    SyncTableViewCell *cell = (SyncTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
//    SynModelClass *synClass = [[self dataArray] objectAtIndex:indexPath.row];
//    BOOL flag = ![[synClass selectedFlag] boolValue];
//    [synClass setSelectedFlag:[NSNumber numberWithBool:flag]];
//    cell.checkBox.selected = flag;
    
}



#pragma mark - Sync
- (IBAction)startSync:(id)sender{

    alert = [[CustomeAlert alloc] init];
    
    [alert showAlertWithTitle:@"Sync" message:@"Would you like to sync your local database?" cancelButtonTitle:@"Sync" otherButtonTitles:@"Cancel" withButtonHandler:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 1 ) {
            
            [self startSync];
            
        }
        
    }];
}

- (void)startSync{
    
    [[self synQueue] cancelAllOperations];
    //Save Sync Time
    [NSUserDefaults setLastSynTime:@""];
    self.progressView.alpha = 1.0;
    [self enableView:NO];
    [[self synQueue] addOperationWithBlock:^{
        [self syncRawMaterial];
    }];
    
}

- (void)syncRawMaterial{
    
    
    SynModelClass *synClass = [[self dataArray] objectAtIndex:0];
    
    if ([[synClass selectedFlag] boolValue]) {
        

        [[ApiHandler sharedApiHandler] getRawMaterialApiHandlerWithApiCallBlock:^(id data, NSError *error) {
            
            if (error) {
               
                [self errorWhileSynching];

                dispatch_sync(dispatch_get_main_queue(), ^{
                    alert = [[CustomeAlert alloc] init];
                    [alert showAlertWithTitle:nil message:@"Error in Syncing Raw Material." cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                        
                        
                    }];
                    
                });
                return ;
            }else{
                
                
                NSString *successCode = [data objectForKey:@"errorcode"];
                NSString *message = [data objectForKey:@"message"];
                
                if (([successCode isEqualToString:@"200"] || [successCode isEqualToString:@"823"])) {
                    [self syncArticle];
                }else{
                    
                    [self errorWhileSynching];

                    dispatch_sync(dispatch_get_main_queue(), ^{
                        alert = [[CustomeAlert alloc] init];
                        [alert showAlertWithTitle:nil message:message cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                            
                        }];
                        
                    });
                    return;
                }
                
            }
            
        }];
    }else{
    
        [self syncArticle];
    }
    
    
    
}

- (void)syncArticle{
    
    
    SynModelClass *synClass = [[self dataArray] objectAtIndex:1];
    
    if ([[synClass selectedFlag] boolValue]) {
        


        [[ApiHandler sharedApiHandler] getArticlesApiHandlerWithApiCallBlock:^(id data, NSError *error) {
            
            
            if (error) {
                [self errorWhileSynching];

                dispatch_sync(dispatch_get_main_queue(), ^{
                    alert = [[CustomeAlert alloc] init];
                    [alert showAlertWithTitle:nil message:@"Error in Syncing." cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                        
                    }];
                    
                });
                return ;
            }else{
                
                
                NSString *successCode = [data objectForKey:@"errorcode"];
                NSString *message = [data objectForKey:@"message"];
                if (([successCode isEqualToString:@"200"] || [successCode isEqualToString:@"823"])) {
                    [self syncClient];
                }else{

                    [self errorWhileSynching];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        alert = [[CustomeAlert alloc] init];
                        [alert showAlertWithTitle:nil message:message cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                            
                        }];
                        
                    });
                    return;
                }
                
            }
            
            
            
            
        }];
    }else{
        
        [self syncClient];
    
    }
    
    
    
    
    
    
}
- (void)syncClient{
    
    
    SynModelClass *synClass = [[self dataArray] objectAtIndex:2];
    
    if ([[synClass selectedFlag] boolValue]) {
      

        [[ApiHandler sharedApiHandler] getClientsApiHandlerWithApiCallBlock:^(id data, NSError *error) {
            
            
            if (error) {
               
                [self errorWhileSynching];

                dispatch_sync(dispatch_get_main_queue(), ^{
                    alert = [[CustomeAlert alloc] init];
                    [alert showAlertWithTitle:nil message:@"Error in Syncing." cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                        
                    }];
                    
                });
                return ;
            }else{
                
                
                NSString *successCode = [data objectForKey:@"errorcode"];
                NSString *message = [data objectForKey:@"message"];
                if (([successCode isEqualToString:@"200"] || [successCode isEqualToString:@"823"])) {
                    [self syncColor];
                }else{
                    
                   
                    [self errorWhileSynching];

                    dispatch_sync(dispatch_get_main_queue(), ^{
                        alert = [[CustomeAlert alloc] init];
                        [alert showAlertWithTitle:nil message:message cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                            
                        }];
                        
                    });
                    return;
                }
                
            }
            
        }];
    
    }else{
    
    
        [self syncColor];
    }
  
    
}
- (void)syncColor{
    
    
    
    
    SynModelClass *synClass = [[self dataArray] objectAtIndex:3];
    
    if ([[synClass selectedFlag] boolValue]) {
        
        

        [[ApiHandler sharedApiHandler] getColorApiHandlerWithApiCallBlock:^(id data, NSError *error) {
            

            if (error) {
                [self errorWhileSynching];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    alert = [[CustomeAlert alloc] init];
                    [alert showAlertWithTitle:nil message:@"Error in Syncing." cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                        
                    }];
                    
                });
                return ;
            }else{
                
                
                NSString *successCode = [data objectForKey:@"errorcode"];
                NSString *message = [data objectForKey:@"message"];
                if (([successCode isEqualToString:@"200"] || [successCode isEqualToString:@"823"])) {
                    [self downloadImages];
                
                }else{
                    
                    [self errorWhileSynching];

                    dispatch_sync(dispatch_get_main_queue(), ^{
                        alert = [[CustomeAlert alloc] init];
                        [alert showAlertWithTitle:nil message:message cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                            
                        }];
                        
                    });
                    return;
                }
                
            }
            
        }];
    }else{
    
        [self downloadImages];
    }
    
   
    
}
- (void)downloadImages{
    
    SynModelClass *synClass = [[self dataArray] objectAtIndex:4];
    
    if ([[synClass selectedFlag] boolValue]) {
    

        [[NSNotificationCenter defaultCenter] postNotificationName:PROGRESS_COUNT object:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:0],@"totalRecords",[NSNumber numberWithInteger:0],@"totalInsertedRecords",@"Fetching Article Images...",@"Title", nil]];

        NSString *imagePath = [[AppDataManager sharedAppDatamanager] imageDirPath];
        [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
        
        NSArray *imageArr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:@"Select * From Article_Images" asObject:[Article_Image class]];
        
        
        [imageArr enumerateObjectsUsingBlock:^(Article_Image *obj, NSUInteger idx, BOOL *stop) {
            
            NSString *fileName = [[obj imagePath] lastPathComponent];
            //        NSURL *url1 = [NSURL URLWithString:@"http://img6a.flixcart.com/image/shoe/q/f/h/black-lc9230n-lee-cooper-43-400x400-imaefcspgxfhdnry.jpeg"];
            NSURL *url1 = [NSURL URLWithString:[obj imagePath]];
            NSURLRequest *req = [NSURLRequest requestWithURL:url1];
            NSURLResponse *response = nil;
            NSError *error  = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSInteger statusCode = [httpResponse statusCode];
            if (statusCode == 200 && [data length]) {
                [[AppDataManager sharedAppDatamanager]writeDataToImageFileName:fileName withData:data];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:PROGRESS_COUNT object:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:[imageArr count]],@"totalRecords",[NSNumber numberWithInteger:idx],@"totalInsertedRecords",@"Fetching Article Images...",@"Title", nil]];
            
        }];
        
        [self synPayment_Shipping_Terms];
    }else{
    
        
        [self synPayment_Shipping_Terms];
    }
    
    
    
}

- (void)synPayment_Shipping_Terms{
    
    
    SynModelClass *synClass = [[self dataArray] objectAtIndex:5];
    
    if ([[synClass selectedFlag] boolValue]) {
        

        [[ApiHandler sharedApiHandler] getPaymentShippingTermsApiHandlerWithApiCallBlock:^(id data, NSError *error) {
            

            if (error) {
                
                [self errorWhileSynching];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    alert = [[CustomeAlert alloc] init];
                    [alert showAlertWithTitle:nil message:@"Error in Syncing." cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                        
                    }];
                    
                });
                return ;
            }else{
                
                
                NSString *successCode = [data objectForKey:@"errorcode"];
                NSString *message = [data objectForKey:@"message"];
                if (([successCode isEqualToString:@"200"] || [successCode isEqualToString:@"823"])) {

                    
                    [self synOrders];

                    
                }else{
                    
                    [self errorWhileSynching];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        alert = [[CustomeAlert alloc] init];
                        [alert showAlertWithTitle:nil message:message cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                            
                        }];
                        
                    });
                    return;
                }
                
            }
            
            
            
            
        }];
    }else{
        
        [self synOrders];
        
    }
    
    
    
    
    
    
}


- (void)synOrders{

    SynModelClass *synClass = [[self dataArray] objectAtIndex:6];
    
    if ([[synClass selectedFlag] boolValue]) {
        
        
        [[ApiHandler sharedApiHandler] getOrdersApiHandlerWithApiCallBlock:^(id data, NSError *error) {
            
            
            if (error) {
                
                [self errorWhileSynching];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    alert = [[CustomeAlert alloc] init];
                    [alert showAlertWithTitle:nil message:@"Error in Syncing." cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                        
                    }];
                    
                });
                return ;
            }else{
                
                
                NSString *successCode = [data objectForKey:@"errorcode"];
                NSString *message = [data objectForKey:@"message"];
                if (([successCode isEqualToString:@"200"] || [successCode isEqualToString:@"823"])) {
                    
                    
                    [self errorWhileSynching];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        alert = [[CustomeAlert alloc] init];
                        [alert showAlertWithTitle:nil message:@"Syncing completed" cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                            
                        }];
                        [[self lbl_ProgressHeader] setText:@""];
                        [[self progressView] setProgress:0 animated:NO];
                    });
                    
                    
                }else{
                    
                    [self errorWhileSynching];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        alert = [[CustomeAlert alloc] init];
                        [alert showAlertWithTitle:nil message:message cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                            
                        }];
                        
                    });
                    return;
                }
                
            }
            
            
            
            
        }];
    }else{
    
        
        [self errorWhileSynching];
        dispatch_sync(dispatch_get_main_queue(), ^{
            alert = [[CustomeAlert alloc] init];
            [alert showAlertWithTitle:nil message:@"Syncing completed" cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                
            }];
        });

    }
}

- (void)selectAllSyn{

    UIBarButtonItem *right = [[self navigationItem] rightBarButtonItem];
    
    NSString *titel = [right title];
    
    if ([titel isEqualToString:@"Select All"]) {
        [right setTitle:@"Deselect All"];
    }else{
        [right setTitle:@"Select All"];
    }
    
    
    [[self dataArray] enumerateObjectsUsingBlock:^(SynModelClass *obj, NSUInteger idx, BOOL *stop) {
        
        if ([[right title] isEqualToString:@"Deselect All"])
            [obj setSelectedFlag:[NSNumber numberWithBool:YES]];
        else
            [obj setSelectedFlag:[NSNumber numberWithBool:NO]];

        
        
    }];
    

    [[self tbl_Clients] reloadData];
}


#pragma mark - Activity Indicator
- (void)updateProgress:(NSNotification*)notif{

    NSDictionary *dict = [notif object];
    
    
    float totalRecords = [[dict objectForKey:@"totalRecords"] floatValue];
    float totalInsertedRecords = [[dict objectForKey:@"totalInsertedRecords"] floatValue];
    NSString *title = [dict objectForKey:@"Title"];

    float filledValue = 0.0f;
    if (totalRecords != 0) {
        filledValue = totalInsertedRecords/totalRecords;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self progressView] setProgress:filledValue animated:NO];
        [[self lbl_ProgressHeader] setText:title];
    });
    
}
- (void)showActivityIndicator:(NSString*)msg{
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:msg];
    
    
}
- (void)hideActivityIndicator{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}
- (void)enableView:(BOOL)flag{

//    [[[self navigationItem] backBarButtonItem] setEnabled:flag];
//    [[[self navigationItem] rightBarButtonItem] setEnabled:flag];
//    [[self tbl_Clients] setUserInteractionEnabled:flag];
//    [[self btn_Sync] setEnabled:flag];
//    [[self tabBarItem] setEnabled:flag];

}

- (void)errorWhileSynching{


    if ([NSOperationQueue currentQueue] == [NSOperationQueue mainQueue]) {
        
        [[self progressView] setProgress:0 animated:NO];
        [[self progressView] setAlpha:0];
        [[self lbl_ProgressHeader] setText:@""];

    }else{
    
    
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[self progressView] setProgress:0 animated:NO];
            [[self progressView] setAlpha:0];
            [[self lbl_ProgressHeader] setText:@""];
        });

    }
}


@end
