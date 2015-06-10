//
//  TrxTransaction.m
//  Catalouge
//
//  Created by Shameem Ahamad on 6/1/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "TrxTransaction.h"

@implementation TrxTransaction

- (Articles*)article{

    if (!_article) {
        NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Article_Master WHERE articleid = '%@'",self.articleid];
        _article = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQuery asObject:[Articles class]] firstObject];
    }
    return _article;
}

/*
 
 select name from Rawmaterial_Master where rawmaterialgroupid = '1' group by name 
 
  select rawmaterialid from Rawmaterial_Master where rawmaterialgroupid = '1' and name = 'ADRIA 415 C' and colorid = '311'
 
 
 */

- (NSArray*)rawmaterials{

    NSArray *arr = nil;
    if (!_rawmaterials) {
        NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Trx_Rawmaterials WHERE TransactionId = '%@'",self.TransactionId];
        arr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQuery asObject:[Trx_Rawmaterials class]];
    }
    return arr;

}

@end
