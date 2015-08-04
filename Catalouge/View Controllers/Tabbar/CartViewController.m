//
//  CartViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/19/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "CartViewController.h"
#import "CartTableViewCell.h"
#import "ClientViewController.h"
CustomeAlert *alert;

@interface CartViewController ()
@property(nonatomic,strong) __block NSArray *cartArr;
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn_PlaceOrder.layer.cornerRadius = 12;
    [self setTitle:@"Cart"];
    

    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [self refreshUI];
}

- (void)refreshUI{

    self.cartArr = [self fetchAllCartItems];
    [self.tbl_List_Cart reloadData];

    __block double total = 0.0f;
    __block NSInteger totalQty = 0;
    [[self cartArr] enumerateObjectsUsingBlock:^(TrxTransaction *transaction, NSUInteger idx, BOOL *stop) {
        
        total = total + [transaction.article.price doubleValue];
        totalQty = totalQty + [transaction.qty integerValue];
    }];
    
    [[self lbl_Price] setText:[NSString stringWithFormat:@"€ %0.2f",total]];
    [[self lbl_Total_Item] setText:[NSString stringWithFormat:@"Total\n%i Items",totalQty]];
    
    NSString *cleintName = [[[AppDataManager sharedAppDatamanager] selectedClient] name];
    
    [[self lbl_Client_Name] setText:[NSString stringWithFormat:@"Client - %@",[cleintName length] ? cleintName : @""]];

    [[self lbl_UserName] setText:[NSString stringWithFormat:@"Agent - %@",[[[[AppDataManager sharedAppDatamanager] account] user] username] ? [[[[AppDataManager sharedAppDatamanager] account] user] username] : @""]];

    
    NSInteger order = [[self cartArr] count];
    
    if (order !=0) {
        [[self tabBarItem] setBadgeValue:[NSString stringWithFormat:@"%i",order]];
    }else{
        [[self tabBarItem] setBadgeValue:@""];
    }
    
}



