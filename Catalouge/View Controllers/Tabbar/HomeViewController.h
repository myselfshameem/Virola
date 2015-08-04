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
@property (strong, nonatomic) NSMutableArray *arrArticles;
- (IBAction)syncData:(id)sender;
- (IBAction)newDevelopment:(id)sender;
@end
