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
#import "SearchViewController.h"
#import "ArticleMasterViewController.h"
#import "HomeViewController.h"
CustomeAlert *alert;

@interface CartViewController ()<UITextViewDelegate>
@property(nonatomic,strong) __block NSArray *cartArr;
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn_PlaceOrder.layer.cornerRadius = 5;
    self.btn_Refresh.layer.cornerRadius = 5;
    self.btn_Refresh.clipsToBounds = YES;
    [self setTitle:@"Cart"];
    
    UIView *vw = [[[NSBundle mainBundle] loadNibNamed:@"CartListFooter" owner:self options:nil] lastObject];
    [[self tbl_List_Cart] setTableFooterView:vw];
    [self initilizeFooterPayment];
    self.txt_ShippingTermsRemarks.delegate = self;
    self.lbl_Client_Name.adjustsFontSizeToFitWidth = YES;
    self.lbl_UserName.adjustsFontSizeToFitWidth = YES;
    [[[self btn_Refresh] titleLabel] setAdjustsFontSizeToFitWidth:YES];
    
    if ([[[self navigationController] viewControllers] count]>1) {
        [[self navigationItem] setLeftBarButtonItem:[[AppDataManager sharedAppDatamanager] backBarButtonWithTitle:@"  Back" target:self selector:@selector(backButtonAction:)]];
    }else{
        [[self navigationItem] setLeftBarButtonItem:nil];
    }
    

    
}

- (void)backButtonAction:(id)sender{

    
    [[self.navigationController viewControllers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
       
        if ([obj isKindOfClass:[HomeViewController class]]) {
            [[self navigationController] popToViewController:obj animated:YES];
            *stop = YES;
        }else if ([obj isKindOfClass:[ClientViewController class]]) {
            
                [[self navigationController] popToViewController:obj animated:YES];
                *stop = YES;
        }else if ([obj isKindOfClass:[ArticleMasterViewController class]]) {
            
            [[self navigationController] popToViewController:obj animated:YES];
            *stop = YES;
        }

        
    }];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [self refreshUI];
}

- (void)refreshUI{

    self.cartArr = [self fetchAllCartItems];
    [self.tbl_List_Cart reloadData];

    __block double totalEuro = 0.0f;
    __block double totalUSD = 0.0f;
    __block double totalGBP = 0.0f;

    __block NSInteger totalQty = 0;
    [[self cartArr] enumerateObjectsUsingBlock:^(TrxTransaction *transaction, NSUInteger idx, BOOL *stop) {
        
        totalEuro = totalEuro + [transaction.article.price doubleValue];
        totalUSD  = totalUSD + [transaction.article.price_usd doubleValue];
        totalGBP  = totalGBP + [transaction.article.price_gbp doubleValue];

        totalQty  = totalQty + [transaction.qty integerValue];
    }];
    
    [[self lbl_Price] setText:[NSString stringWithFormat:@"€%0.2f",totalEuro]];
    [[self lbl_Price_USD] setText:[NSString stringWithFormat:@"$%0.2f",totalUSD]];
    [[self lbl_Price_GBP] setText:[NSString stringWithFormat:@"£%0.2f",totalGBP]];

    [[self lbl_Total_Item] setText:[NSString stringWithFormat:@"Total\n%i Items",totalQty]];
    
    NSString *cleintName = [[[AppDataManager sharedAppDatamanager] selectedClient] company];
    
    [[self btn_Refresh] setTitle:[NSString stringWithFormat:@"Client - %@",[cleintName length] ? cleintName : @""] forState:UIControlStateNormal];

    
    Agents *agent = [[[AppDataManager sharedAppDatamanager] selectedClient] defaultAgent];
    
    [[self lbl_UserName] setText:[NSString stringWithFormat:@"Agent - %@",[[agent company] length] ? [agent company] : @""]];

    
    NSInteger order = [[self cartArr] count];
    
    UITabBarItem *cartTabbarItem = [[[[self tabBarController]tabBar] items] objectAtIndex:3];
    
    if (order !=0) {
        [cartTabbarItem setBadgeValue:[NSString stringWithFormat:@"%i",order]];
    }else{
        [cartTabbarItem setBadgeValue:nil];
    }
    
    
    
    
    
    //
    [self setPaymentTerms];
    
    
    
    
    
}

