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
@property(nonatomic,strong) NSOperationQueue *localQueue;
@end
static dispatch_once_t onceToken;

@implementation ArticleSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view_SearchBox.layer.cornerRadius = 20;
    CGColorRef borderColor = [UIColor grayColor].CGColor;
    self.view_SearchBox.layer.borderColor = borderColor;
    self.view_SearchBox.layer.borderWidth = 1;

    [self setTitle:@"Article"];

    //self.txtField_Search_Clients.text = self.strSearchString;
    onceToken = 0;

}
- (NSOperationQueue*)localQueue{

    if (!_localQueue) {
        _localQueue = [[NSOperationQueue alloc] init];
        [_localQueue setName:@"com.articleselection.virola"];
    }
    return _localQueue;
}
- (void)viewWillAppear:(BOOL)animated{

}
- (void)viewDidAppear:(BOOL)animated{
    
    dispatch_once(&onceToken, ^{
        [self loadArticles];
        
    });

}

- (void)viewDidDisappear:(BOOL)animated{

    [[self localQueue] cancelAllOperations];


}


- (NSString *)getFilterCriteria{

    NSString *sqlQuery =@"SELECT * FROM Article_Master order by articleid";
    if ([[self strSearchString] length]) {
        
        if ([[self searchCriteria] isEqualToString:@"ARTICLE"]) {
            
            sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Article_Master WHERE (articleid like '%%%@%%') order by articleid",self.strSearchString];
            
        }else if ([[self searchCriteria] isEqualToString:@"LAST"]){
        
            sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Article_Master WHERE (lastName like '%%%@%%') order by lastName",self.strSearchString];

        }else if ([[self searchCriteria] isEqualToString:@"SOLE"]){
            
            sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Article_Master WHERE (soleName like '%%%@%%') order by soleName",self.strSearchString];
        }
        
    }
    return sqlQuery;
}

- (void)loadArticles{

    
    
    __weak ArticleSelectionViewController *weakSelf = self;
    
    
    [weakSelf showActivityIndicator:@"Loading Articles..."];
    [[weakSelf localQueue] cancelAllOperations];
    
    [[weakSelf localQueue] addOperationWithBlock:^{
        
        NSString *sqlQuery =[weakSelf getFilterCriteria];
        self.arr_ClientList = [NSMutableArray arrayWithArray:[[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQuery asObject:[Articles class]]];
        self.arr_Common_List = self.arr_ClientList;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideActivityIndicator];
            [[weakSelf tbl_ClientList] reloadData];
        });
        
    }];
    


}
- (void)refreshArticleList:(NSString*)searchString{
    
    
    NSString *strPredicate = nil;
    NSPredicate *predicate = nil;
    
    
    
    if ([[self searchCriteria] length] && [searchString length]) {
        
        if ([[self searchCriteria] isEqualToString:@"ARTICLE"]) {
            
            strPredicate = [NSString stringWithFormat:@"lastName contains[c]'%@' OR soleName contains[c]'%@'",searchString,searchString];
            
        }else if ([[self searchCriteria] isEqualToString:@"LAST"]){
            
            strPredicate = [NSString stringWithFormat:@"articleid contains[c]'%@' OR soleName contains[c]'%@'",searchString,searchString];
            
        }else if ([[self searchCriteria] isEqualToString:@"SOLE"]){
            
            strPredicate = [NSString stringWithFormat:@"articleid contains[c]'%@' OR lastName contains[c]'%@'",searchString,searchString];
        }
        
        predicate = [NSPredicate predicateWithFormat:strPredicate];
        NSArray *arr = [self.arr_ClientList filteredArrayUsingPredicate:predicate];
        self.arr_Common_List = [NSMutableArray arrayWithArray:arr];
        
    }else if([searchString length]){
    
        strPredicate = [NSString stringWithFormat:@"lastName contains[c]'%@' OR soleName contains[c]'%@'",searchString,searchString];
        predicate = [NSPredicate predicateWithFormat:strPredicate];
        NSArray *arr = [self.arr_ClientList filteredArrayUsingPredicate:predicate];
        self.arr_Common_List = [NSMutableArray arrayWithArray:arr];

    }else{
    
        self.arr_Common_List = self.arr_ClientList;

    }


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
    
    
    
    NSString *textString = textField.text;
    if (range.length > 0) {
        textString = [textString stringByReplacingCharactersInRange:range withString:@""];
    }
    else {
        if(range.location == [textString length]) {
            textString = [textString stringByAppendingString:string];
        }
        else {
            textString = [textString stringByReplacingCharactersInRange:range withString:string];
        }
    }
    
    [self refreshArticleList:textString];
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    [self refreshArticleList:@""];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    // [textField resignFirstResponder];
    
    
    
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
    
    return [[self arr_Common_List] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    ArticleCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ArticleCell" owner:self options:nil] firstObject];
        [cell initilizeCell];
    }
    Articles *article = [[self arr_Common_List] objectAtIndex:indexPath.row];
    cell.lbl_Title.text = [article articlename];
    cell.lbl_Description.text = [NSString stringWithFormat:@"Article No.: %@",[article articleid]];
    cell.lbl_Price.text = [NSString stringWithFormat:@"€%@",[article price]];
    [[cell lbl_Price_Gbp] setText:[NSString stringWithFormat:@"£%@",[article price_gbp]]];
    [[cell lbl_Price_Usd] setText:[NSString stringWithFormat:@"$%@",[article price_usd]]];

    cell.backgroundColor = [UIColor clearColor];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        Article_Image *articleImage = [article.images firstObject];
        
        if (articleImage) {
            NSString *fileName = [articleImage.imagePath lastPathComponent];
            NSString *filePath = [[[AppDataManager sharedAppDatamanager] imageDirPath] stringByAppendingPathComponent:fileName];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cell.imgV_Logo.image = [UIImage imageWithContentsOfFile:filePath];
                
            });

        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cell.imgV_Logo.image = nil;
                
            });
        }

        
    });

    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 99.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Articles *article = [[self arr_Common_List] objectAtIndex:indexPath.row];

    AddToCartViewController *addToCartViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"AddToCartViewController"];
    [[AppDataManager sharedAppDatamanager] setTransaction:nil];
    [[AppDataManager sharedAppDatamanager] newTransactionWithArticleId:article.articleid withNewDevelopment:NO];
    [self.navigationController pushViewController:addToCartViewController animated:YES];
    
    
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
