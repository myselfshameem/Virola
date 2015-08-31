//
//  HomeViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
#import "SyncViewController.h"
#import "NewDevelopmentCtrl.h"
#import "ArticleMasterViewController.h"
#import "ClientViewController.h"
#import "OrderViewController.h"
#import "AccountViewController.h"

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
    
    

    
    //
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(openUserProfile) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, 20, 25)];
    [btn setImage:[UIImage imageNamed:@"Home_Account_Menu"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Home_Account_Menu"] forState:UIControlStateSelected];

    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [[self navigationItem] setRightBarButtonItem:bar];

    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    if (bounds.size.height<=480) {
        NSLayoutConstraint *myConstraint =[NSLayoutConstraint
                                           constraintWithItem:self.vw_bottom
                                           attribute:NSLayoutAttributeHeight
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.vw_Top
                                           attribute:NSLayoutAttributeHeight
                                           multiplier:3.1
                                           constant:0];
        
        myConstraint.priority = 1000;
        
        [[self view] addConstraint:myConstraint];
 
    }else if(isIPad()){
        
        
        NSLayoutConstraint *myConstraint =[NSLayoutConstraint
                                           constraintWithItem:self.vw_bottom
                                           attribute:NSLayoutAttributeHeight
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.vw_Top
                                           attribute:NSLayoutAttributeHeight
                                           multiplier:1
                                           constant:0];
        
        myConstraint.priority = 1000;
        
        [[self view] addConstraint:myConstraint];
        
    }else{
    
    
        NSLayoutConstraint *myConstraint =[NSLayoutConstraint
                                           constraintWithItem:self.vw_bottom
                                           attribute:NSLayoutAttributeHeight
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.vw_Top
                                           attribute:NSLayoutAttributeHeight
                                           multiplier:1.7
                                           constant:0];
        
        myConstraint.priority = 1000;
        
        [[self view] addConstraint:myConstraint];

    }
    
    
    
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
    [[self lbl_NumberOfArticles] setText:[NSString stringWithFormat:@"%lu",(unsigned long)[arrArticles count]]];
    
    NSArray *arrClients = [[CXSSqliteHelper sharedSqliteHelper] runQuery:@"SELECT name FROM Client_Master" asObject:[Clients class]];

    [[self lbl_NumberOfClients] setText:[NSString stringWithFormat:@"%lu",(unsigned long)[arrClients count]]];
    
    [[self lbl_SyncDate] setText:[NSUserDefaults lastSynTime]];
    
    NSArray *arrMyOrder = [[CXSSqliteHelper sharedSqliteHelper] runQuery:@"SELECT * FROM Orders" asObject:[Orders class]];

    [[self lbl_NumberOfReports] setText:[NSString stringWithFormat:@"%lu",(unsigned long)[arrMyOrder count]]];

    

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
    NSString *fileName = [article.imagePath lastPathComponent];
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

- (BOOL)shouldAutorotate{

    return NO;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation NS_AVAILABLE_IOS(6_0){


    return UIInterfaceOrientationPortrait;

}
- (NSUInteger)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0){

    
    return UIInterfaceOrientationMaskPortrait;

}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{

    [[self CollectionView] reloadData];
}
#pragma  mark - Sync Data

- (IBAction)syncData:(id)sender{

    
    SyncViewController *sync = [[self storyboard] instantiateViewControllerWithIdentifier:@"SyncViewController"];
    [[self navigationController] pushViewController:sync animated:YES];
    
    
    

    

    
}

- (IBAction)newDevelopment:(id)sender{

    
    NewDevelopmentCtrl *newDev = [[self storyboard] instantiateViewControllerWithIdentifier:@"NewDevelopmentCtrl"];
    [[self navigationController] pushViewController:newDev animated:YES];
    [[AppDataManager sharedAppDatamanager] newTransactionWithArticleId:@"" withNewDevelopment:YES];
    newDev = nil;
}

- (IBAction)order:(id)sender{

    OrderViewController *sync = [[self storyboard] instantiateViewControllerWithIdentifier:@"OrderViewController"];
    
    [[self navigationController] pushViewController:sync animated:YES];

}
- (IBAction)article:(id)sender{
     ArticleMasterViewController *article = [[self storyboard] instantiateViewControllerWithIdentifier:@"ArticleMasterViewController"];
    [[self navigationController] pushViewController:article animated:YES];


}
- (IBAction)client:(id)sender{

    ClientViewController *article = [[self storyboard] instantiateViewControllerWithIdentifier:@"ClientViewController"];
    [[self navigationController] pushViewController:article animated:YES];

}

- (void)openUserProfile{

    AccountViewController *article = [[self storyboard] instantiateViewControllerWithIdentifier:@"AccountViewController"];
    [[self navigationController] pushViewController:article animated:YES];


}


@end