- (void)setPaymentTerms{

    [[self txt_PaymentTerms] setText:[[[AppDataManager sharedAppDatamanager] paymentTerms] paymentTerm]];
    [[self txt_PaymentTermsRemarks] setText:[[[AppDataManager sharedAppDatamanager] paymentTermRemakrs] paymentTermRemark]];
    [[self txt_ShippingTerms] setText:[[[AppDataManager sharedAppDatamanager] shippingTerms] shippingTerm]];
    [[self txt_ModeOfShipping] setText:[[[AppDataManager sharedAppDatamanager] modeofshipping] shippingMode]];
    [[self txt_ShippingTermsRemarks] setText:[[AppDataManager sharedAppDatamanager] shippingTermsRemarks]];

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
    
    static NSString *cellIndentifierForCartCell = @"cellIndentifierForCartCell";
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifierForCartCell];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CartTableViewCell" owner:self options:nil] firstObject];
        [cell initilizeCell];
    }
    
    cell.vw_qty.layer.cornerRadius = 5;
    cell.vw_qty.layer.borderColor = [UIColor redColor].CGColor;

    cell.row = indexPath.row;

    // Configure the cell...
    TrxTransaction *trx = [self.cartArr objectAtIndex:indexPath.row];
    Articles *article = [trx article];

    if ([[trx isnew] isEqualToString:@"1"]) {
        
        cell.lbl_Title.text = @"New Development";
        cell.lbl_Description.text = [NSString stringWithFormat:@"Article No:. %@",@""];
        [[cell lbl_Price] setText:[NSString stringWithFormat:@"€%@",@"0.0"]];
        [[cell lbl_Price_GBP] setText:[NSString stringWithFormat:@"£%@",@"0.0"]];
        [[cell lbl_Price_USD] setText:[NSString stringWithFormat:@"$%@",@"0.0"]];

    }else{
        cell.lbl_Title.text = [article articlename];
        cell.lbl_Description.text = [NSString stringWithFormat:@"Article No:. %@",[trx articleid]];
        [[cell lbl_Price] setText:[NSString stringWithFormat:@"€%@",[article price]]];
        [[cell lbl_Price_GBP] setText:[NSString stringWithFormat:@"£%@",[article price_gbp]]];
        [[cell lbl_Price_USD] setText:[NSString stringWithFormat:@"$%@",[article price_usd]]];

    
    }
    cell.lbl_Quantity.text = [trx qty];

    NSString *filePath = [[[AppDataManager sharedAppDatamanager] fetchNewDevelopmentImageDir] stringByAppendingFormat:@"/%@.jpg",[trx TransactionId]];

    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:NO]) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            UIImage *img = [UIImage imageWithContentsOfFile:filePath];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imgVw_Logo.image = img;
            });
        });

    }else{
    
        cell.imgVw_Logo.image = nil;

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

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//
//
//    return 400;
//
//}


#pragma mark - Actions
- (IBAction)chnageClient:(id)sender{

    __block ClientViewController *clientCtrl = [[self storyboard] instantiateViewControllerWithIdentifier:@"ClientViewController"];

    [[self navigationController] pushViewController:clientCtrl animated:YES];
   
    [clientCtrl callBackWhenClientSelected:^(NSString *clientid) {
        
        clientCtrl = nil;
    }];

}


#pragma Mark - Place Order
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
        [self placeOrderWithRawMaterials];
    }
}

- (void)placeOrderWithRawMaterials{
    
    [self showActivityIndicator:@"Placing order..."];

    
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    [[self cartArr] enumerateObjectsUsingBlock:^(TrxTransaction *trx, NSUInteger idx, BOOL *stop) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:trx.articleid forKey:@"articleid"];
        [dict setObject:trx.articlename forKey:@"articlename"];
        [dict setObject:trx.ischange forKey:@"ischange"];
        [dict setObject:trx.isnew forKey:@"isnew"];
        [dict setObject:trx.lastid forKey:@"lastid"];
        [dict setObject:trx.qty forKey:@"qty"];
        [dict setObject:trx.qty_unit forKey:@"qty_unit"];
        [dict setObject:([trx.remark length] ? trx.remark : @"") forKey:@"remark"];
        [dict setObject:trx.size forKey:@"size"];
        [dict setObject:trx.soleid forKey:@"soleid"];
        [dict setObject:[trx.TransactionId stringByAppendingPathExtension:@"jpg"] forKey:@"image_name"];

        NSMutableArray *arrRawMaetrial = [self getRawMaterialsArr:trx];
        
        [dict setObject:arrRawMaetrial forKey:@"rawmaterials"];
        
        [arr addObject:dict];
        
    }];
    
    NSString *payloadString = [self requestStringFromRawMaterialsArr:arr];
    [self postOrder:payloadString];
    
}