- (NSArray*)fetchAllCartItems{
    NSString *sql = @"select * from TrxTransaction";
    NSArray *arr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:sql asObject:[TrxTransaction class]];

    return arr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.cartArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CartTableViewCell" owner:self options:nil] firstObject];

    }
    
    cell.vw_qty.layer.cornerRadius = 5;
    cell.vw_qty.layer.borderColor = [UIColor redColor].CGColor;

    cell.row = indexPath.row;

    // Configure the cell...
    TrxTransaction *trx = [self.cartArr objectAtIndex:indexPath.row];
    Articles *article = [trx article];

    cell.lbl_Title.text = [article articlename];
    cell.lbl_Description.text = [NSString stringWithFormat:@"Article No:. %@",[trx articleid]];
    cell.lbl_Price.text = [NSString stringWithFormat:@"€ %@",[article price]];
    cell.lbl_Quantity.text = [trx qty];

    
    Article_Image *articleImage = [article.images firstObject];
    if (articleImage) {
        NSString *fileName = [articleImage.imagePath lastPathComponent];
        NSString *filePath = [[[AppDataManager sharedAppDatamanager] imageDirPath] stringByAppendingPathComponent:fileName];
        cell.imgVw_Logo.image = [UIImage imageWithContentsOfFile:filePath];
        
    }

    
    __block CartTableViewCell *mycell = cell;
    
    [mycell cellEventCallback:^(NSInteger row, int callbackType) {
        
        TrxTransaction *trx = [self.cartArr objectAtIndex:row];

        NSString *sql = [NSString stringWithFormat:@"DELETE  from TrxTransaction WHERE TransactionId = '%@'",[trx TransactionId]];
        [[CXSSqliteHelper sharedSqliteHelper] runQuery:sql asObject:[TrxTransaction class]];

        
        sql = [NSString stringWithFormat:@"DELETE  from Trx_Rawmaterials WHERE TransactionId = '%@'",[trx TransactionId]];
        [[CXSSqliteHelper sharedSqliteHelper] runQuery:sql asObject:[Trx_Rawmaterials class]];
        
        [self refreshUI];
        
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 101;
}




#pragma mark - Actions
- (IBAction)chnageClient:(id)sender{

    __block ClientViewController *clientCtrl = [[self storyboard] instantiateViewControllerWithIdentifier:@"ClientViewController"];

    [[self navigationController] pushViewController:clientCtrl animated:YES];
   
    [clientCtrl callBackWhenClientSelected:^(NSString *clientid) {
        
        clientCtrl = nil;
    }];

}
- (IBAction)placeOrder:(id)sender{

    
    if ([[self cartArr] count] == 0) {
    
        alert = [[CustomeAlert alloc] init];
        [alert showAlertWithTitle:nil message:@"No item in the cart." cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
        }];

        return;
    }
    
    
    
    NSString *cleintName = [[[AppDataManager sharedAppDatamanager] selectedClient] clientid];
    
    
    
    
    if ([cleintName length] == 0) {
        
        
        alert = [[CustomeAlert alloc] init];
        [alert showAlertWithTitle:nil message:@"please select client." cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
        }];

    }else{
    
        
        
        [self showActivityIndicator:@"Placing order..."];
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        [[self cartArr] enumerateObjectsUsingBlock:^(TrxTransaction *trx, NSUInteger idx, BOOL *stop) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:trx.articleid forKey:@"articleid"];
            [dict setObject:trx.qty forKey:@"qty"];
            [dict setObject:trx.qty_unit forKey:@"qty_unit"];
            [dict setObject:trx.size forKey:@"size"];
            [dict setObject:([trx.remark length] ? trx.remark : @"") forKey:@"remark"];
            
            NSMutableArray *arrRawMaetrial = [[NSMutableArray alloc] init];
            [[trx rawmaterials] enumerateObjectsUsingBlock:^(Trx_Rawmaterials *rawmaterials, NSUInteger idx, BOOL *stop) {
                
                NSMutableDictionary *dictRaw = [[NSMutableDictionary alloc] init];
                [dictRaw setObject:rawmaterials.rawmaterialid forKey:@"rawmaterialid"];
                [dictRaw setObject:rawmaterials.rawmaterialgroupid forKey:@"rawmaterialgroupid"];
                [dictRaw setObject:rawmaterials.colorid forKey:@"colorid"];
                [dictRaw setObject:@"0" forKey:@"leatherpriority"];
                
                [arrRawMaetrial addObject:dictRaw];
            }];
            
            [dict setObject:arrRawMaetrial forKey:@"rawmaterials"];

            [arr addObject:dict];
            
        }];
        
        NSDictionary *mainDict1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  cleintName,@"clientid",
                                  arr,@"articles",
                                  nil];
        
        NSDictionary *mainDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  mainDict1, @"order",nil];
        
        
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mainDict
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        
        
        NSString*aStr;
        aStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

        Account *act = [[AppDataManager sharedAppDatamanager] account];
        
        
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH ,ADD_ORDER_API]];
        NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        NSString *postString = [NSString stringWithFormat:@"userid=%@&sessionid=%@&payload=%@",[[act user] userId],[act sessionId],aStr];
        NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:postData];

        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [self hideActivityIndicator];
                
            });
            
            if (connectionError) {
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    alert = [[CustomeAlert alloc] init];
                    [alert showAlertWithTitle:nil message:@"Error in connection." cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                    }];
                    
                });

            }else{
                
                NSError *jsonError = nil;
                id responsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
                
                if ([[responsedData objectForKey:@"errorcode"] isEqualToString:@"200"]) {
                    
                    [[CXSSqliteHelper sharedSqliteHelper] runQuery:@"DELETE FROM TrxTransaction" asObject:[TrxTransaction class]];
                    [[CXSSqliteHelper sharedSqliteHelper] runQuery:@"DELETE FROM Trx_Rawmaterials" asObject:[Trx_Rawmaterials class]];

                    dispatch_sync(dispatch_get_main_queue(), ^{
                            alert = [[CustomeAlert alloc] init];
                            [alert showAlertWithTitle:nil message:[responsedData objectForKey:@"message"] cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                                
                                [[self tabBarController] setSelectedIndex:0];
                                
                            }];
                        [self refreshUI];
                    });
                }else{
                
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        alert = [[CustomeAlert alloc] init];
                        [alert showAlertWithTitle:nil message:[responsedData objectForKey:@"message"] cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
                            
                            
                            
                        }];
                    });
 
                }
                
            }
            
            
        }];
        
        
        
        
        
    
    }
    
    
    

    

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
