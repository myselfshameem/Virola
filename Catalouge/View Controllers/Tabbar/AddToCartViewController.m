
//
//  AddToCartViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/22/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "AddToCartViewController.h"
#import "HomeCollectionViewCell.h"
#import "RelatedProductTableViewCell.h"
#import "ClientViewController.h"
#import "TrxTransaction.h"
#import "CartViewController.h"
#import "SearchViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+Resize.h"

#import "RawMatarialCell.h"
#import "LeatherLiningTableViewCell.h"
#import "LastSoleTableViewCell.h"
#import "SearchViewController.h"
#import "AddMoreLeatherTableViewCell.h"
#import "BottomTableViewCell.h"

#import "JTSImageInfo.h"
#import "JTSImageViewController.h"
#define TRY_AN_ANIMATED_GIF 0







@interface AddToCartViewController ()
@end

@implementation AddToCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    UINib *cellNib = [UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil];
    [self.CollectionView registerNib:cellNib forCellWithReuseIdentifier:kCellID];
    [self.pageCtrl setNumberOfPages:5];
    [self.pageCtrl setCurrentPage:0];
    [self.pageCtrl setCurrentPageIndicatorTintColor:[UIColor blueColor]];
    [[self pageCtrl] setBackgroundColor:[UIColor clearColor]];
    [self setTitle:@"Article"];
    
    self.lbl_ArticlePrice_EURO.layer.cornerRadius = 5;
    self.lbl_ArticlePrice_EURO.clipsToBounds = YES;

    self.lbl_ArticlePrice_GBP.layer.cornerRadius = 5;
    self.lbl_ArticlePrice_GBP.clipsToBounds = YES;

    
    self.lbl_ArticlePrice_USD.layer.cornerRadius = 5;
    self.lbl_ArticlePrice_USD.clipsToBounds = YES;

    
    
    [[self tbl_RawMatarial] setBackgroundColor:[UIColor whiteColor]];
    
    [[self navigationItem] setLeftBarButtonItem:[[AppDataManager sharedAppDatamanager] backBarButtonWithTitle:@"  Back" target:self selector:@selector(backbtnPressed)]];
    
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

    
    
}
- (void)backbtnPressed{

    [[[self navigationController] viewControllers] enumerateObjectsUsingBlock:^(UIViewController   *obj, NSUInteger idx, BOOL *stop) {
        [[self navigationController] popToRootViewControllerAnimated:YES];
    }];
}
- (void)refreshUI{
    
    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
    Articles *article = [local article];

    [[self lbl_Title] setText:[article articlename]];
    [[self lbl_ArticleName] setText:[article articlename]];

    [[self lbl_ArticlePrice_EURO] setText:[NSString stringWithFormat:@"€%@",[article price]]];
    [[self lbl_ArticlePrice_GBP] setText:[NSString stringWithFormat:@"£%@",[article price_gbp]]];
    [[self lbl_ArticlePrice_USD] setText:[NSString stringWithFormat:@"$%@",[article price_usd]]];

    
    NSArray *img_arr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:[NSString stringWithFormat:@"SELECT * FROM Article_Images WHERE articleid = '%@'",local.articleid] asObject:[Article_Image class]];
    self.article_Images = [NSMutableArray arrayWithArray:img_arr];
    
    [self.pageCtrl setNumberOfPages:[self.article_Images count]];
    
    
    [[self relatedProduct] reloadData];
    [[self tbl_RawMatarial] reloadData];
    [[self tblLeather] reloadData];
    [[self tblLining] reloadData];

}

- (void)disableView:(UIView*)view1{
    [view1 setUserInteractionEnabled:NO];
    [view1 setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.20]];
}
- (void)setCornerForView:(UIView*)view1{

    CGColorRef borderColor = [UIColor grayColor].CGColor;

    view1.layer.cornerRadius = 0;
    borderColor = [UIColor grayColor].CGColor;
    view1.layer.borderColor = borderColor;
    view1.layer.borderWidth = 1.5;

    
}