- (NSMutableArray*)getRawMaterialsArr:(TrxTransaction*)localTransaction{

    
    NSMutableArray *arrRawMaetrial = [[NSMutableArray alloc] init];
    [[localTransaction trx_Rawmaterials] enumerateObjectsUsingBlock:^(Trx_Rawmaterials *rawmaterials, NSUInteger idx, BOOL *stop) {
        
        if ([rawmaterials.rawmaterialid length]) {
            NSMutableDictionary *dictRaw = [[NSMutableDictionary alloc] init];
            [dictRaw setObject:rawmaterials.rawmaterialid forKey:@"rawmaterialid"];
            [dictRaw setObject:rawmaterials.rawmaterialgroupid forKey:@"rawmaterialgroupid"];
            [dictRaw setObject:rawmaterials.colorid forKey:@"colorid"];
            [dictRaw setObject:@"0" forKey:@"leatherpriority"];
            [dictRaw setObject:[[AppDataManager sharedAppDatamanager] validateString:rawmaterials.insraw] forKey:@"insraw"];

            [arrRawMaetrial addObject:dictRaw];
        }
    }];
    

    return arrRawMaetrial;
}

- (NSString*)requestStringFromRawMaterialsArr:(NSMutableArray*)rawMaterialArr{

    
    AppDataManager *dataManager = [AppDataManager sharedAppDatamanager];
    NSString *cleintName = [[[AppDataManager sharedAppDatamanager] selectedClient] clientid];
    NSString *AgentId = [[[[AppDataManager sharedAppDatamanager] selectedClient] defaultAgentCode] length] ? [[[AppDataManager sharedAppDatamanager] selectedClient] defaultAgentCode] : @"";

    NSDictionary *mainDict1 = [NSDictionary dictionaryWithObjectsAndKeys:
                               cleintName,@"clientid",
                               AgentId,@"AgentId",

                               [dataManager validateString:[[dataManager paymentTerms] paymentTerm]],@"paymentterms",
                               
                               [dataManager validateString:[[dataManager paymentTermRemakrs] paymentTermRemark]],@"paymenttermsremarks",
                               
                               [dataManager validateString:[[dataManager shippingTerms] shippingTerm]],@"shippingterms",
                               
                               [dataManager validateString:[dataManager shippingTermsRemarks]],@"shippingtermsremarks",
                               
                               [dataManager validateString:[[dataManager modeofshipping] shippingMode]],@"modeshippingterms",
                               
                               rawMaterialArr,@"articles",
                               
                               nil];
    
    NSDictionary *mainDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              mainDict1, @"order",nil];
    
    
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mainDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    
    NSString*unescaped;
    unescaped = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
 
    
    NSString *escapedString = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (__bridge_retained CFStringRef)unescaped,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8);
    
    
    return escapedString;


}



- (void)postOrder:(NSString*)payloadString{

    
    Account *act = [[AppDataManager sharedAppDatamanager] account];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH ,ADD_ORDER_API]];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:180];

    NSString *postString = [NSString stringWithFormat:@"userid=%@&sessionid=%@&payload=%@",[[act user] userId],[act sessionId],payloadString];
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
                
                //Upload Article Images
                [self uploadArticleImages:responsedData];
                
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

