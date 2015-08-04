//
//  ClientViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "SyncTableViewCell.h"
#import "SyncViewController.h"
CustomeAlert *alert;
@interface SyncViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSArray *arr_Clients;
@property(nonatomic,strong) NSOperationQueue *synQueue;
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

    
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"Sync" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"MyriadPro-Regular" size:18],NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    [[self btn_Sync] setAttributedTitle:string forState:UIControlStateNormal];

    [self setTitle:@"Sync"];
    
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"Select All" style:UIBarButtonItemStyleBordered target:self action:@selector(selectAllSyn)];
    [bar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"MyriadPro-Regular" size:16],NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [[self navigationItem] setRightBarButtonItem:bar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateProgress:) name:PROGRESS_COUNT object:nil];
    
    [[self lbl_ProgressHeader] setText:@""];
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
    
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    SyncTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SyncableViewCell" owner:self options:nil] firstObject];
    }

    switch (indexPath.row) {
        case 0:
            cell.lblClient_Name.text = @"Sync Raw Rawmaterials";
            break;
        case 1:
            cell.lblClient_Name.text = @"Sync Articles";
            break;
        case 2:
            cell.lblClient_Name.text = @"Sync Colors";
            break;
        case 3:
            cell.lblClient_Name.text = @"Sync Clients";
            break;

        case 4:
            cell.lblClient_Name.text = @"Sync Article Images";
            break;

        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    SyncTableViewCell *cell = (SyncTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.checkBox.selected = !cell.checkBox.selected;
    
}

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
    [[self synQueue] addOperationWithBlock:^{
        [self syncRawMaterial];
    }];
    
}

- (void)syncRawMaterial{
    
    
    SyncTableViewCell *cell = (SyncTableViewCell*)[[self tbl_Clients] cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    
    if ([[cell checkBox] isSelected]) {
        
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[self lbl_ProgressHeader ] setText:@"Syncing Raw Material..."];
        });
        
        [[ApiHandler sharedApiHandler] getRawMaterialApiHandlerWithApiCallBlock:^(id data, NSError *error) {
            
            if (error) {
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
    
    
    SyncTableViewCell *cell = (SyncTableViewCell*)[[self tbl_Clients] cellForRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
    
    if ([[cell checkBox] isSelected]) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[self lbl_ProgressHeader ] setText:@"Syncing Articles..."];
        });

        [[ApiHandler sharedApiHandler] getArticlesApiHandlerWithApiCallBlock:^(id data, NSError *error) {
            
            
            if (error) {
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
    
    
    SyncTableViewCell *cell = (SyncTableViewCell*)[[self tbl_Clients] cellForRowAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0]];
    
    if ([[cell checkBox] isSelected]) {
      
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[self lbl_ProgressHeader ] setText:@"Syncing Clients..."];
        });
        
        [[ApiHandler sharedApiHandler] getClientsApiHandlerWithApiCallBlock:^(id data, NSError *error) {
            
            
            if (error) {
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
    
    
    
    
    SyncTableViewCell *cell = (SyncTableViewCell*)[[self tbl_Clients] cellForRowAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]];
    
    if ([[cell checkBox] isSelected]) {
        
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[self lbl_ProgressHeader ] setText:@"Syncing Colors..."];
        });

        [[ApiHandler sharedApiHandler] getColorApiHandlerWithApiCallBlock:^(id data, NSError *error) {
            
            
            if (error) {
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
    
    SyncTableViewCell *cell = (SyncTableViewCell*)[[self tbl_Clients] cellForRowAtIndexPath:[NSIndexPath indexPathForItem:4 inSection:0]];
    
    if ([[cell checkBox] isSelected]){
    
        NSString *imagePath = [[AppDataManager sharedAppDatamanager] imageDirPath];
        [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[self lbl_ProgressHeader ] setText:@"Syncing article images..."];
        });
        
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
            
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                float filledValue = idx/[imageArr count];
                [[self progressView] setProgress:filledValue animated:YES];
            });

            
        }];

        
    }else{
    
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self hideActivityIndicator];
            
            alert = [[CustomeAlert alloc] init];
            [alert showAlertWithTitle:nil message:@"Syncing completed" cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                
            }];
        });
        [[self lbl_ProgressHeader] setText:@""];
        
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
    
    [[[self tbl_Clients] visibleCells] enumerateObjectsUsingBlock:^(SyncTableViewCell *cell, NSUInteger idx, BOOL *stop) {
        
        if ([[right title] isEqualToString:@"Deselect All"]) {
            
            [cell.checkBox setSelected:YES];
 
        }else{
        
            [cell.checkBox setSelected:NO];

        }
    }];


}


- (void)updateProgress:(NSNotification*)notif{

    NSDictionary *dict = [notif object];
    
    
    float totalRecords = [[dict objectForKey:@"totalRecords"] floatValue];
    float totalInsertedRecords = [[dict objectForKey:@"totalInsertedRecords"] floatValue];
    
    float filledValue = totalInsertedRecords/totalRecords;
    
    [[self progressView] setProgress:filledValue animated:YES];
    
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
