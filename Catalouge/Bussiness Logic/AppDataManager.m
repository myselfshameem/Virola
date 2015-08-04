//
//  AppDataManager.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/21/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "AppDataManager.h"
#import "TrxTransaction.h"
static AppDataManager *appdataManager;
@implementation AppDataManager
+(AppDataManager*)sharedAppDatamanager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (!appdataManager) {
            appdataManager = [[AppDataManager alloc] init];
        }
    });
    
    return appdataManager;
}

- (NSString *)getTransactionKey {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocal = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    dateFormatter.locale = usLocal;
    dateFormatter.calendar = gregorian;
    [dateFormatter setDateFormat:@"yyMMddHHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    NSString *unique = [NSString stringWithFormat:@"%@",dateString];
    return unique = [self GetCurrentTimeStamp];
}

- (NSString *)GetCurrentTimeStamp{
    
    long long milliseconds = (long long)([[NSDate date] timeIntervalSince1970] * 1000.0);
    NSString *strTimeStamp = [NSString stringWithFormat:@"%lld",milliseconds];
    return strTimeStamp;
    
}
- (TrxTransaction*)newTransactionWithArticleId:(NSString*)articleId{


    _transaction = nil;
    _transaction = [[TrxTransaction alloc] init];
    _transaction.articleid = articleId;
    _transaction.size = _transaction.article.sizefrom;
    _transaction.qty = @"1";
    _transaction.qty_unit = @"PAIR";
    [_transaction setTransactionId:[self getTransactionKey]];
    
    //Leather
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Article_Rawmaterials WHERE articleid = '%@' AND rawmaterialgroupid = '1'",articleId];
    NSArray *leatherArr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]];
    [leatherArr enumerateObjectsUsingBlock:^(ArticlesRawmaterials *obj, NSUInteger idx, BOOL *stop) {
        
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialid = '%@' AND rawmaterialgroupid = '%@'",obj.rawmaterialid,obj.rawmaterialgroupid];
        
        Rawmaterials *rawmaterial = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]] firstObject];
        
        switch (idx) {
            case 0:
                [_transaction setLeather1:rawmaterial];
                break;
            case 1:
                [_transaction setLeather2:rawmaterial];
                break;
            case 2:
                [_transaction setLeather3:rawmaterial];
                break;
            case 3:
                [_transaction setLeather4:rawmaterial];
                break;
            case 4:
                [_transaction setLeather5:rawmaterial];
                break;
                
            default:
                break;
        }

        
    }];
    
    ;
    
    
    //Leather Lining
    query = [NSString stringWithFormat:@"SELECT * FROM Article_Rawmaterials WHERE articleid = '%@' AND rawmaterialgroupid = '12'",articleId];
    NSArray *liningArr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]];
    [liningArr enumerateObjectsUsingBlock:^(ArticlesRawmaterials *obj, NSUInteger idx, BOOL *stop) {
        
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialid = '%@' AND rawmaterialgroupid = '%@'",obj.rawmaterialid,obj.rawmaterialgroupid];
        
        Rawmaterials *rawmaterial = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]] firstObject];
        
        switch (idx) {
            case 0:
                [_transaction setLining1:rawmaterial];
                break;
            case 1:
                [_transaction setLining2:rawmaterial];
                break;
            case 2:
                [_transaction setLining3:rawmaterial];
                break;
            case 3:
                [_transaction setLining4:rawmaterial];
                break;
            case 4:
                [_transaction setLining5:rawmaterial];
                break;
                
            default:
                break;
        }
        
        
    }];
    

    
    
    
   
    //Sole
    query = [NSString stringWithFormat:@"SELECT * FROM Article_Rawmaterials WHERE articleid = '%@' AND rawmaterialgroupid = '10'",articleId];
    NSArray *soleArr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[ArticlesRawmaterials class]];
    [soleArr enumerateObjectsUsingBlock:^(ArticlesRawmaterials *obj, NSUInteger idx, BOOL *stop) {
        
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialid = '%@' AND rawmaterialgroupid = '%@'",obj.rawmaterialid,obj.rawmaterialgroupid];
        
        Rawmaterials *rawmaterial = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]] firstObject];
        
        switch (idx) {
            case 0:
                [_transaction setSole:rawmaterial];
                break;
            default:
                break;
        }
        *stop = YES;
        
    }];

    
    //Sole Material
    query = [NSString stringWithFormat:@"SELECT * FROM Article_Rawmaterials WHERE articleid = '%@' AND rawmaterialgroupid = '23'",articleId];
    NSArray *soleMaterialArr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[ArticlesRawmaterials class]];
    [soleMaterialArr enumerateObjectsUsingBlock:^(ArticlesRawmaterials *obj, NSUInteger idx, BOOL *stop) {
        
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialid = '%@' AND rawmaterialgroupid = '%@'",obj.rawmaterialid,obj.rawmaterialgroupid];
        
        Rawmaterials *rawmaterial = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]] firstObject];
        
        switch (idx) {
            case 0:
                [_transaction setSoleMaterial:rawmaterial];
                break;
            default:
                break;
        }
        *stop = YES;
        
    }];

    
    return _transaction;
    

}

- (void)writeDataToImageFileName:(NSString*)filename withData:(NSData*)data{

    NSString *path = [[self imageDirPath] stringByAppendingPathComponent:filename];
    [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
    

}
- (NSString*)imageDirPath{

    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[@"Documents/" stringByAppendingString:@"Images"]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    

    return path;

}

- (void)createImageDir{

}
@end