- (void)uploadArticleImages:(NSDictionary*)responsedData{
    
    
    [[CXSSqliteHelper sharedSqliteHelper] runQuery:@"DELETE FROM TrxTransaction" asObject:[TrxTransaction class]];
    [[CXSSqliteHelper sharedSqliteHelper] runQuery:@"DELETE FROM Trx_Rawmaterials" asObject:[Trx_Rawmaterials class]];
    
    
    NSString *clientName = [[[AppDataManager sharedAppDatamanager] selectedClient] company];
    NSString *orderid = [[AppDataManager sharedAppDatamanager] validateString:[responsedData objectForKey:@"orderid"]];
    NSString *order_number = [[AppDataManager sharedAppDatamanager] validateString:[responsedData objectForKey:@"order_number"]];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *orderDate = [formatter stringFromDate:[NSDate date]];
    formatter = nil;
    
    NSString *insertOrderQuery = [NSString stringWithFormat:@"Insert Into Orders (orderNo,orderID,company,orderDate) Values ('%@','%@','%@','%@')",order_number,orderid,clientName,orderDate];
    [[CXSSqliteHelper sharedSqliteHelper] runQuery:insertOrderQuery asObject:[Orders class]];

    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showActivityIndicator:@"Uploading Image..."];
    });

    
    [[self cartArr] enumerateObjectsUsingBlock:^(TrxTransaction *trx, NSUInteger idx, BOOL *stop) {
        
        
        NSString *filePath = [[[AppDataManager sharedAppDatamanager] DevelopmentImageDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",[trx TransactionId]]];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            
            UIImage *image = [UIImage imageWithContentsOfFile:filePath];
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);

            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH , UPLOAD_Image_API]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            
            
            [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
            [request setHTTPShouldHandleCookies:NO];
            [request setTimeoutInterval:180];
            [request setHTTPMethod:@"POST"];
            
            NSString *boundary = @"unique-consistent-string";
            
            // set Content-Type in HTTP header
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
            [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            // post body
            NSMutableData *body = [NSMutableData data];
            
            
            // add params (all params are strings)
            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"userid"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [[[[AppDataManager sharedAppDatamanager] account] user] userId]] dataUsingEncoding:NSUTF8StringEncoding]];

            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"sessionid"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [[[AppDataManager sharedAppDatamanager] account] sessionId]] dataUsingEncoding:NSUTF8StringEncoding]];
            
            

            
            // add image data
            if (imageData) {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@; filename=%@.jpg\r\n", @"product_photo",[trx TransactionId]] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:imageData];
                [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
            [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            // setting the body of the post to the reqeust
            [request setHTTPBody:body];
            
            // set the content-length
            NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            
            NSURLResponse *response ;
            NSError *error ;

            NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            NSString * responseString = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
            NSLog(@"\n☀☀☀☀<response>: %@\n☀☀☀☀\n",responseString);
            
        }
        
    }];

    
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        
        [self hideActivityIndicator];
        alert = [[CustomeAlert alloc] init];
        [alert showAlertWithTitle:nil message:@"Order placed successfully." cancelButtonTitle:@"OK" otherButtonTitles:nil withButtonHandler:^(NSInteger buttonIndex) {
            [self refreshUI];

            //SET NIL
            [[AppDataManager sharedAppDatamanager] setPaymentTerms:nil];
            [[AppDataManager sharedAppDatamanager] setPaymentTermRemakrs:nil];
            [[AppDataManager sharedAppDatamanager] setShippingTerms:nil];
            [[AppDataManager sharedAppDatamanager] setModeofshipping:nil];
            [[AppDataManager sharedAppDatamanager] setShippingTermsRemarks:nil];
            [[AppDataManager sharedAppDatamanager] setSelectedClient:nil];
            [[AppDataManager sharedAppDatamanager] setSelectedClient:nil];

            
            if ([[self tabBarController] selectedIndex] == 0) {
                
                [[self.navigationController viewControllers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    
                    
                    if ([obj isKindOfClass:[HomeViewController class]]) {
                        [[self navigationController] popToViewController:obj animated:YES];
                        *stop = YES;
                    }else if ([obj isKindOfClass:[ClientViewController class]]) {
                        
                        [[self navigationController] popToViewController:obj animated:YES];
                        *stop = YES;
                    }else if ([obj isKindOfClass:[ArticleMasterViewController class]]) {
                        
                        [[self navigationController] popToViewController:obj animated:YES];
                        *stop = YES;
                    }
                    
                    
                }];

                
            }else{
                [[self tabBarController] setSelectedIndex:0];

            }
            
        }];
        
    });

    

    
    
    
    
}