- (void)viewWillAppear:(BOOL)animated{
    
    CGRect frame = self.dargView.frame;
    frame.origin.x = -200;
    [[self dargView] setFrame:frame];
    [[self relatedProduct] setHidden:YES];
    
    [self refreshArticleList:@""];
    [self refreshUI];
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
    return [self.article_Images count];
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

//    Article_Image *article = [[self article_Images] objectAtIndex:indexPath.row];
//    NSString *fileName = [article.imagePath lastPathComponent];
//    NSString *filePath = [[[AppDataManager sharedAppDatamanager] imageDirPath] stringByAppendingPathComponent:fileName];
    
    NSString *imageFilePath = [[[AppDataManager sharedAppDatamanager] fetchNewDevelopmentImageDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",[[[AppDataManager sharedAppDatamanager] transaction] TransactionId]]];
    cell.imageCell.image = [UIImage imageWithContentsOfFile:imageFilePath];

    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.frame.size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HomeCollectionViewCell *cell = (HomeCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    // Create image info
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    imageInfo.image = cell.imageCell.image;
    imageInfo.referenceRect = cell.imageCell.frame;
    imageInfo.referenceView = cell.imageCell.superview;
    imageInfo.referenceContentMode = cell.imageCell.contentMode;
    imageInfo.referenceCornerRadius = cell.imageCell.layer.cornerRadius;
    
    // Setup view controller
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:self transition:JTSImageViewControllerTransition_FromOriginalPosition];

    
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    [[self CollectionView] reloadData];
}
- (BOOL)shouldAutorotate{

    return YES;
}
- (NSUInteger)supportedInterfaceOrientations{

    if (isIPad()) {
        
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait ;
}










#pragma mark - Related Product Section
#pragma mark - More Btn
- (IBAction)tapOnRelatedBtn:(id)sender{
    
    __block CGRect frame = self.dargView.frame;
    
    if ([sender tag] == 0) {
        
        [sender setTag:1];
        [[self relatedProduct] setHidden:NO];
        [UIView animateWithDuration:0.5 animations:^{
            
            frame.origin.x = 0;
            [[self dargView] setFrame:frame];
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        
    }else{
        
        [sender setTag:0];
        [UIView animateWithDuration:0.5 animations:^{
            
            frame.origin.x = -200;
            [[self dargView] setFrame:frame];
            
        } completion:^(BOOL finished) {
            
            [[self relatedProduct] setHidden:YES];
            
        }];
        
        
    }
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    TrxTransaction *localTrx = [[AppDataManager sharedAppDatamanager] transaction];

    if (tableView == [self relatedProduct])
        return [self.arrArticles count];
    
    else if (tableView == [self tblLeather]){
        
        NSInteger count = [[localTrx rawmaterialsForLeathers] count];
        return count;
        
    }else if(tableView == [self tblLining]){
        
        NSInteger count = [[localTrx rawmaterialsForLinings] count];
        return count;
        
    }
    
    
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
    
    
    float height = 130.0*totalCount;
    
    return height;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == [self tbl_RawMatarial]) {
        
        if (indexPath.row == 0) {
            return 210;
        }else if (indexPath.row == 1){
            return [self calculateHeightOfRow];
        }else if (indexPath.row == 2){
            return 490;
        }
        
    }else if ((tableView == [self tblLeather]) || (tableView == [self tblLining])){
        
        return 130;
        
    }
    
    return 146;

}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (tableView == [self tbl_RawMatarial])
        return [self cellForTbl_RawMatarial:tableView cellForRowAtIndexPath:indexPath];
    
    
    if(tableView == [self tblLeather]){
        
        
        
        static NSString *FirstCell = @"LeatherCell";
        
        LeatherLiningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FirstCell];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LeatherLiningTableViewCell" owner:self options:nil] firstObject];
            [cell initilizeCell];
        }
        Rawmaterials *rawMaterial = [[[[AppDataManager sharedAppDatamanager] transaction] rawmaterialsForLeathers] objectAtIndex:indexPath.row];
        cell.lbl_Title1.text = [NSString stringWithFormat:@"Leather %i",indexPath.row+1];
        cell.lbl_Title2.text = [NSString stringWithFormat:@"Leather %i Color",indexPath.row+1];
        cell.txt_1.placeholder = [NSString stringWithFormat:@"Leather %i",indexPath.row+1];
        cell.txt_2.placeholder = [NSString stringWithFormat:@"Leather %i Color",indexPath.row+1];
        cell.txt_1.text = rawMaterial.name;
        cell.txt_2.text = rawMaterial.colors.colorname;
        cell.indexOfCell = indexPath.row;

        
        [cell callbackForDropdown:^(LeatherLiningTableViewCell *__weak cell , NSInteger tag, NSInteger indexOfCell) {
            
            
            
            __block TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
            Rawmaterials *rawMaterial = [[local rawmaterialsForLeathers] objectAtIndex:indexOfCell];
            
            
            SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
            
            if (tag == 1) {
                
                search.tag = LEATHER_SELECTION;
                [search registerOptionSelectionCallback:^(id selectedData) {
                    
                    [[local rawmaterialsForLeathers] replaceObjectAtIndex:indexOfCell withObject:selectedData];
                    
                    cell.txt_1.text = [(Rawmaterials*)selectedData name];
                    cell.txt_2.text = [[(Rawmaterials*)selectedData colors] colorname];
                    
                }];
                
                
                [self showActivityIndicator:@"Fetching Leathers..."];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
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
        
    }else if(tableView == self.tblLining){
        
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
                
                [search registerOptionSelectionCallback:^(id selectedData) {
                    
                    [[local rawmaterialsForLinings] replaceObjectAtIndex:indexOfCell withObject:selectedData];
                    
                    cell.txt_1.text = [(Rawmaterials*)selectedData name];
                    cell.txt_2.text = [[(Rawmaterials*)selectedData colors] colorname];
                    
                }];
                
                
                
                [self showActivityIndicator:@"Fetching Linings..."];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    search.tag = LEATHER_SELECTION;
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
    }else{
        
        static NSString *ReleatedcellIdentifier = @"ReleatedCell";
        RelatedProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ReleatedcellIdentifier];
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RelatedProductTableViewCell" owner:self options:nil] firstObject];
            [cell initilizeCell];
        }
        Articles *article = [[self arrArticles] objectAtIndex:indexPath.row];
        cell.lbl_Title.text = [article articlename];
        cell.lbl_Description.text = [NSString stringWithFormat:@"Article No.: %@",[article articleid]];
        cell.lbl_Price.text = [NSString stringWithFormat:@"€%@",[article price]];
        
        cell.backgroundColor = [UIColor clearColor];
        Article_Image *articleImage = [article.images firstObject];
        if (articleImage) {
            NSString *fileName = [articleImage.imagePath lastPathComponent];
            NSString *filePath = [[[AppDataManager sharedAppDatamanager] imageDirPath] stringByAppendingPathComponent:fileName];
            cell.imgV_Logo.image = [UIImage imageWithContentsOfFile:filePath];
            
        }else{
            
            cell.imgV_Logo = nil;
        }
        return cell;
    }
 
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
        if ([[localTxr isnew] isEqualToString:@"1"]) {
            [[(LastSoleTableViewCell*)cell txt_Socks] setText:localTxr.socksMaterialNew.name];
            [[(LastSoleTableViewCell*)cell txt_SocksColors] setText:localTxr.socksMaterialNew.colors.colorname];
 
        }else{
            [[(LastSoleTableViewCell*)cell txt_Socks] setText:localTxr.socksMaterial.rawmaterialname];
            [[(LastSoleTableViewCell*)cell txt_SocksColors] setText:localTxr.socksMaterial.colors.colorname];

        }

        
        [cell callbackForDropdown:^(LastSoleTableViewCell *cell, NSInteger tag) {
            
            switch (tag) {
                    
                case 1:{
                    //Last
                    
                    
                    
                    SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
                    search.tag = LAST_SELECTION;

                    [search registerOptionSelectionCallback:^(id selectedData) {
                        
                        [[[AppDataManager sharedAppDatamanager] transaction] setLast:(Lasts*)selectedData];
                        cell.txt_Last.text = [(Lasts*)selectedData lastname];
                        
                        
                    }];

                    
                    [self showActivityIndicator:@"Fetching Lasts..."];
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
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
                    
                    SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
                    search.tag = SOLE_SELECTION;
                    [search registerOptionSelectionCallback:^(id selectedData) {
                        
                        [[[AppDataManager sharedAppDatamanager] transaction] setSole:(Rawmaterials*)selectedData];
                        cell.txt_Sole.text = [(Rawmaterials*)selectedData name];
                        cell.txt_SoleColor.text = [[(Rawmaterials*)selectedData colors] colorname];
                        
                        
                    }];

                    
                    
                    
                    [self showActivityIndicator:@"Fetching Sole..."];
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
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
                    
                    SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
                    search.tag = SOLE_SELECTION;
                    
                    [search registerOptionSelectionCallback:^(id selectedData) {
                        
                        [[[AppDataManager sharedAppDatamanager] transaction] setSoleMaterial:(Rawmaterials*)selectedData];
                        cell.txt_SoleMatarial.text = [(Rawmaterials*)selectedData name];
                        
                    }];
                    
                    
                    [self showActivityIndicator:@"Fetching Sole Materials..."];
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        search.arr_Common_List = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '23' GROUP BY name" asObject:[Rawmaterials class]] mutableCopy];

                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [self hideActivityIndicator];
                            [[self navigationController] pushViewController:search animated:YES];
                            
                            
                        });
                    });
                    
                    
                }
                    break;
                case 5:{
                    
                    //SOCK_SELECTION
                    [self showActivityIndicator:@"Fetching Socks..."];
                    
                    SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
                    
                    [search registerOptionSelectionCallback:^(id selectedData) {
                        
                        [[[AppDataManager sharedAppDatamanager] transaction] setSocksMaterial:selectedData];
                        cell.txt_Socks.text = [(ArticlesRawmaterials*)selectedData insraw];
                        
                        //TODO::
                        cell.txt_SocksColors.text = [[(ArticlesRawmaterials*)selectedData colors] colorname];

                    }];
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        search.tag = SOCK_SELECTION;
                        
                        search.arr_Common_List = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:@"SELECT distinct * FROM Article_Rawmaterials WHERE (rawmaterialgroupid = '12' AND (insraw = 'SOCK FULL' OR insraw = 'SOCK HALF' OR insraw = 'SOCK FULL - PRINTED LEATHER HOLE OPTIC' OR insraw = 'SOCK HALF - PRINTED LEATHER HOLE OPTIC' OR insraw = 'INSOLE COVER'))" asObject:[ArticlesRawmaterials class]] mutableCopy];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [self hideActivityIndicator];
                            [[self navigationController] pushViewController:search animated:YES];
                            
                            
                        });
                    });
                    
                    
                }
                    break;
                    
                case 6:{
                    
                    
                    if (![[[AppDataManager sharedAppDatamanager] transaction] socksMaterial]) {
                        
                        return ;
                    }
                    
                    
                    
                    //SOCK_COLOR_SELECTION
                    [self showActivityIndicator:@"Fetching Socks Colors..."];
                    
                    SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
                    
                    [search registerOptionSelectionCallback:^(id selectedData) {
                        
                        [[[AppDataManager sharedAppDatamanager] transaction] setSocksMaterial:selectedData];
                        cell.txt_Socks.text = [(ArticlesRawmaterials*)selectedData insraw];
                        cell.txt_SocksColors.text = [[(ArticlesRawmaterials*)selectedData colors] colorname];
                        
                    }];
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        search.tag = SOCK_COLOR_SELECTION;
                        
                        //TODO::
                        ArticlesRawmaterials *sockMaterials = [[[AppDataManager sharedAppDatamanager] transaction] socksMaterial];
                        
                        NSString *colorQuery = [NSString stringWithFormat:@"SELECT DISTINCT * FROM Article_Rawmaterials WHERE (articleid = '%@' AND rawmaterialid = '%@' AND insraw = '%@')",[[[AppDataManager sharedAppDatamanager] transaction] articleid],[sockMaterials rawmaterialid],[sockMaterials insraw]];
                        search.arr_Common_List = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:colorQuery asObject:[ArticlesRawmaterials class]] mutableCopy];
                        
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
        //       cell.indeX = indexPath.row;
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

                    SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
                    search.tag = QTY_SELECTION;
                    search.arr_Common_List = [[AppDataManager sharedAppDatamanager] quantityOption];
                    [search registerOptionSelectionCallback:^(id selectedData) {
                        
                        [[[AppDataManager sharedAppDatamanager] transaction] setQty:selectedData];
                        cell.txt_Qty.text = selectedData;
                        
                    }];
                    
                    [[self navigationController] pushViewController:search animated:YES];
                    
                }
                    break;
                case 2:{
                    //PAIR_SELECTION
                    
                    SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
                    search.tag = PAIR_SELECTION;
                    
                    search.arr_Common_List = [NSMutableArray arrayWithObjects:@"ODD",@"PAIR", nil];
                    [search registerOptionSelectionCallback:^(id selectedData) {
                        
                        [[[AppDataManager sharedAppDatamanager] transaction] setQty_unit:selectedData];
                        cell.txt_Pair.text = selectedData;
                    }];
                    
                    [[self navigationController] pushViewController:search animated:YES];
                    
                    
                }
                    break;
                case 3:{
                    //SIZE_SELECTION
                    
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
        __block __weak AddToCartViewController *weakSelf = self;
        [cell registerCallbackForAddToCart:^{
            
           CartViewController *cart =  [[weakSelf storyboard] instantiateViewControllerWithIdentifier:@"CartViewController"];
            [[weakSelf navigationController] pushViewController:cart animated:YES];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Article added to card" delegate:<#(id)#> cancelButtonTitle:<#(NSString *)#> otherButtonTitles:<#(NSString *), ...#>, nil];
            
            
//            [[weakSelf tabBarController] setSelectedIndex:3];

        }];
        
    }
    
    return cell;
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
//    if ((tableView == [self tblLeather]) || (tableView == [self tblLining]))
//        return 40.0;
    
    return 0.0;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
