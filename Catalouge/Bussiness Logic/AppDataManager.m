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

    
    _transaction.size = _transaction.article ? _transaction.article.sizefrom : @"40";
    _transaction.qty = @"1";
    _transaction.qty_unit = @"PAIR";
    _transaction.remark = @"";
    flag ? [_transaction setIsnew:@"1"] : [_transaction setIsnew:@"0"];
    [_transaction setIschange:@"0"];
    _transaction.rawmaterialsForLeathers = [[NSMutableArray alloc] init];
    _transaction.rawmaterialsForLinings = [[NSMutableArray alloc] init];

   
    
    //Socks Material
    if ([articleId length]) {
        
        NSString *socksQuery = [NSString stringWithFormat:@"SELECT * FROM Article_Rawmaterials WHERE articleid = '%@' AND rawmaterialgroupid = '12' AND (insraw = 'SOCK FULL' OR insraw = 'SOCK HALF' OR insraw = 'SOCK FULL - PRINTED LEATHER HOLE OPTIC' OR insraw = 'SOCK HALF - PRINTED LEATHER HOLE OPTIC' OR insraw = 'INSOLE COVER')",_transaction.articleid];
        NSArray *SocksArr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:socksQuery asObject:[ArticlesRawmaterials class]];
        if (flag) {
            
            if ([SocksArr count]) {
                
                ArticlesRawmaterials *articlesRawmaterial = [SocksArr firstObject];
                NSString *RawmaterialQuery = [NSString stringWithFormat:@"SELECT * FROM Rawmaterial_Master WHERE rawmaterialid = '%@'",articlesRawmaterial.rawmaterialid];
                NSArray *RawmaterialArr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:RawmaterialQuery asObject:[Rawmaterials class]];

                [RawmaterialArr count] ? _transaction.socksMaterialNew = [RawmaterialArr firstObject] : nil;

            }
            
        }else{
            [SocksArr count] ? _transaction.socksMaterial = [SocksArr firstObject] : nil;
            
        }
        
    }
    
    
    
    //Leather
    if ([articleId length] == 0) {
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

    if ([articleId length] == 0) {
        [[_transaction rawmaterialsForLinings] addObject:[[Rawmaterials alloc] init]];
    }else{
    
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM Article_Rawmaterials WHERE articleid = '%@' AND rawmaterialgroupid = '12' AND (insraw != 'SOCK FULL' AND insraw != 'SOCK HALF' AND insraw != 'SOCK FULL - PRINTED LEATHER HOLE OPTIC' AND insraw != 'SOCK HALF - PRINTED LEATHER HOLE OPTIC' AND insraw != 'INSOLE COVER')",articleId];
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

    
    
    
    if ([articleId length] && [_transaction.article.images count]) {
        //Copy and move Product Image to NewDev Dir
        Article_Image *image = [_transaction.article.images firstObject];
        NSString *oldFilePath = [[self imageDirPath] stringByAppendingPathComponent:[[image imagePath] lastPathComponent]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:oldFilePath isDirectory:NO]) {
            NSString *newFilePath = [[self fetchNewDevelopmentImageDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",[_transaction TransactionId]]];
            [[NSFileManager defaultManager] copyItemAtPath:oldFilePath toPath:newFilePath error:nil];
            
            
        }
    }
    
    return _transaction;
    

}

- (void)writeDataToImageFileName:(NSString*)filename withData:(NSData*)data{

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

        if ([rawmaterial.rawmaterialid length] && [rawmaterial.rawmaterialgroupid length]) {
            rawmaterial.insraw = [rawmaterial.insraw length] ? rawmaterial.insraw : @"";
            rawmaterial.colorid = [rawmaterial.colorid length] ? rawmaterial.colorid : @"";
            
            NSString *sqlQury = [NSString stringWithFormat:@"INSERT INTO Trx_Rawmaterials (TransactionId,rawmaterialid,rawmaterialgroupid,leatherpriority,colorid,insraw) VALUES ('%@','%@','%@','%@','%@','%@')",local.TransactionId,rawmaterial.rawmaterialid,rawmaterial.rawmaterialgroupid,@"0",rawmaterial.colorid,rawmaterial.insraw];
            [[CXSSqliteHelper sharedSqliteHelper] runQuery:sqlQury asObject:[Trx_Rawmaterials class]];

        }
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
    
        if ([[article soleid] length]) {
            
            if (([[article soleid] isEqualToString:[[[self transaction] Sole] rawmaterialid]])) {
                
                
            }else{
            
                isChange =  @"1";
                return isChange;

            }
            

            
        }else{
        
            if ([[self transaction] Sole] != nil) {
                
                isChange =  @"1";
                return isChange;

            }
            
        }
        
        
        
        if ([[article lastid] length]) {
            
            if (([[article lastid] isEqualToString:[[[self transaction] last] lastid]])) {
                
                
            }else{
                
                isChange =  @"1";
                return isChange;
                
            }
            
            
            
        }else{
            
            if ([[self transaction] last] != nil) {
                
                isChange =  @"1";
                return isChange;
                
            }
            
        }
        
        
        

        //SOLE MATERIAL
        NSString *qy = [NSString stringWithFormat:@"select rawmaterialid from Article_Rawmaterials  where  rawmaterialgroupid = '23' AND articleid = '%@'",[[self transaction] articleid]];
        NSArray *soleMaterialArt = [[CXSSqliteHelper sharedSqliteHelper] runQuery:qy asObject:[ArticlesRawmaterials class]];
        
        if ([soleMaterialArt count]) {
            
            Rawmaterials *sloeMaerialOriginal = [soleMaterialArt lastObject];

            if (([[sloeMaerialOriginal rawmaterialid] isEqualToString:[[[self transaction] SoleMaterial] rawmaterialid]])) {
                
                
            }else{
                
                isChange =  @"1";
                return isChange;
                
            }

            
            
        }else{
        
            if ([[self transaction] SoleMaterial] != nil) {
                
                isChange =  @"1";
                return isChange;
                
            }

        }
        
        
        
        //SOCKS MATERIAL

        NSString *socksQuery = [NSString stringWithFormat:@"SELECT * FROM Article_Rawmaterials WHERE articleid = '%@' AND rawmaterialgroupid = '12' AND (insraw = 'SOCK FULL' OR insraw = 'SOCK HALF' OR insraw = 'SOCK FULL - PRINTED LEATHER HOLE OPTIC' OR insraw = 'SOCK HALF - PRINTED LEATHER HOLE OPTIC' OR insraw = 'INSOLE COVER')",_transaction.articleid];
        NSArray *SocksArr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:socksQuery asObject:[ArticlesRawmaterials class]];
        
//        NSString *query = [NSString stringWithFormat:@"SELECT * FROM Article_Rawmaterials WHERE articleid = '%@' AND rawmaterialgroupid = '12' AND (insraw != 'SOCK FULL' AND insraw != 'SOCK HALF' AND insraw != 'SOCK FULL - PRINTED LEATHER HOLE OPTIC' AND insraw != 'SOCK HALF - PRINTED LEATHER HOLE OPTIC' AND insraw != 'INSOLE COVER')",articleId];

        if ([SocksArr count]) {
            
            ArticlesRawmaterials *sloeMaerialOriginal = [SocksArr lastObject];
            
            if (([[sloeMaerialOriginal insraw] isEqualToString:[[[self transaction] socksMaterial] insraw]])) {
                
                
            }else{
                
                isChange =  @"1";
                return isChange;
                
            }
            
            
            
        }else{
            
            if ([[self transaction] socksMaterial] != nil) {
                
                isChange =  @"1";
                return isChange;
                
            }
            
        }
        
        
        
        

        NSString *liningIds = [[[[self transaction] rawmaterialsForLinings] valueForKey:@"rawmaterialid"] componentsJoinedByString:@"-"];
        
        NSArray *liningArt = [[CXSSqliteHelper sharedSqliteHelper] runQuery:@"select rawmaterialid from Article_Rawmaterials  where  rawmaterialgroupid = '12' AND (insraw != 'SOCK FULL' AND insraw != 'SOCK HALF' AND insraw != 'SOCK FULL - PRINTED LEATHER HOLE OPTIC' AND insraw != 'SOCK HALF - PRINTED LEATHER HOLE OPTIC' AND insraw != 'INSOLE COVER')" asObject:[ArticlesRawmaterials class]];
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


- (UIBarButtonItem *)backBarButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 80, 30)];
    [button setTitle:title forState:UIControlStateNormal];
    // button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //[[button titleLabel] setFont:[UIFont fontWithName:@"MyriadPro-Regular" size:16]];
    [button.titleLabel setShadowColor:[UIColor clearColor]];
    [button.titleLabel setShadowOffset:CGSizeMake(0, 0)];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    UIImage *image = [[UIImage imageNamed:@"back_btn"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor clearColor]];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    return barButton;
}

@end
