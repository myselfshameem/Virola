//
//  HomeViewController.h
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
@property (strong, nonatomic) IBOutlet UICollectionView *CollectionView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageCtrl;
@property (strong, nonatomic) IBOutlet UILabel *lbl_NumberOfArticles;
@property (strong, nonatomic) IBOutlet UILabel *lbl_NumberOfClients;
@property (strong, nonatomic) IBOutlet UILabel *lbl_NumberOfReports;
@property (strong, nonatomic) IBOutlet UILabel *lbl_SyncDate;
@property (strong, nonatomic) IBOutlet UIView *vw_Top;
@property (strong, nonatomic) IBOutlet UIView *vw_bottom;

@property (strong, nonatomic) NSMutableArray *arrArticles;
- (IBAction)syncData:(id)sender;
- (IBAction)newDevelopment:(id)sender;
- (IBAction)order:(id)sender;
- (IBAction)article:(id)sender;
- (IBAction)client:(id)sender;
@end
