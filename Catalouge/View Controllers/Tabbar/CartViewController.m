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
CustomeAlert *alert;

@interface CartViewController ()<UITextViewDelegate>
@property(nonatomic,strong) __block NSArray *cartArr;
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn_PlaceOrder.layer.cornerRadius = 12;
    [self setTitle:@"Cart"];
    
    UIView *vw = [[[NSBundle mainBundle] loadNibNamed:@"CartListFooter" owner:self options:nil] lastObject];
    [[self tbl_List_Cart] setTableFooterView:vw];
    [self initilizeFooterPayment];
    self.txt_ShippingTermsRemarks.delegate = self;
    self.lbl_Client_Name.adjustsFontSizeToFitWidth = YES;
    self.lbl_UserName.adjustsFontSizeToFitWidth = YES;
    
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
    
    NSString *cleintName = [[[AppDataManager sharedAppDatamanager] selectedClient] company];
    
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
        [cell initilizeCell];
    }
    
    cell.vw_qty.layer.cornerRadius = 5;
    cell.vw_qty.layer.borderColor = [UIColor redColor].CGColor;

    cell.row = indexPath.row;

    // Configure the cell...
    TrxTransaction *trx = [self.cartArr objectAtIndex:indexPath.row];
    Articles *article = [trx article];

    if ([[trx isnew] isEqualToString:@"1"]) {
        
        cell.lbl_Title.text = @"";
        cell.lbl_Description.text = @"";
        cell.lbl_Price.text = @"";

    }else{
        cell.lbl_Title.text = [article articlename];
        cell.lbl_Description.text = [NSString stringWithFormat:@"Article No:. %@",[trx articleid]];
        cell.lbl_Price.text = [NSString stringWithFormat:@"€ %@",[article price]];
    }
    cell.lbl_Quantity.text = [trx qty];

    
    if ([[trx isnew] isEqualToString:@"1"]) {
        NSString *filePath = [[[AppDataManager sharedAppDatamanager] fetchNewDevelopmentImageDir] stringByAppendingFormat:@"/%@.png",[trx TransactionId]];
        cell.imgVw_Logo.image = [UIImage imageWithContentsOfFile:filePath];
    }else{
        Article_Image *articleImage = [article.images firstObject];
        if (articleImage) {
            NSString *fileName = [articleImage.imagePath lastPathComponent];
            NSString *filePath = [[[AppDataManager sharedAppDatamanager] imageDirPath] stringByAppendingPathComponent:fileName];
            cell.imgVw_Logo.image = [UIImage imageWithContentsOfFile:filePath];
            
        }

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
            [dict setObject:trx.articlename forKey:@"articlename"];
            [dict setObject:trx.ischange forKey:@"ischange"];
            [dict setObject:trx.isnew forKey:@"isnew"];
            [dict setObject:trx.lastid forKey:@"lastid"];
            [dict setObject:trx.qty forKey:@"qty"];
            [dict setObject:trx.qty_unit forKey:@"qty_unit"];
            [dict setObject:([trx.remark length] ? trx.remark : @"") forKey:@"remark"];
            [dict setObject:trx.size forKey:@"size"];
            [dict setObject:trx.soleid forKey:@"soleid"];

            NSMutableArray *arrRawMaetrial = [[NSMutableArray alloc] init];
            [[trx trx_Rawmaterials] enumerateObjectsUsingBlock:^(Trx_Rawmaterials *rawmaterials, NSUInteger idx, BOOL *stop) {
                
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
        
        
//        deshippingterms
//        "sadfasdf"
//        modeshippingtermsremarks
//        "sadfasdf"
//        paymentterms
//        "sadfasdf"
//        paymenttermsremarks
//        "sadfasdf"
//        remark
//        "sadfasdf"
//        shippingterms
//        "sadfasdf"
//        shippingtermsremarks
//        "sadfasdf"
        
        AppDataManager *dataManager = [AppDataManager sharedAppDatamanager];
        
        NSDictionary *mainDict1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                  cleintName,@"clientid",
                                
                                   [dataManager validateString:[[dataManager paymentTerms] paymentTerm]],@"paymentterms",
                                   
                                   [dataManager validateString:[[dataManager paymentTermRemakrs] paymentTermRemark]],@"paymenttermsremarks",
                                   
                                   [dataManager validateString:[[dataManager shippingTerms] shippingTerm]],@"shippingterms",
                                   
                                   [dataManager validateString:[dataManager shippingTermsRemarks]],@"shippingtermsremarks",
                                   
                                   [dataManager validateString:[[dataManager modeofshipping] shippingMode]],@"modeshippingterms",

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

                    NSString *insertOrderQuery = [NSString stringWithFormat:@"Insert Into MyOrder (order_number,orderid) Values ('%@','%@')",[[AppDataManager sharedAppDatamanager] validateString:[responsedData objectForKey:@"order_number"]],[[AppDataManager sharedAppDatamanager] validateString:[responsedData objectForKey:@"orderid"]]];
                    
                    [[CXSSqliteHelper sharedSqliteHelper] runQuery:insertOrderQuery asObject:[MyOrder class]];

                    
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
@end
