//
//  BottomTableViewCell.m
//  Catalouge
//
//  Created by Shameem Ahamad on 8/8/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "BottomTableViewCell.h"
#import "CartViewController.h"
@implementation BottomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initilizeCell{
    
    self.vw_Qty.layer.cornerRadius = 1;
    self.vw_Qty.layer.borderWidth = 1;
    self.vw_Qty.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    self.vw_Size.layer.cornerRadius = 1;
    self.vw_Size.layer.borderWidth = 1;
    self.vw_Size.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    
    self.vw_Pair.layer.cornerRadius = 1;
    self.vw_Pair.layer.borderWidth = 1;
    self.vw_Pair.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    self.vw_Remarks.layer.cornerRadius = 1;
    self.vw_Remarks.layer.borderWidth = 1;
    self.vw_Remarks.layer.borderColor = [UIColor grayColor].CGColor;

    self.addTOcartbtn.layer.cornerRadius = 20;
    self.addTOcartbtn.layer.borderWidth = 1;
    self.addTOcartbtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.txt_Remarks.delegate = self;
    
}


- (IBAction)addToCart:(id)sender{

    
    
    @try {
       
        __block TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
        
       
        BOOL isValidForAddToCart = NO;
        
        if ([local Sole]) {
            
            isValidForAddToCart = YES;
        }
        
        if ([local SoleMaterial]) {
            
            isValidForAddToCart = YES;
        }

        
        if ([local socksMaterial]) {
            
            isValidForAddToCart = YES;
        }

        
        if ([local socksMaterialNew]) {
            
            isValidForAddToCart = YES;
        }

        
        
        
        
        if ([[local rawmaterialsForLeathers] count]){
        
            Rawmaterials *raw = [[local rawmaterialsForLeathers] firstObject];
            if ([[raw rawmaterialid] length]) {
                isValidForAddToCart = YES;
            }
            
        }
        
        if ([[local rawmaterialsForLinings] count]){
            
            Rawmaterials *raw = [[local rawmaterialsForLinings] firstObject];
            if ([[raw rawmaterialid] length]) {
                isValidForAddToCart = YES;
            }
            
        }
        
        
        
        if (!isValidForAddToCart) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Virola" message:@"Please specify at least 1 Raw material." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            alert = nil;
            return;
        }
        
        local.articleid = [local.articleid length] ? local.articleid : @"";
        
        
        local.qty = [local.qty length] ? local.qty : @"";
        local.size = [local.size length] ? local.size : @"";
        local.qty_unit = [local.qty_unit length] ? local.qty_unit : @"";
        local.remark = [local.remark length] ? local.remark : @"";
        if (![local last])
            local.lastid = @"";
        else
        local.lastid = [local.last.lastid length] ? local.last.lastid : @"";

        if (![local Sole])
            local.soleid = @"";
        else
        local.soleid = [local.Sole.rawmaterialid length] ? local.Sole.rawmaterialid : @"";

        
        NSString *isChange = [[AppDataManager sharedAppDatamanager] getIsChange];
        
        
        NSString *sqlQury = [NSString stringWithFormat:@"INSERT INTO TrxTransaction (TransactionId,articleid,qty,qty_unit,size,remark,articlename,ischange,isnew,lastid,soleid) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",local.TransactionId,local.articleid,local.qty,local.qty_unit,local.size,local.remark,[[AppDataManager sharedAppDatamanager] validateString:[[local article] articlename]],[[AppDataManager sharedAppDatamanager] validateString:isChange],[[AppDataManager sharedAppDatamanager] validateString:[local isnew]],[[AppDataManager sharedAppDatamanager] validateString:[[local last] lastid]],[[AppDataManager sharedAppDatamanager] validateString:[[local Sole] rawmaterialid]]];
        
        [[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQury asObject:[TrxTransaction class]];
        
        
        
        
        if ([[[[AppDataManager sharedAppDatamanager] transaction] isnew] isEqualToString:@"1"]) {
            
            Rawmaterials *oldRaw = [local socksMaterialNew];
            [oldRaw setInsraw:@"SOCKS"];
            if ([oldRaw.rawmaterialgroupid length] && [oldRaw.rawmaterialid length]) {
                [[AppDataManager sharedAppDatamanager] insertIntoTrx_Rawmaterials:oldRaw withTrx:local];
            }

        }else{

            ArticlesRawmaterials *oldRaw = [[[AppDataManager sharedAppDatamanager] transaction] socksMaterial];
            Rawmaterials *rawMaterials = [[Rawmaterials alloc] init];
            [rawMaterials setRawmaterialgroupid:oldRaw.rawmaterialgroupid];
            [rawMaterials setAbbrname:@""];
            [rawMaterials setColorid:oldRaw.colorid];
            [rawMaterials setName:@""];
            [rawMaterials setRawmaterialid:oldRaw.rawmaterialid];
            [rawMaterials setInsraw:oldRaw.insraw];

            if ([oldRaw.rawmaterialgroupid length] && [oldRaw.rawmaterialid length]) {
               
                [[AppDataManager sharedAppDatamanager] insertIntoTrx_Rawmaterials:rawMaterials withTrx:local];

            }

            
        }
        
        
        [[AppDataManager sharedAppDatamanager] insertIntoTrx_Rawmaterials:[local Sole] withTrx:local];

        [[AppDataManager sharedAppDatamanager] insertIntoTrx_Rawmaterials:[local SoleMaterial] withTrx:local];
        
        [[local rawmaterialsForLeathers] enumerateObjectsUsingBlock:^(Rawmaterials *obj, NSUInteger idx, BOOL *stop) {
            
            [[AppDataManager sharedAppDatamanager] insertIntoTrx_Rawmaterials:obj withTrx:local];
        }];
        
        [[local rawmaterialsForLinings] enumerateObjectsUsingBlock:^(Rawmaterials *obj, NSUInteger idx, BOOL *stop) {
            
            [[AppDataManager sharedAppDatamanager] insertIntoTrx_Rawmaterials:obj withTrx:local];
        }];

    }
    @catch (NSException *exception) {
        
    }
    
    
    _addToCartCallBack ? _addToCartCallBack() : @"";
}

- (void)registerCallbackForAddToCart:(AddToCartCallBack)addToCartCallBack{

    
    _addToCartCallBack = addToCartCallBack;
    
}






- (IBAction)dropDwonSelected:(id)sender{
    
    
    __weak BottomTableViewCell *myself = self;
    _qtyPairSizeCallback ? _qtyPairSizeCallback(myself,[sender tag]) : @"";
    
    
}
- (void)registerCallbackForQtyPairSize:(QtyPairSizeCallback)callback{
    
    _qtyPairSizeCallback = callback;
}

#pragma mark - Toolbar
- (void)DoneInput{
    
    [[self txt_Remarks] resignFirstResponder];
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
    TrxTransaction *local = [[AppDataManager sharedAppDatamanager] transaction];
    local.remark = textView.text;
}

@end
