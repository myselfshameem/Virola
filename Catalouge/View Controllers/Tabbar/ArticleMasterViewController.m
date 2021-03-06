//
//  ArticleMasterViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "ArticleMasterViewController.h"
#import "igViewController.h"
#import "ArticleSelectionViewController.h"
#import "AddToCartViewController.h"
CustomeAlert *alert;


@interface ArticleMasterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *view_Barcode_Scan;
@property (weak, nonatomic) IBOutlet UIView *view_QR_Code_Scan;
@property (weak, nonatomic) IBOutlet UIView *view_Article;
@property (weak, nonatomic) IBOutlet UIView *view_Last;
@property (weak, nonatomic) IBOutlet UIView *view_Sole;

@end

@implementation ArticleMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view_Barcode_Scan.layer.cornerRadius = 22;
    self.view_QR_Code_Scan.layer.cornerRadius = 22;
    self.view_Article.layer.cornerRadius = 22;
    self.view_Last.layer.cornerRadius = 22;
    self.view_Sole.layer.cornerRadius = 22;

    self.view_Article.layer.borderColor = [UIColor grayColor].CGColor;
    self.view_Article.layer.borderWidth = 1;

    self.view_Barcode_Scan.layer.borderColor = [UIColor grayColor].CGColor;
    self.view_Barcode_Scan.layer.borderWidth = 1;

    
    self.view_QR_Code_Scan.layer.borderColor = [UIColor grayColor].CGColor;
    self.view_QR_Code_Scan.layer.borderWidth = 1;

    
    self.view_Last.layer.borderColor = [UIColor grayColor].CGColor;
    self.view_Last.layer.borderWidth = 1;

    
    self.view_Sole.layer.borderColor = [UIColor grayColor].CGColor;
    self.view_Sole.layer.borderWidth = 1;

    
    
    
    [self.txtField_barcode setDelegate:self];
    [self.txtField_QRCode setDelegate:self];
    [self.txtField_ArticleId setDelegate:self];

    
    [self.txtField_barcode setPlaceholder:@"ENTER BARCODE"];
    [self.txtField_QRCode setPlaceholder:@"ENTER QR CODE"];
    [self.txtField_ArticleId setPlaceholder:@"ENTER ARTICLE NAME"];
    [self.txtField_Last setPlaceholder:@"ENTER LAST"];
    [self.txtField_Sole setPlaceholder:@"ENTER SOLE"];

    
    [self setTitle:@"Article"];
    
}


#pragma mark - TextField Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;

}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    self.common_TxtField = textField;
    return YES;
}       // return NO to disallow editing.

// called when 'return' key pressed. return NO to ignore.

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
- (IBAction)barcodeScanner:(id)sender{


    BAR_CODE_TYPE barcodeType = _2DBAR_CODE;
    if ([sender tag] == 1) {
        self.common_TxtField = [self txtField_barcode];
        barcodeType = _2DBAR_CODE;
    }else if ([sender tag] == 2){
        self.common_TxtField = [self txtField_QRCode];
        barcodeType = QR_CODE;
    }else if ([sender tag] == 3){
        self.common_TxtField = [self txtField_Last];
    }else if ([sender tag] == 4){
        self.common_TxtField = [self txtField_Sole];
    }

    __block igViewController *IgViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"igViewController"];
    IgViewController.barcodeTYpe = barcodeType;
    [[self navigationController] pushViewController:IgViewController animated:YES];

    

    
    [IgViewController barcodeScanned:^(NSString *barcodeString) {
       
        
        [[self txtField_barcode]setText:@""];
        [[self txtField_QRCode]setText:@""];
        [[self txtField_ArticleId]setText:@""];
        
        NSArray *arr = [[CXSSqliteHelper sharedSqliteHelper]runQuery:[NSString stringWithFormat:@"SELECT * FROM Article_Master WHERE articleid='%@'",barcodeString] asObject:[Articles class]];
        
        if ([arr count]) {
            
            Articles *article = [arr firstObject];
            
            AddToCartViewController *addToCartViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"AddToCartViewController"];
            [[AppDataManager sharedAppDatamanager] newTransactionWithArticleId:article.articleid withNewDevelopment:NO];
            [self.navigationController pushViewController:addToCartViewController animated:YES];

            
        }else{
        
            alert = [[CustomeAlert alloc] init];
            [alert showAlertWithTitle:nil message:[NSString stringWithFormat:@"Article not found for Scanned Barcode : [%@]",barcodeString] cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
            }];

        }
        
    }];
}


- (IBAction)browseArticle:(id)sender{



    ArticleSelectionViewController *articleSelection = [[self storyboard] instantiateViewControllerWithIdentifier:@"ArticleSelectionViewController"];
    articleSelection.strSearchString = self.common_TxtField.text;
    
    if (self.common_TxtField == [self txtField_ArticleId]){
        [articleSelection setSearchCriteria:@"ARTICLE"];
    }else
    if (self.common_TxtField == [self txtField_Last]){
        [articleSelection setSearchCriteria:@"LAST"];
    }else if (self.common_TxtField == [self txtField_Sole]){
        [articleSelection setSearchCriteria:@"SOLE"];
    }

    
    [[self navigationController] pushViewController:articleSelection animated:YES];
    articleSelection = nil;
    
}

@end
