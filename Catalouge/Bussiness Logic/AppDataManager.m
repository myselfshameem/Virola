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
- (TrxTransaction*)newTransactionWithArticleId:(NSString*)articleId withNewDevelopment:(BOOL)flag{


    _transaction = nil;
    
    
    _transaction = [[TrxTransaction alloc] init];
    [_transaction setTransactionId:[self getTransactionKey]];
    _transaction.articleid = articleId;

    
    _transaction.size = _transaction.article.sizefrom;
    _transaction.qty = @"1";
    _transaction.qty_unit = @"PAIR";
    _transaction.remark = @"";
    flag ? [_transaction setIsnew:@"1"] : [_transaction setIsnew:@"0"];
    [_transaction setIschange:@"0"];
    _transaction.rawmaterialsForLeathers = [[NSMutableArray alloc] init];
    _transaction.rawmaterialsForLinings = [[NSMutableArray alloc] init];

    //Leather
    if (flag) {
        [[_transaction rawmaterialsForLeathers] addObject:[[Rawmaterials alloc] init]];
    }else{
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM Article_Rawmaterials WHERE articleid = '%@' AND rawmaterialgroupid = '1'",articleId];
        NSArray *leatherArr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]];
        
        [leatherArr enumerateObjectsUsingBlock:^(ArticlesRawmaterials *obj, NSUInteger idx, BOOL *stop) {
            
            NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialid = '%@' AND rawmaterialgroupid = '%@'",obj.rawmaterialid,obj.rawmaterialgroupid];
            
            Rawmaterials *rawmaterial = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]] firstObject];
            [[_transaction rawmaterialsForLeathers] addObject:rawmaterial];
        }];
        
        
    }



    
    //Leather Lining

    if (flag) {
        [[_transaction rawmaterialsForLinings] addObject:[[Rawmaterials alloc] init]];
    }else{
    
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM Article_Rawmaterials WHERE articleid = '%@' AND rawmaterialgroupid = '12'",articleId];
        NSArray *liningArr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]];
        
        [liningArr enumerateObjectsUsingBlock:^(ArticlesRawmaterials *obj, NSUInteger idx, BOOL *stop) {
            
            NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialid = '%@' AND rawmaterialgroupid = '%@'",obj.rawmaterialid,obj.rawmaterialgroupid];
            
            Rawmaterials *rawmaterial = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]] firstObject];
            [[_transaction rawmaterialsForLinings] addObject:rawmaterial];

        }];
    }

    
    
    
   
    //Sole
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialid = '%@' ",_transaction.article.soleid];
    NSArray *soleArr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Rawmaterials class]];
    [soleArr count] ?  [_transaction setSole:[soleArr lastObject]] : nil;


    
    //last
    query = [NSString stringWithFormat:@"SELECT * FROM Lasts_Master WHERE lastid = '%@' ",_transaction.article.lastid];
    NSArray *lastsArr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Lasts class]];
    [lastsArr count] ?  [_transaction setLast:[lastsArr lastObject]] : nil;

    
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

    NSError *error = nil;
    NSString *path = [[self imageDirPath] stringByAppendingPathComponent:filename];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    if ([[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil]) {
        
    };
    

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

- (NSString*)DevelopmentImageDir{

    if (!_DevelopmentImageDir) {
        
        _DevelopmentImageDir = [self fetchNewDevelopmentImageDir];
    }
    return _DevelopmentImageDir;
}
- (NSString*)fetchNewDevelopmentImageDir{

    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[@"Documents/" stringByAppendingString:@"NewDevelopmentImages"]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}


#pragma mark - Save Logged in user
- (void)saveLoggedInUserDetails:(Account*)account {
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver;
    archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:account forKey:@"Logged_In_User"];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"Logged_In_User"];
    BOOL isDirectory = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory] == NO || isDirectory == NO) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error] == YES ? NSLog(@"Directoty Created") : NSLog(@"Error Occured %@", error);
        
    }
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.arch", @"Logged_In_User"]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    [archiver finishEncoding];
    NSError *error = nil;
    if (!self.account) {
        return;
    }
    if (![data writeToFile:path options:NSDataWritingAtomic error:&error]) {
        // Error in Saving File
        NSLog(@"Error in Saving %@", error);
    }
}
- (void)deleteLoggedInUserDetails {
    

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"Logged_In_User"];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.arch", @"Logged_In_User"]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
}

- (Account*)lastLoggedInUser{
    
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@.arch", @"Logged_In_User", @"Logged_In_User"]];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data) {
        // Error & Exit
        return nil;
    }
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData: data];
    Account *account = [unarchiver decodeObjectForKey:@"Logged_In_User"];
    [unarchiver finishDecoding];
    return account;
}


- (NSMutableArray*)quantityOption{

    if (!_quantityOption) {
        _quantityOption = [[NSMutableArray alloc] init];
        for (int i = 1; i<100; i++) {
            [_quantityOption addObject:[NSString stringWithFormat:@"%i",i]];
        }
        
        [_quantityOption addObject:@"500"];
        [_quantityOption addObject:@"1000"];
        
        
    }

    return _quantityOption;
}

