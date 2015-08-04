//
//  SearchViewController.m
//  Catalouge
//
//  Created by Shameem Ahamad on 6/14/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//
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
    self.arr_Common_List = self.arr_ClientList;

    // Do any additional setup after loading the view.
}

- (void)refreshArticleList:(NSString*)searchString{
    
    
    NSString *strPredicate = nil;
    NSPredicate *predicate = nil;

    
    
    if ([searchString length]) {
        switch ([self tag]) {
            
        case SOLE_TXT_TAG:{
            strPredicate = [NSString stringWithFormat:@"name contains[c]'%@'",searchString];
            predicate = [NSPredicate predicateWithFormat:strPredicate];
        }
            break;
        case SOLE_TXT_COLOR:{
            strPredicate = [NSString stringWithFormat:@"self.colors.colorname contains[c]'%@'",searchString];
            predicate = [NSPredicate predicateWithFormat:strPredicate];
        }
            break;
            
            
        case LEATHER1_TXT_TAG:
        case LEATHER2_TXT_TAG:
        case LEATHER3_TXT_TAG:
        case LEATHER4_TXT_TAG:
        case LEATHER5_TXT_TAG:{
            
            strPredicate = [NSString stringWithFormat:@"name contains[c]'%@'",searchString];
            predicate = [NSPredicate predicateWithFormat:strPredicate];
        }
            break;
            
        case LEATHER_COLOR1_TXT_TAG:
        case LEATHER_COLOR2_TXT_TAG:
        case LEATHER_COLOR3_TXT_TAG:
        case LEATHER_COLOR4_TXT_TAG:
        case LEATHER_COLOR5_TXT_TAG:{
            strPredicate = [NSString stringWithFormat:@"self.colors.colorname contains[c]'%@'",searchString];
            predicate = [NSPredicate predicateWithFormat:strPredicate];
        }
            break;
            
            
            
        case LINING1_TXT_TAG:
        case LINING2_TXT_TAG:
        case LINING3_TXT_TAG:
        case LINING4_TXT_TAG:
        case LINING5_TXT_TAG:{
            
            strPredicate = [NSString stringWithFormat:@"name contains[c]'%@'",searchString];
            predicate = [NSPredicate predicateWithFormat:strPredicate];
        }
            break;
            
        case LINING_COLOR1_TXT_TAG:
        case LINING_COLOR2_TXT_TAG:
        case LINING_COLOR3_TXT_TAG:
        case LINING_COLOR4_TXT_TAG:
        case LINING_COLOR5_TXT_TAG:{
            
            strPredicate = [NSString stringWithFormat:@"self.colors.colorname contains[c]'%@'",searchString];
            predicate = [NSPredicate predicateWithFormat:strPredicate];
        }
            break;
            
            
        default:{
            
            strPredicate = [NSString stringWithFormat:@"name contains[c]'%@'",searchString];
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
    
    return [self.arr_Common_List count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    ClientTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ClientTableViewCell" owner:self options:nil] firstObject];
    }

    
    cell.lblClient_Name.text = [self getCellTitleWithIndexpath:indexPath];
    
    
    
    return cell;
}
- (NSString *)getCellTitleWithIndexpath:(NSIndexPath*)indexPath{

    NSString *text = @"";
    Rawmaterials *raw = [self.arr_Common_List objectAtIndex:indexPath.row];
    
    switch ([self tag]) {
            
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Rawmaterials *rawmaterial = [[self arr_Common_List] objectAtIndex:indexPath.row];
    
    switch ([self tag]) {
            
            
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
    
    [[self navigationController] popViewControllerAnimated:YES];
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
            
            self.common_TxtField.text = local.Leather1.colors.colorname;
            
            break;
            
        case LEATHER2_TXT_TAG:
            
            if ([colorsArray count])
                [local setLeather2:[colorsArray firstObject]];
            
            self.common_TxtField.text = local.Leather2.colors.colorname;
            break;
        case LEATHER3_TXT_TAG:
            
            if ([colorsArray count])
                [local setLeather3:[colorsArray firstObject]];
            
            self.common_TxtField.text = local.Leather3.colors.colorname;
            
            break;
        case LEATHER4_TXT_TAG:
            if ([colorsArray count])
                [local setLeather4:[colorsArray firstObject]];
            
            self.common_TxtField.text = local.Leather4.colors.colorname;
            break;
        case LEATHER5_TXT_TAG:
            if ([colorsArray count])
                [local setLeather5:[colorsArray firstObject]];
            
            self.common_TxtField.text = local.Leather5.colors.colorname;
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
            
            self.common_TxtField.text = local.Lining1.colors.colorname;
            
            break;
            
        case LINING2_TXT_TAG:
            
            if ([colorsArray count])
                [local setLining2:[colorsArray firstObject]];
            
            self.common_TxtField.text = local.Lining2.colors.colorname;
            break;
        case LINING3_TXT_TAG:
            
            if ([colorsArray count])
                [local setLining3:[colorsArray firstObject]];
            
            self.common_TxtField.text = local.Lining3.colors.colorname;
            
            break;
        case LINING4_TXT_TAG:
            if ([colorsArray count])
                [local setLining4:[colorsArray firstObject]];
            
            self.common_TxtField.text = local.Lining4.colors.colorname;
            break;
        case LINING5_TXT_TAG:
            if ([colorsArray count])
                [local setLining5:[colorsArray firstObject]];
            
            self.common_TxtField.text = local.Lining5.colors.colorname;
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
        self.common_TxtField.text = local.Sole.colors.colorname;
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
@end
