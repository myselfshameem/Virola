
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
#import <QuickLook/QuickLook.h>
#import "TrxTransaction.h"
#import "CartViewController.h"
#import "QuickLookViewController.h"
#import "SearchViewController.h"
#import "RawMatarialCell.h"
#define SOLE_TXT_TAG 2001
#define SOLE_TXT_COLOR 2002
#define SOLE_MATERIAL_TXT_COLOR 2003


#define LEATHER1_TXT_TAG 101
#define LEATHER_COLOR1_TXT_TAG 102
#define LINING1_TXT_TAG 103
#define LINING_COLOR1_TXT_TAG 104


#define LEATHER2_TXT_TAG 105
#define LEATHER_COLOR2_TXT_TAG 106
#define LINING2_TXT_TAG 107
#define LINING_COLOR2_TXT_TAG 108



#define LEATHER3_TXT_TAG 109
#define LEATHER_COLOR3_TXT_TAG 110
#define LINING3_TXT_TAG 111
#define LINING_COLOR3_TXT_TAG 112


#define LEATHER4_TXT_TAG 113
#define LEATHER_COLOR4_TXT_TAG 114
#define LINING4_TXT_TAG 115
#define LINING_COLOR4_TXT_TAG 116


#define LEATHER5_TXT_TAG 117
#define LEATHER_COLOR5_TXT_TAG 118
#define LINING5_TXT_TAG 119
#define LINING_COLOR5_TXT_TAG 120




#define ARTILCE_QTY 10001
#define ARTILCE_QTY_UNIT 10002
#define ARTILCE_SIZE 10003



@interface AddToCartViewController ()<QLPreviewControllerDataSource,QLPreviewControllerDelegate,QLPreviewItem,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>
{

    QLPreviewController *previewCtrl;
    NSInteger selectedIndex;
    __block NSInteger rowForRawMatarial;
    __block NSInteger rowForRawMatarial1;

}
@property(nonatomic,strong) NSMutableArray *arr_Input_List;


@end

@implementation AddToCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    rowForRawMatarial = 3;
    rowForRawMatarial1 = 3;

    UINib *cellNib = [UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil];
    [self.CollectionView registerNib:cellNib forCellWithReuseIdentifier:kCellID];
    [self.pageCtrl setNumberOfPages:5];
    [self.pageCtrl setCurrentPage:0];
    [self.pageCtrl setCurrentPageIndicatorTintColor:[UIColor blueColor]];
    
    [self setTitle:@"Article"];
    self.picker = [[UIPickerView alloc] init];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    
    self.vw_Sole.layer.cornerRadius = 0;
    CGColorRef borderColor = [UIColor grayColor].CGColor;
    self.vw_Sole.layer.borderColor = borderColor;
    self.vw_Sole.layer.borderWidth = 1.5;

    self.vw_Sole_Color.layer.cornerRadius = 0;
    borderColor = [UIColor grayColor].CGColor;
    self.vw_Sole_Color.layer.borderColor = borderColor;
    self.vw_Sole_Color.layer.borderWidth = 1.5;

    self.vw_Sole_Material.layer.cornerRadius = 0;
    borderColor = [UIColor grayColor].CGColor;
    self.vw_Sole_Material.layer.borderColor = borderColor;
    self.vw_Sole_Material.layer.borderWidth = 1.5;

    
    [self setCornerForView:self.vw_Leather1];
    [self setCornerForView:self.vw_Lining1];
    [self setCornerForView:self.vw_LeatherColor1];
    [self setCornerForView:self.vw_LiningColor1];

    [self setCornerForView:self.vw_Leather2];
    [self setCornerForView:self.vw_Lining2];
    [self setCornerForView:self.vw_LeatherColor2];
    [self setCornerForView:self.vw_LiningColor2];

    
    [self setCornerForView:self.vw_Leather3];
    [self setCornerForView:self.vw_Lining3];
    [self setCornerForView:self.vw_LeatherColor3];
    [self setCornerForView:self.vw_LiningColor3];

    
    [self setCornerForView:self.vw_Leather4];
    [self setCornerForView:self.vw_Lining4];
    [self setCornerForView:self.vw_LeatherColor4];
    [self setCornerForView:self.vw_LiningColor4];

    
    [self setCornerForView:self.vw_Leather5];
    [self setCornerForView:self.vw_Lining5];
    [self setCornerForView:self.vw_LeatherColor5];
    [self setCornerForView:self.vw_LiningColor5];

    
    self.txt_Leather1.delegate = self;
    self.txt_ColorLeather1.delegate = self;
    self.txt_Lining1.delegate = self;
    self.txt_ColorLining1.delegate = self;
    

    self.txt_Leather2.delegate = self;
    self.txt_ColorLeather2.delegate = self;
    self.txt_Lining2.delegate = self;
    self.txt_ColorLining2.delegate = self;

    
    
    self.txt_Leather3.delegate = self;
    self.txt_ColorLeather3.delegate = self;
    self.txt_Lining3.delegate = self;
    self.txt_ColorLining3.delegate = self;

    
    
    self.txt_Leather4.delegate = self;
    self.txt_ColorLeather4.delegate = self;
    self.txt_Lining4.delegate = self;
    self.txt_ColorLining4.delegate = self;

    

    
    
    self.txt_Leather5.delegate = self;
    self.txt_ColorLeather5.delegate = self;
    self.txt_Lining5.delegate = self;
    self.txt_ColorLining5.delegate = self;

    
    self.txt_Qty.delegate = self;
    self.txt_Pair.delegate = self;
    self.txt_Size.delegate = self;
    self.txt_Remarks.delegate = self;

    
    self.txt_Sole.delegate = self;
    self.txt_SoleColor.delegate = self;
    self.txt_SoleMaterial.delegate = self;

    
    
    [self setCornerForView:self.vw_Qty];
    [self setCornerForView:self.vw_Pair];
    [self setCornerForView:self.vw_Size];
    [self setCornerForView:self.vw_Remark];

    
    self.addToCart.layer.cornerRadius = 18;
    borderColor = [UIColor grayColor].CGColor;

    
    
    
    
    
    //Set Tag
    self.txt_Sole.tag = SOLE_TXT_TAG;
    self.txt_SoleColor.tag = SOLE_TXT_COLOR;
    self.txt_SoleMaterial.tag = SOLE_MATERIAL_TXT_COLOR;

    
    
    
    self.txt_Leather1.tag = LEATHER1_TXT_TAG;
    self.txt_ColorLeather1.tag = LEATHER_COLOR1_TXT_TAG;
    self.txt_Lining1.tag = LINING1_TXT_TAG;
    self.txt_ColorLining1.tag = LINING_COLOR1_TXT_TAG;

    
    self.txt_Leather2.tag = LEATHER2_TXT_TAG;
    self.txt_ColorLeather2.tag = LEATHER_COLOR2_TXT_TAG;
    self.txt_Lining2.tag = LINING2_TXT_TAG;
    self.txt_ColorLining2.tag = LINING_COLOR2_TXT_TAG;

    
    self.txt_Leather3.tag = LEATHER3_TXT_TAG;
    self.txt_ColorLeather3.tag = LEATHER_COLOR3_TXT_TAG;
    self.txt_Lining3.tag = LINING3_TXT_TAG;
    self.txt_ColorLining3.tag = LINING_COLOR3_TXT_TAG;

    
    self.txt_Leather4.tag = LEATHER3_TXT_TAG;
    self.txt_ColorLeather4.tag = LEATHER_COLOR4_TXT_TAG;
    self.txt_Lining4.tag = LINING4_TXT_TAG;
    self.txt_ColorLining4.tag = LINING_COLOR4_TXT_TAG;

    
    
    self.txt_Leather5.tag = LEATHER5_TXT_TAG;
    self.txt_ColorLeather5.tag = LEATHER_COLOR5_TXT_TAG;
    self.txt_Lining5.tag = LINING5_TXT_TAG;
    self.txt_ColorLining5.tag = LINING_COLOR5_TXT_TAG;

    
    
    [self setFontSize];
    
    [self refreshUI];
    
}