//    if (tableView == [self tblLeather]) {
//        AddMoreLeatherTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"AddMoreLeatherTableViewCell" owner:self options:nil] firstObject];
//        [cell.lblTitle setAdjustsFontSizeToFitWidth:YES];
//        [cell.lblTitle setText:@"Add more Leather"];
//        
//        [cell callbackForDropdown:^(AddMoreLeatherTableViewCell *__weak cell, NSInteger tag) {
//            
//            Rawmaterials *raw = [[Rawmaterials alloc] init];
//            [[[[AppDataManager sharedAppDatamanager] transaction] rawmaterialsForLeathers] addObject:raw];
//            [[self tbl_RawMatarial] reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
//            [[self tblLeather] reloadData];
//            [[self tblLining] reloadData];
//            
//        }];
//        return cell;
//    }else if (tableView == [self tblLining]) {
//        AddMoreLeatherTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"AddMoreLeatherTableViewCell" owner:self options:nil] firstObject];
//        [cell.lblTitle setAdjustsFontSizeToFitWidth:YES];
//        [cell.lblTitle setText:@" Add more Lining"];
//
//        [cell callbackForDropdown:^(AddMoreLeatherTableViewCell *__weak cell, NSInteger tag) {
//            
//            Rawmaterials *raw = [[Rawmaterials alloc] init];
//            [[[[AppDataManager sharedAppDatamanager] transaction] rawmaterialsForLinings] addObject:raw];
//            [[self tbl_RawMatarial] reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
//            [[self tblLeather] reloadData];
//            [[self tblLining] reloadData];
//            
//            
//        }];
//        return cell;
//    }
    
    
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self showActivityIndicator:@"Loading Article..."];
        });
        
        Articles *article = [[self arrArticles] objectAtIndex:indexPath.row];
        [[AppDataManager sharedAppDatamanager] setTransaction:nil];
        [[AppDataManager sharedAppDatamanager] newTransactionWithArticleId:article.articleid withNewDevelopment:NO];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self hideActivityIndicator];
            [self tapOnRelatedBtn:self.dargButton];
            [self refreshUI];
        });
        
        
    });

    
    
    
    
}



