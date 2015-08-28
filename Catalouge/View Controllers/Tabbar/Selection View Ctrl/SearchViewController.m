//
//  SearchViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 6/14/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//



#import "SearchViewController.h"
#import "ClientTableViewCell.h"
@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view_SearchBox.layer.cornerRadius = 20;
    CGColorRef borderColor = [UIColor grayColor].CGColor;
    self.view_SearchBox.layer.borderColor = borderColor;
    self.view_SearchBox.layer.borderWidth = 1;
    
    
    self.txtField_Search_Clients.text = self.strSearchString;
    self.arr_ClientList = self.arr_Common_List;

    // Do any additional setup after loading the view.
}

- (void)refreshArticleList:(NSString*)searchString{
    
    
    
    
//#define INVALID_USER 801
//#define  1999
//#define  1998
//#define  1997
//#define  1996
//#define  1995
//#define  1994
//#define  1993
//#define  1992
//#define QTY_SELECTION 1991
//#define PAIR_SELECTION 1990
//#define SIZE_SELECTION 1989
//#define  1988
//#define  1987
//#define  1986
//#define MODE_OF_SHIPPING_SELECTION 1985
    
    NSString *strPredicate = nil;
    NSPredicate *predicate = nil;

    
    if ([searchString length]) {
        switch ([self tag]) {
                
                
            case PAYMENT_TERMS_SELECTION:{
                strPredicate = [NSString stringWithFormat:@"paymentTerm contains[c]'%@'",searchString];
                predicate = [NSPredicate predicateWithFormat:strPredicate];
            }
                break;

                
            case PAYMENT_TERMS_REMARKS_SELECTION:{
                strPredicate = [NSString stringWithFormat:@"paymentTermRemark contains[c]'%@'",searchString];
                predicate = [NSPredicate predicateWithFormat:strPredicate];
            }
                break;

            case SHIPPING_TERMS_SELECTION:{
                strPredicate = [NSString stringWithFormat:@"shippingTerm contains[c]'%@'",searchString];
                predicate = [NSPredicate predicateWithFormat:strPredicate];
            }
                break;

            case MODE_OF_SHIPPING_SELECTION:{
                strPredicate = [NSString stringWithFormat:@"shippingMode contains[c]'%@'",searchString];
                predicate = [NSPredicate predicateWithFormat:strPredicate];
            }
                break;

        case LAST_SELECTION:{
            strPredicate = [NSString stringWithFormat:@"lastname contains[c]'%@'",searchString];
            predicate = [NSPredicate predicateWithFormat:strPredicate];
        }
            break;
                
        case LINING_SELECTION:
        case LEATHER_SELECTION:
        case SOLE_SELECTION:
        case SOLE_MATERIAL_SELECTION:{
            strPredicate = [NSString stringWithFormat:@"name contains[c]'%@'",searchString];
            predicate = [NSPredicate predicateWithFormat:strPredicate];
        }
            break;
            
            
            
            case SOLE_COLOR_SELECTION:
            case LEATHER_COLOR_SELECTION:
            case LINING_COLOR_SELECTION:{
                
                strPredicate = [NSString stringWithFormat:@"self.colors.colorname contains[c]'%@'",searchString];
                predicate = [NSPredicate predicateWithFormat:strPredicate];
                
            }
                break;
         
            
        default:{
            
            strPredicate = [NSString stringWithFormat:@"self contains[c]'%@'",searchString];
            predicate = [NSPredicate predicateWithFormat:strPredicate];
            
        }
            break;
    }
        
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
    
    return [self.arr_Common_List count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    ClientTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ClientTableViewCell" owner:self options:nil] firstObject];
        cell.backgroundColor = [UIColor clearColor];
    }

    
    if ([self tag] == LAST_SELECTION) {
        Lasts *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        cell.lblClient_Name.text = [lasts lastname];
    }else if ([self tag] == SOLE_SELECTION){
    
    
        Rawmaterials *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        cell.lblClient_Name.text = [lasts name];

    }else if ([self tag] == SOLE_COLOR_SELECTION){
    
        Rawmaterials *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        cell.lblClient_Name.text = [[lasts colors] colorname];

    }else if ([self tag] == SOLE_MATERIAL_SELECTION){
        
        Rawmaterials *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        cell.lblClient_Name.text = [[lasts colors] colorname];
        
    }else if ([self tag] == LEATHER_SELECTION){
        
        Rawmaterials *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        cell.lblClient_Name.text = [lasts name];
        
    }else if ([self tag] == LEATHER_COLOR_SELECTION){
        
        Rawmaterials *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        cell.lblClient_Name.text = [[lasts colors] colorname];
        
    }else if ([self tag] == QTY_SELECTION){
    
        NSString *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        cell.lblClient_Name.text = lasts;

    }
    
    else if ([self tag] == PAIR_SELECTION){
    
        NSString *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        cell.lblClient_Name.text = lasts;

    }else if ([self tag] == SIZE_SELECTION){
    
        NSString *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        cell.lblClient_Name.text = lasts;

    }else if ([self tag] == PAYMENT_TERMS_SELECTION){
        
        PaymentTerms *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        cell.lblClient_Name.text = [lasts paymentTerm];

    }else if ([self tag] == PAYMENT_TERMS_REMARKS_SELECTION){
        
        PaymentTermRemarks *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        cell.lblClient_Name.text = [lasts paymentTermRemark];
        
    }else if ([self tag] == SHIPPING_TERMS_SELECTION){
        
        ShippingTerms *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        cell.lblClient_Name.text = [lasts shippingTerm];
        
    }else if ([self tag] == MODE_OF_SHIPPING_SELECTION){
        
        Modeofshipping *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        cell.lblClient_Name.text = [lasts shippingMode];
        
    }
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
    if ([self tag] == LAST_SELECTION) {
        Lasts *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        _optionSelectedCallBack ? _optionSelectedCallBack(lasts) : nil;
    }else if ([self tag] == SOLE_SELECTION){
    
        Rawmaterials *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        _optionSelectedCallBack ? _optionSelectedCallBack(lasts) : nil;

    }else if ([self tag] == SOLE_COLOR_SELECTION){
        
        Rawmaterials *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        _optionSelectedCallBack ? _optionSelectedCallBack(lasts) : nil;
        
    }else if ([self tag] == SOLE_MATERIAL_SELECTION){
        
        Rawmaterials *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        _optionSelectedCallBack ? _optionSelectedCallBack(lasts) : nil;
        
    }else if ([self tag] == LEATHER_SELECTION){
        
        Rawmaterials *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        _optionSelectedCallBack ? _optionSelectedCallBack(lasts) : nil;
        
    }else if ([self tag] == LEATHER_COLOR_SELECTION){
        
        Rawmaterials *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        _optionSelectedCallBack ? _optionSelectedCallBack(lasts) : nil;
        
    }else if ([self tag] == QTY_SELECTION){
        
        NSString *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        _optionSelectedCallBack ? _optionSelectedCallBack(lasts) : nil;
        
    }
    
    else if ([self tag] == PAIR_SELECTION){
        
        NSString *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        _optionSelectedCallBack ? _optionSelectedCallBack(lasts) : nil;
        
    }else if ([self tag] == SIZE_SELECTION){
        
        NSString *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        _optionSelectedCallBack ? _optionSelectedCallBack(lasts) : nil;
        
    }else if ([self tag] == PAYMENT_TERMS_SELECTION){
        
        PaymentTerms *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        _optionSelectedCallBack ? _optionSelectedCallBack(lasts) : nil;
        
    }else if ([self tag] == PAYMENT_TERMS_REMARKS_SELECTION){
        
        PaymentTermRemarks *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        _optionSelectedCallBack ? _optionSelectedCallBack(lasts) : nil;
        
    }else if ([self tag] == SHIPPING_TERMS_SELECTION){
        
        ShippingTerms *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        _optionSelectedCallBack ? _optionSelectedCallBack(lasts) : nil;
        
    }else if ([self tag] == MODE_OF_SHIPPING_SELECTION){
        
        Modeofshipping *lasts = [self.arr_Common_List objectAtIndex:indexPath.row];
        _optionSelectedCallBack ? _optionSelectedCallBack(lasts) : nil;
        
    }
    

    
    
    [[self navigationController] popViewControllerAnimated:YES];

    return;
    
    
    
}


- (void)registerOptionSelectionCallback:(OptionSelectedCallBack)optionSelectedCallBack{

    _optionSelectedCallBack = optionSelectedCallBack;
}


@end