- (void)setFontSize{

    
    UIFont *font = [UIFont fontWithName:@"MyriadPro-Regular" size:12];
    
    [[self txt_ColorLeather1] setFont:font];
    [[self txt_ColorLeather2] setFont:font];
    [[self txt_ColorLeather3] setFont:font];
    [[self txt_ColorLeather4] setFont:font];
    [[self txt_ColorLeather5] setFont:font];
    
    [[self txt_ColorLeather1] setPlaceholder:@"Leather Color 1"];
    [[self txt_ColorLeather2] setPlaceholder:@"Leather Color 2"];
    [[self txt_ColorLeather3] setPlaceholder:@"Leather Color 3"];
    [[self txt_ColorLeather4] setPlaceholder:@"Leather Color 4"];
    [[self txt_ColorLeather5] setPlaceholder:@"Leather Color 5"];

    
    
    
    
    [[self txt_ColorLining1] setFont:font];
    [[self txt_ColorLining2] setFont:font];
    [[self txt_ColorLining3] setFont:font];
    [[self txt_ColorLining4] setFont:font];
    [[self txt_ColorLining5] setFont:font];
    
    [[self txt_ColorLining1] setPlaceholder:@"Lining Color 1"];
    [[self txt_ColorLining2] setPlaceholder:@"Lining Color 2"];
    [[self txt_ColorLining3] setPlaceholder:@"Lining Color 3"];
    [[self txt_ColorLining4] setPlaceholder:@"Lining Color 4"];
    [[self txt_ColorLining5] setPlaceholder:@"Lining Color 5"];

    
    
    
    [[self txt_Leather1] setFont:font];
    [[self txt_Leather2] setFont:font];
    [[self txt_Leather3] setFont:font];
    [[self txt_Leather4] setFont:font];
    [[self txt_Leather5] setFont:font];
    
    [[self txt_Leather1] setPlaceholder:@"Leather 1"];
    [[self txt_Leather2] setPlaceholder:@"Leather 2"];
    [[self txt_Leather3] setPlaceholder:@"Leather 3"];
    [[self txt_Leather4] setPlaceholder:@"Leather 4"];
    [[self txt_Leather5] setPlaceholder:@"Leather 5"];

    
    
    
    [[self txt_Lining1] setFont:font];
    [[self txt_Lining2] setFont:font];
    [[self txt_Lining3] setFont:font];
    [[self txt_Lining4] setFont:font];
    [[self txt_Lining5] setFont:font];
    
    [[self txt_Lining1] setPlaceholder:@"Lining 1"];
    [[self txt_Lining2] setPlaceholder:@"Lining 2"];
    [[self txt_Lining3] setPlaceholder:@"Lining 3"];
    [[self txt_Lining4] setPlaceholder:@"Lining 4"];
    [[self txt_Lining5] setPlaceholder:@"Lining 5"];

    
    
    [[self txt_Pair] setFont:font];
    [[self txt_Qty] setFont:font];
    [[self txt_Size] setFont:font];
    [[self txt_Sole] setFont:font];
    [[self txt_SoleColor] setFont:font];
    [[self txt_SoleMaterial] setFont:font];
    
    [[self txt_Sole] setPlaceholder:@"Last/Sole"];
    [[self txt_SoleColor] setPlaceholder:@"Sole Color"];
    [[self txt_SoleMaterial] setPlaceholder:@"Sole Material"];

    font = [UIFont fontWithName:@"MyriadPro-Regular" size:10];

    [[self txt_Pair] setPlaceholder:@"Pair"];
    [[self txt_Qty] setPlaceholder:@"Qty"];
    [[self txt_Size] setPlaceholder:@"Size"];
    
    
    
    font = [UIFont fontWithName:@"MyriadPro-Regular" size:14];
    [[self txt_Remarks] setFont:font];
    
    [[self txt_Remarks] setAutocorrectionType:UITextAutocorrectionTypeNo];
    [[self txt_Remarks] setInputAccessoryView:self.toolbar];

}
- (void)refreshUI{

    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];

    [[self lbl_Title] setText:[[[[AppDataManager sharedAppDatamanager] transaction] article] articlename]];
    
    [[self lbl_ArticleName] setText:[[[[AppDataManager sharedAppDatamanager] transaction] article] articlename]];
    [[self lbl_ArticlePrice] setText:[NSString stringWithFormat:@"€%@",[[[[AppDataManager sharedAppDatamanager] transaction] article] price]]];
    
    
    [[self txt_Qty] setText:[NSString stringWithFormat:@"%@",[local qty]]];
    [[self txt_Pair] setText:[NSString stringWithFormat:@"%@",[local qty_unit]]];
    [[self txt_Size] setText:[NSString stringWithFormat:@"%@",[local size]]];

    
    
    
    if ([local Sole]) {
        
        self.txt_Sole.text = local.Sole.name;
        self.txt_SoleColor.text = local.Sole.colors.colorname;
        
    }

    if ([local SoleMaterial]) {
        
        self.txt_SoleMaterial.text = local.SoleMaterial.name;
    }

    
    

    if ([local Leather1]) {
        
        self.txt_Leather1.text = local.Leather1.name;
        self.txt_ColorLeather1.text = local.Leather1.colors.colorname;

    }else{
        [self disableView:self.vw_Leather1];
        [self disableView:self.vw_LeatherColor1];

    }
    
    
    if ([local Leather2]) {
        self.txt_Leather2.text = local.Leather2.name;
        self.txt_ColorLeather2.text = local.Leather2.colors.colorname;

    }else{
        [self disableView:self.vw_Leather2];
        [self disableView:self.vw_LeatherColor2];

    }

    
    if ([local Leather3]) {
        self.txt_Leather3.text = local.Leather3.name;
        self.txt_ColorLeather3.text = local.Leather3.colors.colorname;

    }else{
        [self disableView:self.vw_Leather3];
        [self disableView:self.vw_LeatherColor3];

    }

    
    
    if ([local Leather4]) {
        self.txt_Leather4.text = local.Leather4.name;
        self.txt_ColorLeather4.text = local.Leather4.colors.colorname;

    }else{
        [self disableView:self.vw_Leather4];
        [self disableView:self.vw_LeatherColor4];

    }

    
    
    if ([local Leather5]) {
        self.txt_Leather5.text = local.Leather5.name;
        self.txt_ColorLeather5.text = local.Leather5.colors.colorname;

    }else{
        [self disableView:self.vw_Leather5];
        [self disableView:self.vw_LeatherColor5];

    }

    
    if ([local Lining1]) {
        
        self.txt_Lining1.text = local.Lining1.name;
        self.txt_ColorLining1.text = local.Lining1.colors.colorname;
        
    }else{
        [self disableView:self.vw_Lining1];
        [self disableView:self.vw_LiningColor1];
        
    }
    
    
    
    
    if ([local Lining2]) {
        
        self.txt_Lining2.text = local.Lining2.name;
        self.txt_ColorLining2.text = local.Lining2.colors.colorname;
        
    }else{
        [self disableView:self.vw_Lining2];
        [self disableView:self.vw_LiningColor2];
        
    }

    if ([local Lining3]) {
        
        self.txt_Lining3.text = local.Lining3.name;
        self.txt_ColorLining3.text = local.Lining3.colors.colorname;
        
    }else{
        [self disableView:self.vw_Lining3];
        [self disableView:self.vw_LiningColor3];
        
    }

    if ([local Lining4]) {
        
        self.txt_Lining4.text = local.Lining4.name;
        self.txt_ColorLining4.text = local.Lining4.colors.colorname;
        
    }else{
        [self disableView:self.vw_Lining4];
        [self disableView:self.vw_LiningColor4];
        
    }

    if ([local Lining5]) {
        
        self.txt_Lining5.text = local.Lining5.name;
        self.txt_ColorLining5.text = local.Lining5.colors.colorname;
        
    }else{
        [self disableView:self.vw_Lining5];
        [self disableView:self.vw_LiningColor5];
        
    }

    
    NSArray *img_arr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:[NSString stringWithFormat:@"SELECT * FROM Article_Images WHERE articleid = '%@'",local.articleid] asObject:[Article_Image class]];
    self.article_Images = [NSMutableArray arrayWithArray:img_arr];

    [self.pageCtrl setNumberOfPages:[self.article_Images count]];

    
    [[self relatedProduct] reloadData];
    
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
- (UIToolbar*)toolbar{
    
    if (!_toolbar) {
        
        _toolbar = [[[NSBundle mainBundle] loadNibNamed:@"ToolbarForKeyBoard" owner:self options:nil] firstObject];
        UIBarButtonItem *last = [[_toolbar items] lastObject];
        [last setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"MyriadPro-Regular" size:18],NSFontAttributeName, nil] forState:UIControlStateNormal];
        [last setTarget:self];
        [last setAction:@selector(DoneInput)];
    }
    
    return _toolbar;
}
#pragma mark - Toolbar
- (void)DoneInput{
    
    if ([self txt_Remarks]) {
        [[self txt_Remarks] resignFirstResponder];
    }
}
- (NSMutableArray*)arr_Input_List{

    if (!_arr_Input_List) {
        _arr_Input_List = [[NSMutableArray alloc] init];
    }

    return _arr_Input_List;
    
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

    Article_Image *article = [[self article_Images] objectAtIndex:indexPath.row];
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
#pragma mark - Text Field Delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    self.common_TxtField = textField;
    return YES;
}