- (void)refreshArticleList:(NSString*)searchString{
    
   TrxTransaction *localTrx =  [[AppDataManager sharedAppDatamanager] transaction];

    NSString *soleName = @"";
    if ([localTrx Sole]) {
        soleName = [[[localTrx Sole] name] length] ? [[localTrx Sole] name] : @"";
        
    }
    
    NSString *lastName = @"";
    
    if ([localTrx last]) {
        lastName = [[[localTrx last] lastname] length] ? [[localTrx last] lastname] : @"";
        
    }

    
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Article_Master WHERE lastName == '%@' OR soleName = '%@'",lastName,soleName];
    self.arrArticles = [NSMutableArray arrayWithArray:[[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQuery asObject:[Articles class]]];
    [[self relatedProduct] reloadData];
    
}

#pragma mark - Image Picker Controller delegate methods

- (IBAction)captureNewImageForArticle:(id)sender{

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



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        //self.imageView.image = chosenImage;
        UIImage *newImage =  [UIImage imageWithImage:chosenImage scaledToSize:CGSizeMake(320, 568)];
        
        NSData *data = UIImageJPEGRepresentation(newImage, 0.3);
        
        NSString *filePath = [NSString stringWithFormat:@"%@/%@.jpg",[[AppDataManager sharedAppDatamanager] DevelopmentImageDir],[[[AppDataManager sharedAppDatamanager] transaction] TransactionId]];
        
        [[AppDataManager sharedAppDatamanager]writeDataToImageFileName:filePath withData:data];
        
        [data writeToFile:filePath atomically:YES];
        
        dispatch_sync(dispatch_get_main_queue(), ^{

            [[self CollectionView] reloadData];
        });
        
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
