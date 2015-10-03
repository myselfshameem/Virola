//
//  OrderViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 8/22/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderCellTableViewCell.h"
static dispatch_once_t onceTokenForOrders;


@interface OrderViewController ()
@property(nonatomic,strong) NSOperationQueue *localQueue;
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view_SearchBox.layer.cornerRadius = 20;
    CGColorRef borderColor = [UIColor grayColor].CGColor;
    self.view_SearchBox.layer.borderColor = borderColor;
    self.view_SearchBox.layer.borderWidth = 1;
    
    
    self.txtField_Search_Clients.text = self.strSearchString;
    self.arr_ClientList = self.arr_Common_List;

    
    //Reset
    onceTokenForOrders = 0;

    [self setTitle:@"Orders"];
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
    
    dispatch_once(&onceTokenForOrders, ^{
        [self loadOrders];
        
    });
    
}

- (void)loadOrders{
    
    
    
    __weak OrderViewController *weakSelf = self;
    
    
    [weakSelf showActivityIndicator:@"Loading Articles..."];
    [[weakSelf localQueue] cancelAllOperations];
    
    [[weakSelf localQueue] addOperationWithBlock:^{
        
        NSString *sqlQuery = @"SELECT * FROM Orders order by rowid DESC";
        self.arr_ClientList = [NSMutableArray arrayWithArray:[[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQuery asObject:[Orders class]]];
        self.arr_Common_List = self.arr_ClientList;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideActivityIndicator];
            [[weakSelf tbl_ClientList] reloadData];
        });
        
    }];
    
    
    
}
- (void)viewDidDisappear:(BOOL)animated{
    
    [[self localQueue] cancelAllOperations];
    
    
}


- (void)refreshArticleList:(NSString*)searchString{
    
    
    NSString *strPredicate = nil;
    NSPredicate *predicate = nil;
    strPredicate = [NSString stringWithFormat:@"orderID contains[c]'%@' OR orderNo contains[c]'%@' OR clientCode contains[c]'%@'",searchString,searchString,searchString];
    predicate = [NSPredicate predicateWithFormat:strPredicate];

    
    if ([searchString length]) {
        NSArray *arr = [self.arr_ClientList filteredArrayUsingPredicate:predicate];
        self.arr_Common_List = [NSMutableArray arrayWithArray:arr];
        
    }else{
        self.arr_Common_List = self.arr_ClientList;
    }
    
    
    [[self tbl_ClientList] reloadData];
    
}


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
    
    return [self.arr_Common_List count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"OrderCellTableViewCell";
    OrderCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderCellTableViewCell" owner:self options:nil] firstObject];
        cell.backgroundColor = [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    Orders *order = [[self arr_Common_List] objectAtIndex:indexPath.row];
    [[cell lbl_OrderNo] setText:[NSString stringWithFormat:@"Order No : %@",[order orderNo]]];
    [[cell lbl_OrderDate] setText:[NSString stringWithFormat:@"Order Date : %@",[[order orderDate] substringWithRange:NSMakeRange(0, 10)]]];
    [[cell lbl_ClientName] setText:[NSString stringWithFormat:@"Client Name : %@",[order company]]];
    cell.tag = indexPath.row;
    
    [cell registerResendOrderCallBlock:^(NSInteger tag) {
       
        //Call Resend PHP

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [self showActivityIndicator:@"Re-Sending Order..."];
            
            Orders *order = [[self arr_Common_List] objectAtIndex:tag];
            
            [[ApiHandler sharedApiHandler] reSendOrderApiHandlerWithApiCallBlock:^(id data, NSError *error) {
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    [self hideActivityIndicator];
                });
                
                if (error) {
                    //Error
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Virola" message:@"successfully Resent Order." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                        [alertView show];
                        alertView = nil;
                    });
                    
                }
                
                
                
            } withOrderId:[order orderID]];
        });

        
        
        
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 93;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
    
}


- (void)registerOptionSelectionCallback:(OptionSelectedCallBack)optionSelectedCallBack{
    
    _optionSelectedCallBack = optionSelectedCallBack;
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


- (void)showActivityIndicator:(NSString*)msg{
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:msg];
    
    
}

- (void)hideActivityIndicator{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}

@end