-(IBAction)btn_Pressed:(id)sender{

    
    self.common_TxtField = (UITextField*)[[self view] viewWithTag:[sender tag]];
    selectedIndex = 0;
    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
    NSString *title = @"";
    
    NSMutableArray *materialGroup = [[NSMutableArray alloc] init];
    
    switch ([self.common_TxtField tag]) {
            
        case SOLE_TXT_TAG:{
            title = @"Last/Sole";
            materialGroup = [self getSoleWithTextField:self.common_TxtField];
        }
            break;
        case SOLE_TXT_COLOR:{
            title = @"Sole Color";
            materialGroup = [self getSoleColorWithTextField:self.common_TxtField];
        }
            break;
        case SOLE_MATERIAL_TXT_COLOR:{
            
            title = @"Sole Material";
            
            materialGroup = [self getSoleMaterialWithTextField:self.common_TxtField];
            
            if([local SoleMaterial]){
                
                NSArray *arr = [materialGroup filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"rawmaterialid = '%@'",[[local SoleMaterial] rawmaterialid]]];
                
                if([arr count]){
                    selectedIndex = [materialGroup indexOfObject:[arr lastObject]];
                }
                
            }
            
            
            
        }
            break;
            
        case LINING1_TXT_TAG:
            materialGroup = [self getLiningWithTextField:self.common_TxtField];
            title = @"Lining 1";
            break;
        case LINING2_TXT_TAG:
            materialGroup = [self getLiningWithTextField:self.common_TxtField];
            title = @"Lining 2";
            
        case LINING3_TXT_TAG:
            materialGroup = [self getLiningWithTextField:self.common_TxtField];
            title = @"Lining 3";
            
        case LINING4_TXT_TAG:
            materialGroup = [self getLiningWithTextField:self.common_TxtField];
            title = @"Lining 4";
            
        case LINING5_TXT_TAG:
            materialGroup = [self getLiningWithTextField:self.common_TxtField];
            title = @"Lining 5";
            
            break;
            
        case LINING_COLOR1_TXT_TAG:
            materialGroup = [self getLiningColorWithTextField:self.common_TxtField];
            title = @"Lining Color 1";
            break;
        case LINING_COLOR2_TXT_TAG:
            materialGroup = [self getLiningColorWithTextField:self.common_TxtField];
            title = @"Lining Color 2";
            break;
            
        case LINING_COLOR3_TXT_TAG:
            materialGroup = [self getLiningColorWithTextField:self.common_TxtField];
            title = @"Lining Color 3";
            break;
            
        case LINING_COLOR4_TXT_TAG:
            materialGroup = [self getLiningColorWithTextField:self.common_TxtField];
            title = @"Lining Color 4";
            break;
            
        case LINING_COLOR5_TXT_TAG:
            materialGroup = [self getLiningColorWithTextField:self.common_TxtField];
            title = @"Lining Color 5";
            break;
            
        case LEATHER1_TXT_TAG:
            materialGroup = [self getLeatherWithTextField:self.common_TxtField];
            title = @"Leather 1";
            break;
        case LEATHER2_TXT_TAG:
            materialGroup = [self getLeatherWithTextField:self.common_TxtField];
            title = @"Leather 2";
            break;
            
        case LEATHER3_TXT_TAG:
            materialGroup = [self getLeatherWithTextField:self.common_TxtField];
            title = @"Leather 3";
            break;
            
        case LEATHER4_TXT_TAG:
            materialGroup = [self getLeatherWithTextField:self.common_TxtField];
            title = @"Leather 4";
            break;
            
        case LEATHER5_TXT_TAG:
            materialGroup = [self getLeatherWithTextField:self.common_TxtField];
            title = @"Leather 5";
            break;
            
        case LEATHER_COLOR1_TXT_TAG:
            materialGroup = [self getLeatherColorWithTextField:self.common_TxtField];
            title = @"Leather Color 1";
            break;
            
        case LEATHER_COLOR2_TXT_TAG:
            materialGroup = [self getLeatherColorWithTextField:self.common_TxtField];
            title = @"Leather Color 2";
            break;
            
        case LEATHER_COLOR3_TXT_TAG:
            materialGroup = [self getLeatherColorWithTextField:self.common_TxtField];
            title = @"Leather Color 3";
            break;
            
        case LEATHER_COLOR4_TXT_TAG:
            materialGroup = [self getLeatherColorWithTextField:self.common_TxtField];
            title = @"Leather Color 4";
            break;
            
        case LEATHER_COLOR5_TXT_TAG:
            materialGroup = [self getLeatherColorWithTextField:self.common_TxtField];
            title = @"Leather Color 5";
            break;
            
            break;
        case ARTILCE_QTY:
        {
            
            for (int i = 1; i<=100; i++) {
                
                Rawmaterials *raw = [[Rawmaterials alloc] init];
                [raw setName:[NSString stringWithFormat:@"%i",i]];
                [materialGroup addObject:raw];
                
            }
            
            Rawmaterials *_200 = [[Rawmaterials alloc] init];
            [_200 setName:@"200"];
            [materialGroup addObject:_200];
            
            Rawmaterials *_500 = [[Rawmaterials alloc] init];
            [_500 setName:@"500"];
            [materialGroup addObject:_500];
            
            Rawmaterials *_1000 = [[Rawmaterials alloc] init];
            [_1000 setName:@"1000"];
            [materialGroup addObject:_1000];
            
        }
            break;
        case ARTILCE_QTY_UNIT:
        {
            
            Rawmaterials *PAIR = [[Rawmaterials alloc] init];
            [PAIR setName:@"PAIR"];
            [materialGroup addObject:PAIR];
            
            Rawmaterials *ODD = [[Rawmaterials alloc] init];
            [ODD setName:@"ODD"];
            [materialGroup addObject:ODD];
            
            
        }
            break;
        case ARTILCE_SIZE:
        {
            for (int i = [[[local article] sizefrom] integerValue]; i<=[[[local article] sizeto] integerValue]; i++) {
                
                Rawmaterials *raw = [[Rawmaterials alloc] init];
                [raw setName:[NSString stringWithFormat:@"%i",i]];
                [materialGroup addObject:raw];
                
            }
            
        }
            break;
            
        default:
            break;
    }
    
    
    
    
    
    [[self arr_Input_List] count] ?  [[self arr_Input_List] removeAllObjects] : @"NOTHING";
    
    [[self arr_Input_List] addObjectsFromArray:materialGroup];
    //    [[self picker] reloadAllComponents];
    //    if ([[self arr_Input_List] count]>=selectedIndex) {
    //        [[self picker] selectRow:selectedIndex inComponent:0 animated:NO];
    //
    //    }
    
    SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
    search.title = title;
    search.arr_ClientList = self.arr_Input_List;
    search.tag = self.common_TxtField.tag;
    search.common_TxtField = self.common_TxtField;
    [[self navigationController] pushViewController:search animated:YES];

    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    

