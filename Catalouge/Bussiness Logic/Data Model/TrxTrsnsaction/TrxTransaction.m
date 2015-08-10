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

- (NSArray*)trx_Rawmaterials{

    NSArray *arr = nil;
    if (!_trx_Rawmaterials) {
        NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Trx_Rawmaterials WHERE TransactionId = '%@'",self.TransactionId];
        arr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQuery asObject:[Trx_Rawmaterials class]];
    }
    return arr;

}
//- (Lasts*)last{
//
//    NSArray *arr = nil;
//
//    if (!_last) {
//        NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Lasts_Master WHERE lastid = '%@'",self.articleid];
//        arr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQuery asObject:[Lasts class]];
//        [arr count] ? (_last = [arr lastObject]) : nil;
//    }
//    
//    return _last;
//}

- (NSMutableArray*)rawmaterialsForLeathers{

    NSArray *arr = nil;

    if (!_rawmaterialsForLeathers) {
        
        NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Trx_Rawmaterials WHERE TransactionId = '%@' AND rawmaterialgroupid = '1' ",self.TransactionId];
        arr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQuery asObject:[Trx_Rawmaterials class]];
        
        [arr count] ? _rawmaterialsForLeathers = [[NSMutableArray alloc] initWithArray:arr] : nil;
    }

    return _rawmaterialsForLeathers;

}



- (NSMutableArray*)rawmaterialsForLinings{
    
    NSArray *arr = nil;
    
    if (!_rawmaterialsForLinings) {
        
        NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Trx_Rawmaterials WHERE TransactionId = '%@' AND rawmaterialgroupid = '12' ",self.TransactionId];
        arr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQuery asObject:[Trx_Rawmaterials class]];
        
        [arr count] ? _rawmaterialsForLinings = [[NSMutableArray alloc] initWithArray:arr] : nil;
    }
    
    return _rawmaterialsForLinings;
    
}
@end
