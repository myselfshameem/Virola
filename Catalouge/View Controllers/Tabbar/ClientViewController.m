//
//  ClientViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "ClientViewController.h"
#import "ClientTableViewCell.h"
#import "ArticleSelectionViewController.h"
@interface ClientViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSArray *arr_Clients;
@end

@implementation ClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.btn_AddClient.layer.cornerRadius = 18;
    self.view_SearchBox.layer.cornerRadius = 20;
    
    CGColorRef borderColor = [UIColor grayColor].CGColor;
    self.view_SearchBox.layer.borderColor = borderColor;
    self.view_SearchBox.layer.borderWidth = 1;
    
    [self setTitle:@"Clients"];
    

}

- (void)viewWillAppear:(BOOL)animated{

    [self refreshClientList:@""];
    
}
- (void)refreshClientList:(NSString*)searchString{

    NSString *sqlQuery =@"SELECT * FROM Client_Master";

    if ([searchString length]) {
        sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Client_Master WHERE (name like '%%%@%%') OR (clientid like '%%%@%%')",searchString,searchString];
    }
    self.arr_Clients = [[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQuery asObject:[Clients class]];
    [[self tbl_Clients] reloadData];

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

#pragma mark - UITextField delegates

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    [self refreshClientList:@""];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    // [textField resignFirstResponder];

    [self refreshClientList:textField.text];

    
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
    
    return [self.arr_Clients count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    ClientTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ClientTableViewCell" owner:self options:nil] firstObject];
    }
    Clients *client = [[self arr_Clients] objectAtIndex:indexPath.row];
    cell.lblClient_Name.text = client.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    

    if (self.clientSelectedBlock) {
        
        Clients *clinet = [[self arr_Clients] objectAtIndex:indexPath.row];
        [[AppDataManager sharedAppDatamanager] setSelectedClient:clinet];
        self.clientSelectedBlock(clinet.clientid);
        [[self navigationController] popViewControllerAnimated:YES];
        return;
        
    }else{
        
        [[AppDataManager sharedAppDatamanager] setSelectedClient:[[self arr_Clients] objectAtIndex:indexPath.row]];
        ArticleSelectionViewController *articleSelect = [[self storyboard] instantiateViewControllerWithIdentifier:@"ArticleSelectionViewController"];
        [[self navigationController] pushViewController:articleSelect animated:YES];
    }
    
    
}


#pragma mark - Add New Client
- (IBAction)addNewClient:(id)sender{

    AddClientViewController *addClient = [[self storyboard] instantiateViewControllerWithIdentifier:@"AddClientViewController"];
    addClient.client = nil;
    addClient.isNewClient = YES;
    [[self navigationController] pushViewController:addClient animated:YES];

}

- (void)callBackWhenClientSelected:(ClientSelectedBlock)clientCallBlock{
    
    self.clientSelectedBlock = nil;
    self.clientSelectedBlock = clientCallBlock;
}


@end