- (NSString*)validateString:(NSString*)value{

    if (value == nil || [value length] == 0) {
        
        return @"";
    }
    
    return value;
    
}


- (void)insertIntoTrx_Rawmaterials:(Rawmaterials*)rawmaterial withTrx:(TrxTransaction*)local{
    
    
    if (rawmaterial) {
        
        
        rawmaterial.rawmaterialid = [rawmaterial.rawmaterialid length] ? rawmaterial.rawmaterialid : @"";
        rawmaterial.rawmaterialgroupid = [rawmaterial.rawmaterialgroupid length] ? rawmaterial.rawmaterialgroupid : @"";
        NSString *sqlQury = [NSString stringWithFormat:@"INSERT INTO Trx_Rawmaterials (TransactionId,rawmaterialid,rawmaterialgroupid,leatherpriority,colorid) VALUES ('%@','%@','%@','%@','%@')",local.TransactionId,rawmaterial.rawmaterialid,rawmaterial.rawmaterialgroupid,@"0",rawmaterial.colorid];
        [[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQury asObject:[Trx_Rawmaterials class]];
    }
    
    
}


#pragma mark - Size
- (NSMutableArray*)getSizeArr{

    NSInteger sizeFrom = 40;
    NSInteger sizeTo = 46;
    
    NSMutableArray *add = [[NSMutableArray alloc] init];
    if ([[[self transaction] isnew] isEqualToString:@"0"]) {
        sizeFrom  = [[[[self transaction] article] sizefrom] integerValue];
        sizeTo  = [[[[self transaction] article] sizeto] integerValue];
    }
    
    for (int i = sizeFrom; i <= sizeTo; i++) {
        [add addObject:[NSString stringWithFormat:@"%i",i]];
    }

    return add;
}

- (void)addRawMaterialLeather:(Rawmaterials*)raw{


    [[[self transaction] rawmaterialsForLeathers] addObject:raw];
}

- (void)addRawMaterialLining:(Rawmaterials*)raw{
    
    
    [[[self transaction] rawmaterialsForLinings] addObject:raw];
}

- (NSString*)getIsChange{

    NSString *isChange = @"0";
    if ([[[self transaction] isnew] isEqualToString:@"1"])
        isChange =  @"0";
    else{
        //TODO::
        NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM Article_Master WHERE articleid = '%@'",self.transaction.articleid];
        Articles *article = [[[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQuery asObject:[Articles class]] firstObject];
    
        if (![[article soleid] isEqualToString:[[[self transaction] Sole] rawmaterialid]]) {
            
            isChange =  @"1";
            return isChange;

        }
        
        
        if (![[article lastid] isEqualToString:[[[self transaction] last] lastid]]) {
            
            isChange =  @"1";
            return isChange;
        }


        NSString *qy = [NSString stringWithFormat:@"select rawmaterialid from Article_Rawmaterials  where  rawmaterialgroupid = '23' AND articleid = '%@'",[[self transaction] articleid]];
        NSArray *soleMaterialArt = [[CXSSqliteHelper sharedSqliteHelper] runQuery:qy asObject:[ArticlesRawmaterials class]];
        
        Rawmaterials *sloeMaerialOriginal = [soleMaterialArt lastObject];
        
        if (![[sloeMaerialOriginal rawmaterialid] isEqualToString:[[[self transaction] SoleMaterial] rawmaterialid]]) {
            
            isChange =  @"1";
            return isChange;

        }
        

        NSString *liningIds = [[[[self transaction] rawmaterialsForLinings] valueForKey:@"rawmaterialid"] componentsJoinedByString:@"-"];
        
        NSArray *liningArt = [[CXSSqliteHelper sharedSqliteHelper] runQuery:@"select rawmaterialid from Article_Rawmaterials  where  rawmaterialgroupid = '12'" asObject:[ArticlesRawmaterials class]];
        NSString *liningIdOriginal = [[liningArt valueForKey:@"rawmaterialid"] componentsJoinedByString:@"-"];

        if (![liningIds isEqualToString:liningIdOriginal]) {
            
            isChange =  @"1";
            return isChange;

        }

        
        
        NSString *leatherIds = [[[[self transaction] rawmaterialsForLeathers] valueForKey:@"rawmaterialid"] componentsJoinedByString:@"-"];
        
        NSArray *leatherArt = [[CXSSqliteHelper sharedSqliteHelper] runQuery:@"select rawmaterialid from Article_Rawmaterials  where  rawmaterialgroupid = '1'" asObject:[ArticlesRawmaterials class]];
        NSString *leatherIdOriginal = [[leatherArt valueForKey:@"rawmaterialid"] componentsJoinedByString:@"-"];
        
        if (![leatherIds isEqualToString:leatherIdOriginal]) {
            
            isChange =  @"1";
            return isChange;

        }

    }

    
    return isChange;
}

@end
