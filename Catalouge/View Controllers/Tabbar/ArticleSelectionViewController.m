//
//  ArticleSelectionViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "ArticleSelectionViewController.h"
#import "ArticleCell.h"
#import "AddToCartViewController.h"
#import "AlertWithTableViewController.h"
#import "CXTableView.h"
@interface ArticleSelectionViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@end

@implementation ArticleSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view_SearchBox.layer.cornerRadius = 20;
    CGColorRef borderColor = [UIColor grayColor].CGColor;
    self.view_SearchBox.layer.borderColor = borderColor;
    self.view_SearchBox.layer.borderWidth = 1;

    [self setTitle:@"Article"];

    self.txtField_Search_Clients.text = self.strSearchString;
    
    
//    [[self tbl_ClientList] setSeparatorColor:[UIColor lightGrayColor]];
//    [[self tbl_ClientList] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];

}

- (void)viewWillAppear:(BOOL)animated{

    [self refreshArticleList:self.txtField_Search_Clients.text];
}

- (void)refreshArticleList:(NSString*)searchString{
    
    NSString *sqlQuery =@"SELECT * FROM Article_Master";
    
    if ([searchString length]) {
        sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Article_Master WHERE (articlename like '%%%@%%') OR (articleid like '%%%@%%')",searchString,searchString];
    }
    self.arr_ClientList = [NSMutableArray arrayWithArray:[[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQuery asObject:[Articles class]]];
    [[self tbl_ClientList] reloadData];
    
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

- (NSMutableArray*)arr_ClientList{

    if (!_arr_ClientList) {
        _arr_ClientList = [[NSMutableArray alloc] init];
    }
    return _arr_ClientList;
}


#pragma mark - UITextField delegates


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    [self refreshArticleList:@""];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    // [textField resignFirstResponder];
    
    [self refreshArticleList:textField.text];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}


#pragma mark - TableView
#pragma mark   Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self arr_ClientList] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    ArticleCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ArticleCell" owner:self options:nil] firstObject];
    }
    Articles *article = [[self arr_ClientList] objectAtIndex:indexPath.row];
    cell.lbl_Title.text = [article articlename];
    cell.lbl_Description.text = [NSString stringWithFormat:@"Article No.: %@",[article articleid]];
    cell.lbl_Price.text = [NSString stringWithFormat:@"€%@",[article price]];
    
    cell.backgroundColor = [UIColor clearColor];
    Article_Image *articleImage = article.image;
    if (articleImage) {
        NSString *fileName = [articleImage.url lastPathComponent];
        NSString *filePath = [[[AppDataManager sharedAppDatamanager] imageDirPath] stringByAppendingPathComponent:fileName];
        cell.imgV_Logo.image = [UIImage imageWithContentsOfFile:filePath];
 
    }else{
    
        cell.imgV_Logo = nil;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 89.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Articles *article = [[self arr_ClientList] objectAtIndex:indexPath.row];

    AddToCartViewController *addToCartViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"AddToCartViewController"];
    [[AppDataManager sharedAppDatamanager] newTransactionWithArticleId:article.articleid];
    [self.navigationController pushViewController:addToCartViewController animated:YES];
    
    
}



@end