//    self.common_TxtField = textField;
////    self.common_TxtField.inputView = self.picker;
////    self.common_TxtField.inputAccessoryView = self.toolbar;
//    selectedIndex = 0;
//    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
//    NSString *title = @"";
//    
//    NSMutableArray *materialGroup = [[NSMutableArray alloc] init];
//
//    switch ([textField tag]) {
//            
//        case SOLE_TXT_TAG:{
//            title = @"Last/Sole";
//            materialGroup = [self getSoleWithTextField:textField];
//        }
//            break;
//        case SOLE_TXT_COLOR:{
//            title = @"Sole Color";
//            materialGroup = [self getSoleColorWithTextField:textField];
//        }
//            break;
//        case SOLE_MATERIAL_TXT_COLOR:{
//            
//            title = @"Sole Material";
//
//            materialGroup = [self getSoleMaterialWithTextField:textField];
//            
//            if([local SoleMaterial]){
//                
//                NSArray *arr = [materialGroup filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"rawmaterialid = '%@'",[[local SoleMaterial] rawmaterialid]]];
//                
//                if([arr count]){
//                    selectedIndex = [materialGroup indexOfObject:[arr lastObject]];
//                }
//                
//            }
//            
//            
//
//        }
//            break;
//            
//        case LINING1_TXT_TAG:
//            materialGroup = [self getLiningWithTextField:textField];
//            title = @"Lining 1";
//            break;
//        case LINING2_TXT_TAG:
//            materialGroup = [self getLiningWithTextField:textField];
//            title = @"Lining 2";
//            
//        case LINING3_TXT_TAG:
//            materialGroup = [self getLiningWithTextField:textField];
//            title = @"Lining 3";
//            
//        case LINING4_TXT_TAG:
//            materialGroup = [self getLiningWithTextField:textField];
//            title = @"Lining 4";
//            
//        case LINING5_TXT_TAG:
//            materialGroup = [self getLiningWithTextField:textField];
//            title = @"Lining 5";
//            
//            break;
//
//        case LINING_COLOR1_TXT_TAG:
//            materialGroup = [self getLiningColorWithTextField:textField];
//            title = @"Lining Color 1";
//            break;
//        case LINING_COLOR2_TXT_TAG:
//            materialGroup = [self getLiningColorWithTextField:textField];
//            title = @"Lining Color 2";
//            break;
//
//        case LINING_COLOR3_TXT_TAG:
//            materialGroup = [self getLiningColorWithTextField:textField];
//            title = @"Lining Color 3";
//            break;
//
//        case LINING_COLOR4_TXT_TAG:
//            materialGroup = [self getLiningColorWithTextField:textField];
//            title = @"Lining Color 4";
//            break;
//
//        case LINING_COLOR5_TXT_TAG:
//            materialGroup = [self getLiningColorWithTextField:textField];
//            title = @"Lining Color 5";
//            break;
//            
//        case LEATHER1_TXT_TAG:
//            materialGroup = [self getLeatherWithTextField:textField];
//            title = @"Leather 1";
//            break;
//        case LEATHER2_TXT_TAG:
//            materialGroup = [self getLeatherWithTextField:textField];
//            title = @"Leather 2";
//            break;
//
//        case LEATHER3_TXT_TAG:
//            materialGroup = [self getLeatherWithTextField:textField];
//            title = @"Leather 3";
//            break;
//
//        case LEATHER4_TXT_TAG:
//            materialGroup = [self getLeatherWithTextField:textField];
//            title = @"Leather 4";
//            break;
//
//        case LEATHER5_TXT_TAG:
//            materialGroup = [self getLeatherWithTextField:textField];
//            title = @"Leather 5";
//            break;
//
//        case LEATHER_COLOR1_TXT_TAG:
//            materialGroup = [self getLeatherColorWithTextField:textField];
//            title = @"Leather Color 1";
//            break;
//
//        case LEATHER_COLOR2_TXT_TAG:
//            materialGroup = [self getLeatherColorWithTextField:textField];
//            title = @"Leather Color 2";
//            break;
//
//        case LEATHER_COLOR3_TXT_TAG:
//            materialGroup = [self getLeatherColorWithTextField:textField];
//            title = @"Leather Color 3";
//            break;
//
//        case LEATHER_COLOR4_TXT_TAG:
//            materialGroup = [self getLeatherColorWithTextField:textField];
//            title = @"Leather Color 4";
//            break;
//
//        case LEATHER_COLOR5_TXT_TAG:
//            materialGroup = [self getLeatherColorWithTextField:textField];
//            title = @"Leather Color 5";
//            break;
//
//            break;
//        case ARTILCE_QTY:
//        {
//        
//            for (int i = 1; i<=100; i++) {
//                
//                Rawmaterials *raw = [[Rawmaterials alloc] init];
//                [raw setName:[NSString stringWithFormat:@"%i",i]];
//                [materialGroup addObject:raw];
//
//            }
//            
//            Rawmaterials *_200 = [[Rawmaterials alloc] init];
//            [_200 setName:@"200"];
//            [materialGroup addObject:_200];
//
//            Rawmaterials *_500 = [[Rawmaterials alloc] init];
//            [_500 setName:@"500"];
//            [materialGroup addObject:_500];
//
//            Rawmaterials *_1000 = [[Rawmaterials alloc] init];
//            [_1000 setName:@"1000"];
//            [materialGroup addObject:_1000];
//
//        }
//            break;
//        case ARTILCE_QTY_UNIT:
//        {
//            
//            Rawmaterials *PAIR = [[Rawmaterials alloc] init];
//            [PAIR setName:@"PAIR"];
//            [materialGroup addObject:PAIR];
//
//            Rawmaterials *ODD = [[Rawmaterials alloc] init];
//            [ODD setName:@"ODD"];
//            [materialGroup addObject:ODD];
//
//
//        }
//            break;
//        case ARTILCE_SIZE:
//        {
//            for (int i = [[[local article] sizefrom] integerValue]; i<=[[[local article] sizeto] integerValue]; i++) {
//                
//                Rawmaterials *raw = [[Rawmaterials alloc] init];
//                [raw setName:[NSString stringWithFormat:@"%i",i]];
//                [materialGroup addObject:raw];
//                
//            }
//
//        }
//            break;
//
//        default:
//            break;
//    }
//    
//    
//    
//    
//
//    [[self arr_Input_List] count] ?  [[self arr_Input_List] removeAllObjects] : @"NOTHING";
//    
//    [[self arr_Input_List] addObjectsFromArray:materialGroup];
////    [[self picker] reloadAllComponents];
////    if ([[self arr_Input_List] count]>=selectedIndex) {
////        [[self picker] selectRow:selectedIndex inComponent:0 animated:NO];
////        
////    }
//    
//    SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
//    search.title = title;
//    search.arr_ClientList = self.arr_Input_List;
//    search.tag = textField.tag;
//    search.common_TxtField = self.common_TxtField;
//    [[self navigationController] pushViewController:search animated:YES];
    
    
}
- (NSMutableArray*)getLeatherWithTextField:(UITextField*)textField{

    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];

    Rawmaterials *leather = nil;
    switch ([textField tag]) {
        case LEATHER1_TXT_TAG:
            leather = local.Leather1;
            break;
        case LEATHER2_TXT_TAG:
            leather = local.Leather2;
            break;
        case LEATHER3_TXT_TAG:
            leather = local.Leather3;
            break;
        case LEATHER4_TXT_TAG:
            leather = local.Leather4;
            break;
        case LEATHER5_TXT_TAG:
            leather = local.Leather5;
            break;

        default:
            break;
    }
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '%@' GROUP BY name",[leather rawmaterialgroupid]];
    NSMutableArray *materialGroup = [NSMutableArray arrayWithArray:[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]]] ;

    if(leather){
        
        query = [NSString stringWithFormat:@"name = '%@'",[leather name]];
        NSArray *arr = [materialGroup filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:query]];
        
        if([arr count]){
            selectedIndex = [materialGroup indexOfObject:[arr lastObject]];
        }
        
    }
    

    return materialGroup;
    
}
- (NSMutableArray*)getLeatherColorWithTextField:(UITextField*)textField{
    
    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
    
    Rawmaterials *leather = nil;
    switch ([textField tag]) {
        case LEATHER_COLOR1_TXT_TAG:
            leather = local.Leather1;
            break;
        case LEATHER_COLOR2_TXT_TAG:
            leather = local.Leather2;
            break;
        case LEATHER_COLOR3_TXT_TAG:
            leather = local.Leather3;
            break;
        case LEATHER_COLOR4_TXT_TAG:
            leather = local.Leather4;
            break;
        case LEATHER_COLOR5_TXT_TAG:
            leather = local.Leather5;
            break;
            
        default:
            break;
    }
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '%@' and name = '%@'",[leather rawmaterialgroupid],[leather name]];
    
    NSMutableArray *materialGroup = [NSMutableArray arrayWithArray:[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]]] ;
    
    if(leather){
        
        query = [NSString stringWithFormat:@"colorid = '%@'",[leather colorid]];
        NSArray *arr = [materialGroup filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:query]];
        
        if([arr count]){
            selectedIndex = [materialGroup indexOfObject:[arr lastObject]];
        }
        
    }

    
    return materialGroup;
    
}
- (NSMutableArray*)getLiningWithTextField:(UITextField*)textField{
    
    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
    
    Rawmaterials *lining = nil;
    switch ([textField tag]) {
        case LINING1_TXT_TAG:
            lining = local.Lining1;
            break;
        case LINING2_TXT_TAG:
            lining = local.Lining2;
            break;
        case LINING3_TXT_TAG:
            lining = local.Lining3;
            break;
        case LINING4_TXT_TAG:
            lining = local.Lining4;
            break;
        case LINING5_TXT_TAG:
            lining = local.Lining5;
            break;
            
        default:
            break;
    }
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '%@' GROUP BY name",[lining rawmaterialgroupid]];
    NSMutableArray *materialGroup = [NSMutableArray arrayWithArray:[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]]] ;
    
    if(lining){
        
        NSString *searchTerm = [lining name];
        
        [materialGroup enumerateObjectsUsingBlock:^(Rawmaterials *obj, NSUInteger idx, BOOL *stop) {
            
            NSLog(@"rawmaterialid = %@",[obj name]);
            if ([[obj name] isEqualToString:searchTerm]) {
                selectedIndex = idx;
                *stop = YES;
            }
        }];
    }

    
    return materialGroup;
    
}
- (NSMutableArray*)getLiningColorWithTextField:(UITextField*)textField{
    
    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
    
    Rawmaterials *lining = nil;
    switch ([textField tag]) {
        case LINING_COLOR1_TXT_TAG:
            lining = local.Lining1;
            break;
        case LINING_COLOR2_TXT_TAG:
            lining = local.Lining2;
            break;
        case LINING_COLOR3_TXT_TAG:
            lining = local.Lining3;
            break;
        case LINING_COLOR4_TXT_TAG:
            lining = local.Lining4;
            break;
        case LINING_COLOR5_TXT_TAG:
            lining = local.Lining5;
            break;
            
        default:
            break;
    }
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '%@' and name = '%@'",[lining rawmaterialgroupid],[lining name]];
    
    NSMutableArray *materialGroup = [NSMutableArray arrayWithArray:[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]]] ;
    
    
    if(lining){
        
        query = [NSString stringWithFormat:@"colorid = '%@'",[lining colorid]];
        NSArray *arr = [materialGroup filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:query]];
        
        if([arr count]){
            selectedIndex = [materialGroup indexOfObject:[arr lastObject]];
        }
        
    }

    
    return materialGroup;
    
}
- (NSMutableArray*)getSoleWithTextField:(UITextField*)textField{
    
    Rawmaterials *soleColor = [[[AppDataManager sharedAppDatamanager] transaction] Sole];

    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master where  rawmaterialgroupid = '10' group by name"];
    NSMutableArray *materialGroup = [NSMutableArray arrayWithArray:[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]]] ;
    
    query = [NSString stringWithFormat:@"name = '%@'",[soleColor name]];
    NSArray *arr = [materialGroup filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:query]];
    
    if([arr count]){
        selectedIndex = [materialGroup indexOfObject:[arr lastObject]];
    }

    return materialGroup;
    
}
- (NSMutableArray*)getSoleColorWithTextField:(UITextField*)textField{
    
    
    Rawmaterials *soleColor = [[[AppDataManager sharedAppDatamanager] transaction] Sole];
    NSMutableArray *materialGroup = nil;
    if (soleColor) {
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '%@' and name = '%@'",[soleColor rawmaterialgroupid],[soleColor name]];
        materialGroup = [NSMutableArray arrayWithArray:[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]]] ;
    }
    
    
    NSString *query = [NSString stringWithFormat:@"colorid = '%@'",[soleColor colorid]];
    NSArray *arr = [materialGroup filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:query]];
    
    if([arr count]){
        selectedIndex = [materialGroup indexOfObject:[arr lastObject]];
    }
    
    return materialGroup;
    
}
- (NSMutableArray*)getSoleMaterialWithTextField:(UITextField*)textField{
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '23' group by name"];
    
    NSMutableArray *materialGroup = [NSMutableArray arrayWithArray:[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]]] ;
    
    Rawmaterials *soleColor = [[[AppDataManager sharedAppDatamanager] transaction] SoleMaterial];

    query = [NSString stringWithFormat:@"name = '%@'",[soleColor name]];
    NSArray *arr = [materialGroup filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:query]];
    
    if([arr count]){
        selectedIndex = [materialGroup indexOfObject:[arr lastObject]];
    }

    return materialGroup;
    
}
#pragma mark - TextView Delegates
- (void)textViewDidEndEditing:(UITextView *)textView{
    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];

    self.txt_Remarks.text = textView.text;
    local.remark = self.txt_Remarks.text;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{

    textView.inputAccessoryView = self.toolbar;
    
}


