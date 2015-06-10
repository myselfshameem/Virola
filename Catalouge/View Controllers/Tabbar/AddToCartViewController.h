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

@property (strong, nonatomic) IBOutlet UITextField *txtField_Input;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet UIView *dargView;
@property (strong, nonatomic) IBOutlet UIButton *dargButton;
@property (strong, nonatomic) IBOutlet UITableView *relatedProduct;
@property (assign, nonatomic) UITextField *common_TxtField;

@property (assign, nonatomic) IBOutlet UILabel *lbl_Title;



@property (strong, nonatomic) IBOutlet UIView *vw_Sole;
@property (strong, nonatomic) IBOutlet UIView *vw_Sole_Color;
@property (strong, nonatomic) IBOutlet UIView *vw_Sole_Material;

@property (strong, nonatomic) IBOutlet UIView *vw_Leather1;
@property (strong, nonatomic) IBOutlet UIView *vw_Lining1;
@property (strong, nonatomic) IBOutlet UIView *vw_LeatherColor1;
@property (strong, nonatomic) IBOutlet UIView *vw_LiningColor1;

@property (strong, nonatomic) IBOutlet UITextField *txt_Leather1;
@property (strong, nonatomic) IBOutlet UITextField *txt_ColorLeather1;
@property (strong, nonatomic) IBOutlet UITextField *txt_Lining1;
@property (strong, nonatomic) IBOutlet UITextField *txt_ColorLining1;



@property (strong, nonatomic) IBOutlet UIView *vw_Leather2;
@property (strong, nonatomic) IBOutlet UIView *vw_Lining2;
@property (strong, nonatomic) IBOutlet UIView *vw_LeatherColor2;
@property (strong, nonatomic) IBOutlet UIView *vw_LiningColor2;

@property (strong, nonatomic) IBOutlet UITextField *txt_Leather2;
@property (strong, nonatomic) IBOutlet UITextField *txt_ColorLeather2;
@property (strong, nonatomic) IBOutlet UITextField *txt_Lining2;
@property (strong, nonatomic) IBOutlet UITextField *txt_ColorLining2;




@property (strong, nonatomic) IBOutlet UIView *vw_Leather3;
@property (strong, nonatomic) IBOutlet UIView *vw_Lining3;
@property (strong, nonatomic) IBOutlet UIView *vw_LeatherColor3;
@property (strong, nonatomic) IBOutlet UIView *vw_LiningColor3;

@property (strong, nonatomic) IBOutlet UITextField *txt_Leather3;
@property (strong, nonatomic) IBOutlet UITextField *txt_ColorLeather3;
@property (strong, nonatomic) IBOutlet UITextField *txt_Lining3;
@property (strong, nonatomic) IBOutlet UITextField *txt_ColorLining3;




@property (strong, nonatomic) IBOutlet UIView *vw_Leather4;
@property (strong, nonatomic) IBOutlet UIView *vw_Lining4;
@property (strong, nonatomic) IBOutlet UIView *vw_LeatherColor4;
@property (strong, nonatomic) IBOutlet UIView *vw_LiningColor4;

@property (strong, nonatomic) IBOutlet UITextField *txt_Leather4;
@property (strong, nonatomic) IBOutlet UITextField *txt_ColorLeather4;
@property (strong, nonatomic) IBOutlet UITextField *txt_Lining4;
@property (strong, nonatomic) IBOutlet UITextField *txt_ColorLining4;




@property (strong, nonatomic) IBOutlet UIView *vw_Leather5;
@property (strong, nonatomic) IBOutlet UIView *vw_Lining5;
@property (strong, nonatomic) IBOutlet UIView *vw_LeatherColor5;
@property (strong, nonatomic) IBOutlet UIView *vw_LiningColor5;

@property (strong, nonatomic) IBOutlet UITextField *txt_Leather5;
@property (strong, nonatomic) IBOutlet UITextField *txt_ColorLeather5;
@property (strong, nonatomic) IBOutlet UITextField *txt_Lining5;
@property (strong, nonatomic) IBOutlet UITextField *txt_ColorLining5;



@property (strong, nonatomic) IBOutlet UIView *vw_Qty;
@property (strong, nonatomic) IBOutlet UIView *vw_Pair;
@property (strong, nonatomic) IBOutlet UIView *vw_Size;
@property (strong, nonatomic) IBOutlet UIView *vw_Remark;

@property (strong, nonatomic) IBOutlet UITextField *txt_Qty;
@property (strong, nonatomic) IBOutlet UITextField *txt_Pair;
@property (strong, nonatomic) IBOutlet UITextField *txt_Size;
@property (strong, nonatomic) IBOutlet UITextView *txt_Remarks;


@property (strong, nonatomic) IBOutlet UILabel *lbl_ArticleNo;
@property (strong, nonatomic) IBOutlet UILabel *lbl_ArticleName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_ArticlePrice;



@property (strong, nonatomic) IBOutlet UITextField *txt_Sole;
@property (strong, nonatomic) IBOutlet UITextField *txt_SoleColor;
@property (strong, nonatomic) IBOutlet UITextField *txt_SoleMaterial;



@property (strong, nonatomic) IBOutlet UIButton *addToCart;


-(IBAction)zoomButtonPressed:(id)sender;
-(IBAction)addToCart:(id)sender;
@end