#pragma mark - Payment Terms
- (void)initilizeFooterPayment{

    CGColorRef fuck = [UIColor blackColor].CGColor;
    self.vw_PaymentTerms.layer.cornerRadius = 1;
    self.vw_PaymentTerms.layer.borderWidth = 1;
    self.vw_PaymentTerms.layer.borderColor = fuck;
    
    
    self.vw_PaymentTermsRemarks.layer.cornerRadius = 1;
    self.vw_PaymentTermsRemarks.layer.borderWidth = 1;
    self.vw_PaymentTermsRemarks.layer.borderColor = fuck;

    
    self.vw_ShippingTerms.layer.cornerRadius = 1;
    self.vw_ShippingTerms.layer.borderWidth = 1;
    self.vw_ShippingTerms.layer.borderColor = fuck;


    self.vw_ShippingTermsRemarks.layer.cornerRadius = 1;
    self.vw_ShippingTermsRemarks.layer.borderWidth = 1;
    self.vw_ShippingTermsRemarks.layer.borderColor = fuck;

    
    
    self.vw_ModeOfShipping.layer.cornerRadius = 1;
    self.vw_ModeOfShipping.layer.borderWidth = 1;
    self.vw_ModeOfShipping.layer.borderColor = fuck;
    
    
    

}
- (IBAction)fotterBtnPressed:(id)sender{

    
    NSInteger tag = [sender tag];
    
    switch (tag) {
        case PAYMENT_TERMS_SELECTION:{
        
            
            SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
            search.tag = PAYMENT_TERMS_SELECTION;
            search.arr_Common_List = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:@"SELECT * FROM PaymentTerms" asObject:[PaymentTerms class]] mutableCopy];
            [search registerOptionSelectionCallback:^(id selectedData) {
                
                [[AppDataManager sharedAppDatamanager] setPaymentTerms:selectedData];
                [[self txt_PaymentTerms] setText:[selectedData paymentTerm]];
                
            }];
            
            [[self navigationController] pushViewController:search animated:YES];

            
            
        }
            break;
            
        case PAYMENT_TERMS_REMARKS_SELECTION:{
            
            SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
            search.tag = PAYMENT_TERMS_REMARKS_SELECTION;
            search.arr_Common_List = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:[NSString stringWithFormat:@"SELECT * FROM PaymentTermRemarks WHERE '%@'",[[[AppDataManager sharedAppDatamanager] paymentTerms] paymentTermId]] asObject:[PaymentTermRemarks class]] mutableCopy];
            [search registerOptionSelectionCallback:^(id selectedData) {
                
                [[AppDataManager sharedAppDatamanager] setPaymentTermRemakrs:selectedData];
                [[self txt_PaymentTermsRemarks] setText:[selectedData paymentTermRemark]];

                
            }];
            
            [[self navigationController] pushViewController:search animated:YES];

            
        }
            break;

        case SHIPPING_TERMS_SELECTION:{
            
            
            SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
            search.tag = SHIPPING_TERMS_SELECTION;
            search.arr_Common_List = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:@"SELECT * FROM ShippingTerms" asObject:[ShippingTerms class]] mutableCopy];
            [search registerOptionSelectionCallback:^(id selectedData) {
                
                [[AppDataManager sharedAppDatamanager] setShippingTerms:selectedData];
                [[self txt_ShippingTerms] setText:[selectedData shippingTerm]];
                
                
            }];
            
            [[self navigationController] pushViewController:search animated:YES];

        }
            break;

        case MODE_OF_SHIPPING_SELECTION:{
            
            
            SearchViewController *search = [[self storyboard] instantiateViewControllerWithIdentifier:@"SearchViewController"];
            search.tag = MODE_OF_SHIPPING_SELECTION;
            search.arr_Common_List = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:@"SELECT * FROM Modeofshipping" asObject:[Modeofshipping class]] mutableCopy];
            [search registerOptionSelectionCallback:^(id selectedData) {
                
                [[AppDataManager sharedAppDatamanager] setModeofshipping:selectedData];
                [[self txt_ModeOfShipping] setText:[selectedData shippingMode]];
                
                
            }];
            
            [[self navigationController] pushViewController:search animated:YES];

        }
            break;

        default:
            break;
    }
    
    
    
}

#pragma mark - UITextView delegates

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
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    textView.inputAccessoryView = self.toolbar;
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    return YES;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [[AppDataManager sharedAppDatamanager] setShippingTermsRemarks:textView.text];
    
}

#pragma mark - Toolbar
- (void)DoneInput{
    
    [[self txt_ShippingTermsRemarks] resignFirstResponder];
}


#pragma mark - Activity
- (void)showActivityIndicator:(NSString*)msg{
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:msg];
    
    
}
- (void)hideActivityIndicator{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}




@end