-(IBAction)zoomButtonPressed:(id)sender{

    QLPreviewController *previewController = [[QLPreviewController alloc] init];
    
    [self presentViewController:previewController animated:YES completion:^{
       
        previewController.dataSource = self;
        previewController.currentPreviewItemIndex = 1;
        [previewController reloadData];

    }];

    
}


#pragma mark - Picker Delegates
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
}




// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{


    return [[self arr_Input_List] count];

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    NSString *text = @"";
    Rawmaterials *raw = [[self arr_Input_List] objectAtIndex:row];

    
    switch ([self.common_TxtField tag]) {
            
        case SOLE_TXT_TAG:{
            text = [raw name];
        }
            break;
        case SOLE_TXT_COLOR:{
            text = [[raw colors] colorname];
        }
            break;

            
        case LEATHER1_TXT_TAG:
        case LEATHER2_TXT_TAG:
        case LEATHER3_TXT_TAG:
        case LEATHER4_TXT_TAG:
        case LEATHER5_TXT_TAG:{
            
            text = [raw name];
        }
            break;
            
        case LEATHER_COLOR1_TXT_TAG:
        case LEATHER_COLOR2_TXT_TAG:
        case LEATHER_COLOR3_TXT_TAG:
        case LEATHER_COLOR4_TXT_TAG:
        case LEATHER_COLOR5_TXT_TAG:{
            
            text = [[raw colors] colorname];
        }
            break;
            
            
            
        case LINING1_TXT_TAG:
        case LINING2_TXT_TAG:
        case LINING3_TXT_TAG:
        case LINING4_TXT_TAG:
        case LINING5_TXT_TAG:{
            
            text = [raw name];
        }
            break;
            
        case LINING_COLOR1_TXT_TAG:
        case LINING_COLOR2_TXT_TAG:
        case LINING_COLOR3_TXT_TAG:
        case LINING_COLOR4_TXT_TAG:
        case LINING_COLOR5_TXT_TAG:{
            
            text = [[raw colors] colorname];
        }
            break;

            
        default:{
            
            text = [raw name];

        }
            break;
    }
    return text;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    
    if ([[self arr_Input_List] count] == 0) {
        
        return;
    }
    
    Rawmaterials *rawmaterial = [[self arr_Input_List] objectAtIndex:row];
    
    switch ([self.common_TxtField tag]) {
            
            
        case SOLE_TXT_TAG:{
            [self setSelectedSole:self.common_TxtField withRawmaterial:rawmaterial];
        }
            break;
        case SOLE_TXT_COLOR:{
            [self setSelectedSoleColor:self.common_TxtField withRawmaterial:rawmaterial];
        }
            break;
        case SOLE_MATERIAL_TXT_COLOR:{
            
            [self setSelectedSoleMaterial:self.common_TxtField withRawmaterial:rawmaterial];
        }
            break;

        case LEATHER1_TXT_TAG:
        case LEATHER2_TXT_TAG:
        case LEATHER3_TXT_TAG:
        case LEATHER4_TXT_TAG:
        case LEATHER5_TXT_TAG:{
            
            [self setSelectedLeather:self.common_TxtField withRawmaterial:rawmaterial];
        }
            break;
            
            
        case LINING1_TXT_TAG:
        case LINING2_TXT_TAG:
        case LINING3_TXT_TAG:
        case LINING4_TXT_TAG:
        case LINING5_TXT_TAG:{
            
            [self setSelectedLeatherLining:self.common_TxtField withRawmaterial:rawmaterial];
        }
            break;

            
            
        case LINING_COLOR1_TXT_TAG:
        case LINING_COLOR2_TXT_TAG:
        case LINING_COLOR3_TXT_TAG:
        case LINING_COLOR4_TXT_TAG:
        case LINING_COLOR5_TXT_TAG:{
            
            [self setSelectedLeatherLiningColor:self.common_TxtField withRawmaterial:rawmaterial];
        }
            break;

            
            
        case LEATHER_COLOR1_TXT_TAG:
        case LEATHER_COLOR2_TXT_TAG:
        case LEATHER_COLOR3_TXT_TAG:
        case LEATHER_COLOR4_TXT_TAG:
        case LEATHER_COLOR5_TXT_TAG:{
            
            [self setSelectedLeatherColor:self.common_TxtField withRawmaterial:rawmaterial];
        }
            break;
  
        case ARTILCE_QTY:{
            
            TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
            self.common_TxtField.text = [rawmaterial name];
            [local setQty:[rawmaterial name]];
        }

            break;
        case ARTILCE_QTY_UNIT:{
            
            TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
            self.common_TxtField.text = [rawmaterial name];
            [local setQty_unit:[rawmaterial name]];
        }
            
            break;

        case ARTILCE_SIZE:{
            
            TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
            self.common_TxtField.text = [rawmaterial name];
            [local setSize:[rawmaterial name]];
        }
            
            break;

    }
    

    [[self common_TxtField] resignFirstResponder];
}

