//
//  AddToCartViewController.h
//  Catalouge
//
//  Created by Shameem Ahamad on 5/22/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddToCartViewController : UIViewController<UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *CollectionView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageCtrl;

@property (strong, nonatomic) NSMutableArray *arrArticles;
@property (strong, nonatomic) NSMutableArray *article_Images;




@property (strong, nonatomic) IBOutlet UIView *dargView;
@property (strong, nonatomic) IBOutlet UIButton *dargButton;
@property (strong, nonatomic) IBOutlet UITableView *relatedProduct;

@property (strong, nonatomic) __block  IBOutlet UITableView *tbl_RawMatarial;
@property(nonatomic,strong) IBOutlet UITableView *tblLeather;
@property(nonatomic,strong) IBOutlet UITableView *tblLining;


@property (assign, nonatomic) IBOutlet UILabel *lbl_Title;
@property (strong, nonatomic) IBOutlet UILabel *lbl_ArticleNo;
@property (strong, nonatomic) IBOutlet UILabel *lbl_ArticleName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_ArticlePrice_USD;
@property (strong, nonatomic) IBOutlet UILabel *lbl_ArticlePrice_EURO;
@property (strong, nonatomic) IBOutlet UILabel *lbl_ArticlePrice_GBP;


-(IBAction)zoomButtonPressed:(id)sender;
- (IBAction)tapOnRelatedBtn:(id)sender;
@end
