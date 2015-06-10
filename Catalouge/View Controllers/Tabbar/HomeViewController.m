//
//  HomeViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"

NSString *kDetailedViewControllerID = @"DetailView";    // view controller storyboard id
NSString *kCellID = @"cellID";                          // UICollectionViewCell storyboard id

CustomeAlert *alert;
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINib *cellNib = [UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil];
    [self.CollectionView registerNib:cellNib forCellWithReuseIdentifier:kCellID];
    [self setTitle:@"Home"];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated{

    [self.pageCtrl setNumberOfPages:1];
    [self.pageCtrl setCurrentPage:0];
    [self.pageCtrl setCurrentPageIndicatorTintColor:[UIColor blueColor]];

    [self configureUI];
}
#pragma mark - Configure UI
- (void)configureUI{

    NSArray *arrArticles = [[CXSSqliteHelper sharedSqliteHelper] runQuery:@"SELECT articleid FROM Article_Master" asObject:[Articles class]];
    
    
    NSArray *arrArticlesImaegs = [[CXSSqliteHelper sharedSqliteHelper] runQuery:@"SELECT * FROM Article_Images LIMIT 5" asObject:[Article_Image class]];

    self.arrArticles = [NSMutableArray arrayWithArray:arrArticlesImaegs];
    
    [[self lbl_NumberOfArticles] setText:[NSString stringWithFormat:@"%lu",(unsigned long)[arrArticles count]]];
    
    NSArray *arrClients = [[CXSSqliteHelper sharedSqliteHelper] runQuery:@"SELECT name FROM Client_Master" asObject:[Client_Master class]];

    [[self lbl_NumberOfClients] setText:[NSString stringWithFormat:@"%lu",(unsigned long)[arrClients count]]];
    
    [[self lbl_SyncDate] setText:[NSUserDefaults lastSynTime]];

    [self.pageCtrl setNumberOfPages:[self.arrArticles count]];

    [[self CollectionView] reloadData];


}
- (NSMutableArray*)arrArticles{
    return _arrArticles ? _arrArticles : [[NSMutableArray alloc] init];
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
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [self.arrArticles count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    HomeCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeCollectionViewCell" owner:self options:nil] lastObject];
        
    }

    [[self pageCtrl] setCurrentPage:indexPath.row];

    Article_Image *article = [[self arrArticles] objectAtIndex:indexPath.row];
    NSString *fileName = [article.url lastPathComponent];
    NSString *filePath = [[[AppDataManager sharedAppDatamanager] imageDirPath] stringByAppendingPathComponent:fileName];
    cell.imageCell.image = [UIImage imageWithContentsOfFile:filePath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.frame.size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    
    
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{

    [[self CollectionView] reloadData];
}
#pragma  mark - Sync Data

- (IBAction)syncData:(id)sender{

    
    alert = [[CustomeAlert alloc] init];
    
    [alert showAlertWithTitle:@"Sync" message:@"Would you like to sync your local database?" cancelButtonTitle:@"Sync" otherButtonTitles:@"Cancel" withButtonHandler:^(NSInteger buttonIndex) {
    
        if (buttonIndex == 1 ) {
            
            [self startSync];
            
        }
        
    }];
    
    
    

    

    
}

- (void)startSync{

    //Save Sync Time
    [NSUserDefaults setLastSynTime:@""];
    [self syncRawMaterial];
}

- (void)syncRawMaterial{

    
    [self showActivityIndicator:@"Syncing Raw Material..."];
    [[ApiHandler sharedApiHandler] getRawMaterialApiHandlerWithApiCallBlock:^(id data, NSError *error) {
        
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self hideActivityIndicator];
        });
        
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

}

- (void)syncArticle{
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self showActivityIndicator:@"Syncing Articles..."];
    });

    
    [[ApiHandler sharedApiHandler] getArticlesApiHandlerWithApiCallBlock:^(id data, NSError *error) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self hideActivityIndicator];
        });

        
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

}

- (void)syncClient{
    
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self showActivityIndicator:@"Syncing Clients..."];
    });

    [[ApiHandler sharedApiHandler] getClientsApiHandlerWithApiCallBlock:^(id data, NSError *error) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self hideActivityIndicator];
        });

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
    
}
- (void)syncColor{
 
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self showActivityIndicator:@"Syncing Colors..."];
    });

    [[ApiHandler sharedApiHandler] getColorApiHandlerWithApiCallBlock:^(id data, NSError *error) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self hideActivityIndicator];
        });

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

}

- (void)downloadImages{

    
    
    NSString *imagePath = [[AppDataManager sharedAppDatamanager] imageDirPath];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self showActivityIndicator:@"Syncing article images..."];
    });
    

    
    NSArray *imageArr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:@"Select * From Article_Images" asObject:[Article_Image class]];
    
    
    [imageArr enumerateObjectsUsingBlock:^(Article_Image *obj, NSUInteger idx, BOOL *stop) {
        
        NSString *fileName = [[obj url] lastPathComponent];
//        NSURL *url1 = [NSURL URLWithString:@"http://img6a.flixcart.com/image/shoe/q/f/h/black-lc9230n-lee-cooper-43-400x400-imaefcspgxfhdnry.jpeg"];
        NSURL *url1 = [NSURL URLWithString:[obj url]];
        NSURLRequest *req = [NSURLRequest requestWithURL:url1];
        NSURLResponse *response = nil;
        NSError *error  = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSInteger statusCode = [httpResponse statusCode];
        if (statusCode == 200 && [data length]) {
            [[AppDataManager sharedAppDatamanager]writeDataToImageFileName:fileName withData:data];
        }
    }];
    
    dispatch_sync(dispatch_get_main_queue(), ^{
       
        [self hideActivityIndicator];

        alert = [[CustomeAlert alloc] init];
        [alert showAlertWithTitle:nil message:@"Syncing completed" cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
            
        }];
        
        [self configureUI];

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
@end