- (void)setSelectedLeather:(UITextField*)textField withRawmaterial:(Rawmaterials*)leather{

    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];

    self.common_TxtField.text = [leather name];

    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '%@' and name = '%@' limit 1",[leather rawmaterialgroupid],[leather name]];
    
    NSArray *colorsArray = [[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]] ;
    
    
    switch ([textField tag]) {
            
        case LEATHER1_TXT_TAG:
            
            if ([colorsArray count])
                [local setLeather1:[colorsArray firstObject]];
            
            self.txt_ColorLeather1.text = local.Leather1.colors.colorname;
            
            break;
            
        case LEATHER2_TXT_TAG:
            
            if ([colorsArray count])
                [local setLeather2:[colorsArray firstObject]];
            
            self.txt_ColorLeather2.text = local.Leather2.colors.colorname;
            break;
        case LEATHER3_TXT_TAG:
            
            if ([colorsArray count])
                [local setLeather3:[colorsArray firstObject]];
            
            self.txt_ColorLeather3.text = local.Leather3.colors.colorname;
            
            break;
        case LEATHER4_TXT_TAG:
            if ([colorsArray count])
                [local setLeather4:[colorsArray firstObject]];
            
            self.txt_ColorLeather4.text = local.Leather4.colors.colorname;
            break;
        case LEATHER5_TXT_TAG:
            if ([colorsArray count])
                [local setLeather5:[colorsArray firstObject]];
            
            self.txt_ColorLeather5.text = local.Leather5.colors.colorname;
            break;
            
        default:
            break;
    }
    
    
}
- (void)setSelectedLeatherColor:(UITextField*)textField withRawmaterial:(Rawmaterials*)leather{
    
    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
    
    self.common_TxtField.text = [[leather colors] colorname];
    
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '%@' and name = '%@' and colorid = '%@'",[leather rawmaterialgroupid],[leather name],[leather colorid]];
    
    NSArray *colorsArray = [[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]] ;
    
    
    switch ([textField tag]) {
            
        case LEATHER_COLOR1_TXT_TAG:
            
            if ([colorsArray count])
                [local setLeather1:[colorsArray firstObject]];
            
            
            break;
            
        case LEATHER2_TXT_TAG:
            
            if ([colorsArray count])
                [local setLeather2:[colorsArray firstObject]];
            
            break;
        case LEATHER3_TXT_TAG:
            
            if ([colorsArray count])
                [local setLeather3:[colorsArray firstObject]];
            
            
            break;
        case LEATHER4_TXT_TAG:
            if ([colorsArray count])
                [local setLeather4:[colorsArray firstObject]];
            
            break;
        case LEATHER5_TXT_TAG:
            if ([colorsArray count])
                [local setLeather5:[colorsArray firstObject]];
            
            break;
            
        default:
            break;
    }
    
    //    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '%@' GROUP BY name",[leather rawmaterialgroupid]];
    //    NSMutableArray *materialGroup = [NSMutableArray arrayWithArray:[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]]] ;
    
}
- (void)setSelectedLeatherLining:(UITextField*)textField withRawmaterial:(Rawmaterials*)lining{
    
    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
    
    self.common_TxtField.text = [lining name];
    
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '%@' and name = '%@' limit 1",[lining rawmaterialgroupid],[lining name]];
    
    NSArray *colorsArray = [[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]] ;
    
    
    switch ([textField tag]) {
            
        case LINING1_TXT_TAG:
            
            if ([colorsArray count])
                [local setLining1:[colorsArray firstObject]];
            
            self.txt_ColorLining1.text = local.Lining1.colors.colorname;
            
            break;
            
        case LINING2_TXT_TAG:
            
            if ([colorsArray count])
                [local setLining2:[colorsArray firstObject]];
            
            self.txt_ColorLining2.text = local.Lining2.colors.colorname;
            break;
        case LINING3_TXT_TAG:
            
            if ([colorsArray count])
                [local setLining3:[colorsArray firstObject]];
            
            self.txt_ColorLining3.text = local.Lining3.colors.colorname;
            
            break;
        case LINING4_TXT_TAG:
            if ([colorsArray count])
                [local setLining4:[colorsArray firstObject]];
            
            self.txt_ColorLining4.text = local.Lining4.colors.colorname;
            break;
        case LINING5_TXT_TAG:
            if ([colorsArray count])
                [local setLining5:[colorsArray firstObject]];
            
            self.txt_ColorLining5.text = local.Lining5.colors.colorname;
            break;
            
        default:
            break;
    }
    
    
}
- (void)setSelectedLeatherLiningColor:(UITextField*)textField withRawmaterial:(Rawmaterials*)lining{
    
    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
    
    self.common_TxtField.text = [[lining colors] colorname];
    
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '%@' and name = '%@' and colorid = '%@'",[lining rawmaterialgroupid],[lining name],[lining colorid]];
    
    NSArray *colorsArray = [[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]] ;
    
    
    switch ([textField tag]) {
            
        case LINING_COLOR1_TXT_TAG:
            
            if ([colorsArray count])
                [local setLining1:[colorsArray firstObject]];
            
            
            break;
            
        case LINING_COLOR2_TXT_TAG:
            
            if ([colorsArray count])
                [local setLining2:[colorsArray firstObject]];
            
            break;
        case LINING_COLOR3_TXT_TAG:
            
            if ([colorsArray count])
                [local setLining3:[colorsArray firstObject]];
            
            
            break;
        case LINING_COLOR4_TXT_TAG:
            if ([colorsArray count])
                [local setLining4:[colorsArray firstObject]];
            
            break;
        case LINING_COLOR5_TXT_TAG:
            if ([colorsArray count])
                [local setLining5:[colorsArray firstObject]];
            
            break;
            
        default:
            break;
    }
    
    //    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '%@' GROUP BY name",[leather rawmaterialgroupid]];
    //    NSMutableArray *materialGroup = [NSMutableArray arrayWithArray:[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]]] ;
    
}
- (void)setSelectedSole:(UITextField*)textField withRawmaterial:(Rawmaterials*)leather{
    
    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
    
    self.common_TxtField.text = [leather name];
    
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '%@' and name = '%@' limit 1",[leather rawmaterialgroupid],[leather name]];
    
    NSArray *colorsArray = [[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]] ;
    
    if ([colorsArray count]){
    
        [local setSole:[colorsArray firstObject]];
        self.txt_SoleColor.text = local.Sole.colors.colorname;
    }
    
    
    
}
- (void)setSelectedSoleColor:(UITextField*)textField withRawmaterial:(Rawmaterials*)leather{
    
    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
    
    self.common_TxtField.text = [[leather colors] colorname];
    
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialgroupid = '%@' and name = '%@' and colorid = '%@'",[leather rawmaterialgroupid],[leather name],[leather colorid]];
    
    NSArray *colorsArray = [[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]] ;
    
    if ([colorsArray count])
        [local setSole:[colorsArray firstObject]];
    
}
- (void)setSelectedSoleMaterial:(UITextField*)textField withRawmaterial:(Rawmaterials*)leather{
    
    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
    self.common_TxtField.text = [leather name];
    [local setSoleMaterial:leather];
    
}


#pragma mark - Add To Cart
-(IBAction)addToCart:(id)sender{

    [[self common_TxtField] resignFirstResponder];
    [[self txt_Remarks] resignFirstResponder];
    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];

    local.articleid = [local.articleid length] ? local.articleid : @"";
    local.qty = [local.qty length] ? local.qty : @"";
    local.size = [local.size length] ? local.size : @"";
    local.qty_unit = [local.qty_unit length] ? local.qty_unit : @"";
    local.remark = [local.remark length] ? local.remark : @"";

    NSString *sqlQury = [NSString stringWithFormat:@"INSERT INTO TrxTransaction (TransactionId,articleid,qty,qty_unit,size,remark) VALUES ('%@','%@','%@','%@','%@','%@')",local.TransactionId,local.articleid,local.qty,local.qty_unit,local.size,local.remark];
    
    [[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQury asObject:[TrxTransaction class]];

    
    [self insertIntoTrx_Rawmaterials:local.Sole];
    [self insertIntoTrx_Rawmaterials:local.SoleMaterial];

    
    [self insertIntoTrx_Rawmaterials:local.Leather1];
    [self insertIntoTrx_Rawmaterials:local.Leather2];
    [self insertIntoTrx_Rawmaterials:local.Leather3];
    [self insertIntoTrx_Rawmaterials:local.Leather4];
    [self insertIntoTrx_Rawmaterials:local.Leather5];
    
    
    [self insertIntoTrx_Rawmaterials:local.Lining1];
    [self insertIntoTrx_Rawmaterials:local.Lining2];
    [self insertIntoTrx_Rawmaterials:local.Lining3];
    [self insertIntoTrx_Rawmaterials:local.Lining4];
    [self insertIntoTrx_Rawmaterials:local.Lining5];
    
    
    CartViewController *cart = [[self storyboard] instantiateViewControllerWithIdentifier:@"CartViewController"];
    [[self navigationController] pushViewController:cart animated:YES];
    cart = nil;

}
- (void)insertIntoTrx_Rawmaterials:(Rawmaterials*)rawmaterial{

    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];

    if (rawmaterial) {
        
        
        rawmaterial.rawmaterialid = [rawmaterial.rawmaterialid length] ? rawmaterial.rawmaterialid : @"";
        rawmaterial.rawmaterialgroupid = [rawmaterial.rawmaterialgroupid length] ? rawmaterial.rawmaterialgroupid : @"";
        NSString *sqlQury = [NSString stringWithFormat:@"INSERT INTO Trx_Rawmaterials (TransactionId,rawmaterialid,rawmaterialgroupid,leatherpriority,colorid) VALUES ('%@','%@','%@','%@','%@')",local.TransactionId,rawmaterial.rawmaterialid,rawmaterial.rawmaterialgroupid,@"0",rawmaterial.colorid];
        [[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQury asObject:[Trx_Rawmaterials class]];
    }


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
    
    if (tableView == [self tbl_RawMatarial])
        return 3;

    else if (tableView == [self relatedProduct])
        return [self.arrArticles count];
    
    else if(tableView == _tbl_Leather)
        return rowForRawMatarial ;
    
    else
        return  rowForRawMatarial1;

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    
    if (tableView == [self tbl_RawMatarial])
        return [self cellForTbl_RawMatarial:tableView cellForRowAtIndexPath:indexPath];

    
     if(tableView == _relatedProduct){
        RelatedProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RelatedProductTableViewCell" owner:self options:nil] firstObject];
            
        }
        
        // Configure the cell...
        Articles *article = [[self arrArticles] objectAtIndex:indexPath.row];
        cell.lbl_Title.text = [article articlename];
        cell.lbl_Description.text = [NSString stringWithFormat:@"Article No.: %@",[article articleid]];
        cell.lbl_Price.text = [NSString stringWithFormat:@"€%@",[article price]];
        
        
        Article_Image *articleImage = [article.images firstObject];
        if (articleImage) {
            NSString *fileName = [articleImage.imagePath lastPathComponent];
            NSString *filePath = [[[AppDataManager sharedAppDatamanager] imageDirPath] stringByAppendingPathComponent:fileName];
            cell.imgV_Logo.image = [UIImage imageWithContentsOfFile:filePath];
            
        }
        
        return cell;

    }else if(tableView == _tbl_Leather){
    
        
        static NSString *FirstCell = @"FirstCell1";
        static NSString *AddCell = @"AddCell";
        static NSString *LastCell = @"LastCell";
        
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:FirstCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:FirstCell];
            
        }
        cell.textLabel.text = @"Shameem";
        
        return cell;
    
    }else {
    
        static NSString *FirstCell = @"FirstCell11";
        static NSString *AddCell = @"AddCell";
        static NSString *LastCell = @"LastCell";
        
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:FirstCell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:FirstCell];
            
        }
        cell.textLabel.text = @"Shameem";
        
        return cell;

    }
    

    
}

- (RawMatarialCell*)cellForTbl_RawMatarial:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    static NSString *FirstCell  = @"FirstCell";
    static NSString *AddCell    = @"AddCell";
    static NSString *LastCell   = @"LastCell";

    RawMatarialCell *cell = nil;
    
    if (indexPath.row == 1) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:FirstCell];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RawMatarialCell" owner:self options:nil] firstObject];
            
        }
        cell.indeX = indexPath.row;
        _tbl_Leather = cell.tbl_AddLeather;
        _tbl_Lining = cell.tbl_AddLining;
        
    }else if(indexPath.row == 0){
        
        cell = [tableView dequeueReusableCellWithIdentifier:AddCell];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RawMatarialCell" owner:self options:nil] objectAtIndex:1];
            
        }
        cell.indeX = indexPath.row;
        
    }else if (indexPath.row == 2){
        
        cell = [tableView dequeueReusableCellWithIdentifier:LastCell];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RawMatarialCell" owner:self options:nil] lastObject];
            
        }
        cell.indeX = indexPath.row;
        
        [cell addLeather:^(int rowIndex) {
            
            [[self tbl_RawMatarial] beginUpdates];
            NSIndexPath *path = [NSIndexPath indexPathForRow:rowForRawMatarial inSection:0];
            [[self tbl_RawMatarial] insertRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationTop];
            rowForRawMatarial++;
            [[self tbl_RawMatarial] endUpdates];
            
            [[self tbl_RawMatarial] scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
        }];
        
        
        [cell addLining:^(int rowIndex) {
            
            
        }];
        
        
    }
    // Configure the cell...
    //        Articles *article = [[self arrArticles] objectAtIndex:indexPath.row];
    //        cell.lbl_Title.text = [article articlename];
    //        cell.lbl_Description.text = [NSString stringWithFormat:@"Article No.: %@",[article articleid]];
    //        cell.lbl_Price.text = [NSString stringWithFormat:@"€%@",[article price]];
    //
    //
    //        Article_Image *articleImage = article.image;
    //        if (articleImage) {
    //            NSString *fileName = [articleImage.url lastPathComponent];
    //            NSString *filePath = [[[AppDataManager sharedAppDatamanager] imageDirPath] stringByAppendingPathComponent:fileName];
    //            cell.imgV_Logo.image = [UIImage imageWithContentsOfFile:filePath];
    //
    //        }
    
    
    
    
    return cell;
    
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ((tableView == [self tbl_RawMatarial]) && ([indexPath row] == 1)) {
     
        return 146*(rowForRawMatarial > rowForRawMatarial1 ? rowForRawMatarial : rowForRawMatarial1);
    }else if ((tableView == [self tbl_RawMatarial]) && ([indexPath row] == 2)){
    
        return 300;
    }
    
    return 146;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    Articles *article = [[self arrArticles] objectAtIndex:indexPath.row];
//    [[AppDataManager sharedAppDatamanager] newTransactionWithArticleId:article.articleid];
//    [[AppDataManager sharedAppDatamanager] newTransactionWithArticleId:article.articleid];
//    [self tapOnRelatedBtn:self.dargButton];
//    [self refreshUI];
    
    
//    [tableView beginUpdates];
//    if (tableView == _tbl_Leather) {
//        
////        NSIndexPath *path = [NSIndexPath indexPathForRow:rowForRawMatarial inSection:0];
////        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationTop];
//        rowForRawMatarial++;
//
//        
//    }else if (tableView == _tbl_Lining) {
//        
////        NSIndexPath *path = [NSIndexPath indexPathForRow:rowForRawMatarial1 inSection:0];
////        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationTop];
//        rowForRawMatarial1++;
//
//        
//    }
//    
////    [tableView endUpdates];
//    
//    [[self tbl_RawMatarial] reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
//    [_tbl_Leather reloadData];
//    [_tbl_Lining reloadData];
}



- (void)refreshArticleList:(NSString*)searchString{
    
    NSString *sqlQuery =@"SELECT * FROM Article_Master";
    self.arrArticles = [NSMutableArray arrayWithArray:[[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQuery asObject:[Articles class]]];
    [[self relatedProduct] reloadData];
    
}

#pragma mark - Zoom View
#pragma mark - QLPreviewControllerDataSource Methods
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return [self.article_Images count];
}


- (id)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    Article_Image *article = [[self article_Images] objectAtIndex:index];
    NSString *fileName = [article.imagePath lastPathComponent];
    NSString *filePath = [[[AppDataManager sharedAppDatamanager] imageDirPath] stringByAppendingPathComponent:fileName];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath isDirectory:NO];
    return fileURL;
}


@end
