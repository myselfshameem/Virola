//
//  CXSSqliteHelper.m
//  iVendPOS
//
//  Created by Shameem Ahamad on 7/24/14.
//  Copyright (c) 2014 cxsmac2. All rights reserved.
//

#import "CXSSqliteHelper.h"
#import <objc/runtime.h>

#if !defined(SQLITE_DATE)
#define SQLITE_DATE 6 // Defines the integer value for the table column datatype
#endif
static CXSSqliteHelper *sqliteHelper = nil;
@implementation CXSSqliteHelper
+ (CXSSqliteHelper*)sharedSqliteHelper{
    
    if (!sqliteHelper) {
        sqliteHelper = [[CXSSqliteHelper alloc] init];
    }
    
    return sqliteHelper;
}



- (NSString*)dataSource{
    
    
    NSString *database = [NSString stringWithFormat:@"Catalouge.sqlite"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentDBPath = [NSHomeDirectory() stringByAppendingPathComponent:[@"Documents/" stringByAppendingString:@"Database"]];
    if (![fileManager fileExistsAtPath: documentDBPath]) {
        [fileManager createDirectoryAtPath:documentDBPath withIntermediateDirectories:NO attributes:[NSDictionary dictionary] error:nil];
    }
    
    NSString *workingPath = [documentDBPath stringByAppendingPathComponent:database];
    if (![fileManager fileExistsAtPath: workingPath]) {
        NSString *resourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: database];
        if ([fileManager fileExistsAtPath: resourcePath]) {
            NSError *error = nil;
            if (![fileManager copyItemAtPath: resourcePath toPath: workingPath error: &error]) {
                @throw [NSException exceptionWithName: @"DBException" reason: [NSString stringWithFormat: @"Failed to copy data source in resource directory to working directory. '%@'", [error localizedDescription]] userInfo: nil];
            }
        }
    }

    _dataSource = [documentDBPath stringByAppendingPathComponent:[NSString stringWithFormat:@"Catalouge.sqlite"]];
    return _dataSource;
}

- (void)open{
	@synchronized(self) {
		if (!_isConnected) {
            NSString *dataSource = [self dataSource];
            sqlite3_config(SQLITE_CONFIG_SERIALIZED);
			if (sqlite3_open([dataSource UTF8String], &_database) != SQLITE_OK) {
				sqlite3_close(_database);
				@throw [NSException exceptionWithName: @"DBException" reason: [NSString stringWithFormat: @"Failed to open database connection. '%p'", sqlite3_errmsg16(_database)] userInfo: nil];
			}
			_isConnected = YES;
		}
	}
}
- (void)close{
	@synchronized(self) {

        if (_isConnected) {
			if (sqlite3_close(_database) != SQLITE_OK) {
				@throw [NSException exceptionWithName: @"DBException" reason: [NSString stringWithFormat: @"Failed to close database connection. '%p'", sqlite3_errmsg16(_database)] userInfo: nil];
			}
			_isConnected = NO;
            _dataSource = nil; 
		}
	}
}



- (NSArray *)runQuery: (NSString *)sql asObject: (Class)model{
#if SQLITER ==1 
    NSLog(@"\n<Query>: <%@>\n",sql);

#endif
    
    NSLog(@"\n<Query>: <%@>\n",sql);

    [self open];
	sqlite3_stmt *statement = NULL;
	if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, NULL) != SQLITE_OK) {
		sqlite3_finalize(statement);
        NSLog(@"%s",sqlite3_errmsg(_database));
		        @try {
            [NSException exceptionWithName: @"DBException" reason: [NSString stringWithFormat: @"Failed to perform query with SQL statement. '%p'", sqlite3_errmsg16(_database)] userInfo: nil];
        }
        @catch (NSException *exception) {
#if SQLITER ==1
            
            NSLog(@"Sqlite Error : %@",exception);
#endif
        }

	}
    
	NSMutableArray *records = [[NSMutableArray alloc] init];
	while (sqlite3_step(statement) == SQLITE_ROW) {
		id record = [[model alloc] init];
        int columnCount = sqlite3_column_count(statement);
        
        for (int index = 0; index < columnCount; index++) {
            NSString *columnName = [NSString stringWithUTF8String: sqlite3_column_name(statement, index)];
            int columnType = [[NSNumber numberWithInt: [self columnTypeAtIndex: index inStatement: statement]] intValue];
            id value = [self columnValueAtIndex: index withColumnType:columnType  inStatement: statement];
            if([self propertyExistForClass:model withPropertyName:columnName]){
                if (value != nil) {
                    [record setValue: ([value isKindOfClass:[NSString class]]) ? [CXSSqliteHelper valueNotNull:value]: value forKey: columnName];
                }
            }
            

        }
		[records addObject: record];
	}
    
	sqlite3_finalize(statement);
    statement = NULL;
    return records;
}




- (int)rowCount: (NSString *)sql{
#if SQLITER ==1
    NSLog(@"\n<Query>: <%@>\n\n",sql);
#endif   
    [self open];
    int count = 0;
	sqlite3_stmt *statement = NULL;
	if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, NULL) != SQLITE_OK) {
		sqlite3_finalize(statement);
#if SQLITER ==1 
        NSLog(@"%s",sqlite3_errmsg(_database));

#endif
		        @try {
            [NSException exceptionWithName: @"DBException" reason: [NSString stringWithFormat: @"Failed to perform query with SQL statement. '%p'", sqlite3_errmsg16(_database)] userInfo: nil];
        }
        @catch (NSException *exception) {
#if SQLITER ==1 
            NSLog(@"Sqlite Error : %@",exception);

#endif
        }

	}
    
	while (sqlite3_step(statement) == SQLITE_ROW) {
        count = sqlite3_column_int(statement, 0);
	}
	sqlite3_finalize(statement);
    statement = NULL;
    return count;
}


- (int)columnTypeAtIndex:(int)column inStatement:(sqlite3_stmt *)statement {
	// Declared data types - http://www.sqlite.org/datatype3.html (section 2.2 table column 1)
	const NSSet *blobTypes = [NSSet setWithObjects: @"BINARY", @"BLOB", @"VARBINARY", nil];
	const NSSet *charTypes = [NSSet setWithObjects: @"CHAR", @"CHARACTER", @"CLOB", @"NATIONAL VARYING CHARACTER", @"NATIVE CHARACTER", @"NCHAR", @"NVARCHAR", @"TEXT", @"VARCHAR", @"VARIANT", @"VARYING CHARACTER", nil];
	const NSSet *dateTypes = [NSSet setWithObjects: @"DATE", @"DATETIME", @"TIME", @"TIMESTAMP", nil];
	const NSSet *intTypes  = [NSSet setWithObjects: @"BIGINT", @"BIT", @"BOOL", @"BOOLEAN", @"INT", @"INT2", @"INT8", @"INTEGER", @"MEDIUMINT", @"SMALLINT", @"TINYINT", nil];
	const NSSet *nullTypes = [NSSet setWithObjects: @"NULL", nil];
	const NSSet *realTypes = [NSSet setWithObjects: @"DECIMAL", @"DOUBLE", @"DOUBLE PRECISION", @"FLOAT", @"NUMERIC", @"REAL", nil];
	// Determine data type of the column - http://www.sqlite.org/c3ref/c_blob.html
	const char *columnType = (const char *)sqlite3_column_decltype(statement, column);
	if (columnType != NULL) {
		NSString *dataType = [[NSString stringWithUTF8String: columnType] uppercaseString];
		NSRange end = [dataType rangeOfString: @"("];
		if (end.location != NSNotFound) {
			dataType = [dataType substringWithRange: NSMakeRange(0, end.location)];
		}
		if ([dataType hasPrefix: @"UNSIGNED"]) {
			dataType = [dataType substringWithRange: NSMakeRange(0, 8)];
		}
		dataType = [dataType stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
		if ([intTypes containsObject: dataType]) {
			return SQLITE_INTEGER;
		}
		if ([realTypes containsObject: dataType]) {
			return SQLITE_FLOAT;
		}
		if ([charTypes containsObject: dataType]) {
			return SQLITE_TEXT;
		}
		if ([blobTypes containsObject: dataType]) {
			return SQLITE_BLOB;
		}
		if ([nullTypes containsObject: dataType]) {
			return SQLITE_NULL;
		}
		if ([dateTypes containsObject: dataType]) {
			return SQLITE_DATE;
		}
		return SQLITE_TEXT;
	}
	return sqlite3_column_type(statement, column);
}
- (id)columnValueAtIndex:(int)column withColumnType:(int)columnType inStatement:(sqlite3_stmt *)statement{
	if (columnType == SQLITE_INTEGER) {
		return [NSNumber numberWithLongLong: sqlite3_column_int64(statement, column)];
	}
	if (columnType == SQLITE_FLOAT) {
		return [NSDecimalNumber numberWithDouble:sqlite3_column_double(statement, column)];
	}
	if (columnType == SQLITE_TEXT) {
		const char *text = (const char *)sqlite3_column_text(statement, column);
		if (text != NULL) {
			return [NSString stringWithUTF8String: text];
		}
	}
	if (columnType == SQLITE_BLOB) {
		return [NSData dataWithBytes: sqlite3_column_blob(statement, column) length: sqlite3_column_bytes(statement, column)];
	}
	if (columnType == SQLITE_DATE) {
		const char *text = (const char *)sqlite3_column_text(statement, column);
		if (text != NULL) {
			NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
			[formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
			NSDate *date = [formatter dateFromString: [NSString stringWithUTF8String: text]];
            formatter = nil;
			return date;
		}
	}
	return [NSString string];
}



- (BOOL)propertyExistForClass:(Class)model withPropertyName:(NSString*)propertyName{
    
    return  class_getProperty(model, [propertyName UTF8String]) ? YES : NO;
    
}

+ (NSString *)valueNotNull:(id)value {
    
    if([value isEqualToString:@"(null)"] || value == NULL || [value isEqualToString:@"nul"]) {
        return [NSString stringWithFormat:@""];
    }
    return value;
}
+ (NSString *) prepareValue: (id)value {
    if ((value == nil) || [value isKindOfClass: [NSNull class]]) {
        return @"NULL";
    }
    else if ([value isKindOfClass: [NSArray class]]) {
        NSMutableString *buffer = [NSMutableString string];
        [buffer appendString: @"("];
        for (int i = 0; i < [value count]; i++) {
            if (i > 0) {
                [buffer appendString: @", "];
            }
            [buffer appendString: [self prepareValue: [value objectAtIndex: i]]];
        }
        [buffer appendString: @")"];
        return buffer;
    }
    else if ([value isKindOfClass: [NSNumber class]]) {
        return [NSString stringWithFormat: @"%@", value];
    }
    else if ([value isKindOfClass: [NSString class]]) {
        char *escapedValue = sqlite3_mprintf("'%q'", [(NSString *)value UTF8String]);
        NSString *string = [NSString stringWithUTF8String: (const char *)escapedValue];
        sqlite3_free(escapedValue);
        return string;
    }
    else if ([value isKindOfClass: [NSData class]]) {
        NSData *data = (NSData *)value;
        int length = [data length];
        NSMutableString *buffer = [NSMutableString string];
        [buffer appendString: @"x'"];
        const unsigned char *dataBuffer = [data bytes];
        for (int i = 0; i < length; i++) {
            [buffer appendFormat: @"%02lx", (unsigned long)dataBuffer[i]];
        }
        [buffer appendString: @"'"];
        return buffer;
    }
    else if ([value isKindOfClass: [NSDate class]]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        NSString *date = [NSString stringWithFormat: @"'%@'", [formatter stringFromDate: (NSDate *)value]];
        return date;
    }
    
    //TODO::
    /*else if ([value isKindOfClass: [ZIMSqlExpression class]]) {
     return [(ZIMSqlExpression *)value expression];
     }
     else if ([value isKindOfClass: [ZIMSqlSelectStatement class]]) {
     NSString *statement = [(ZIMSqlSelectStatement *)value statement];
     statement = [statement substringWithRange: NSMakeRange(0, [statement length] - 1)];
     statement = [NSString stringWithFormat: @"(%@)", statement];
     return statement;
     }*/
    else {
        @throw [NSException exceptionWithName: @"SqlException" reason: [NSString stringWithFormat: @"Unable to prepare value. '%@'", value] userInfo: nil];
    }
}

- (void)dealloc {
    [self close];
}


- (void)deleteFromTable: (NSString *)table Where:(NSDictionary*)whereClause{
    
    __block NSMutableArray* sqliteFormatValuesWhere = [[NSMutableArray alloc]init];
    [[whereClause allKeys] enumerateObjectsUsingBlock:^(NSString* key, NSUInteger idx, BOOL *stop) {
        [sqliteFormatValuesWhere addObject:[NSString stringWithFormat:@"%@ = %@",key,[[whereClause valueForKey:key] sqliteString]]];
    }];
    NSString *query = [NSString stringWithFormat:@"delete from %@ where (%@)",table,[sqliteFormatValuesWhere componentsJoinedByString:@" AND "]];
    [self deleteFromTable:query];
}
- (BOOL)deleteFromTable:(NSString*)sql{
#if SQLITER ==1
    NSLog(@"\n<Query>: <%@>\n\n",sql);
    
#endif
    [self open];
    BOOL isSuccess = NO;
    
    sqlite3_stmt *statement = NULL;
    
    if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, NULL) != SQLITE_OK) {
        sqlite3_finalize(statement);
        @try {
            [NSException exceptionWithName: @"DBException" reason: [NSString stringWithFormat: @"Failed to perform query with SQL statement. '%p'", sqlite3_errmsg16(_database)] userInfo: nil];
        }
        @catch (NSException *exception) {
#if SQLITER ==1
            NSLog(@"Sqlite Error : %@",exception);
            
#endif
        }
        
    }
    if(sqlite3_step(statement) == SQLITE_DONE){
        isSuccess = YES;
    }
    sqlite3_finalize(statement);
    statement = NULL;
    return isSuccess;
    
}

- (void)insertInto: (NSString *)table ColumnsAndValues:(NSDictionary*)cv {
    __block NSMutableArray* sqliteFormatValues = [[NSMutableArray alloc]init];
    [[cv allValues] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [sqliteFormatValues addObject:[obj sqliteString]];
    }];
    NSString *query = [NSString stringWithFormat:@"insert into %@ (%@) values (%@)",table,[[cv allKeys] componentsJoinedByString:@","],[sqliteFormatValues componentsJoinedByString:@","]];
    [self insertIntoTable:query];
}
- (BOOL)insertIntoTable:(NSString*)sql{
    
#if SQLITER ==1
    if ([sql rangeOfString:@"PaymentTypeAttribute"].location == NSNotFound) {
        NSLog(@"\n<Query>: <%@>\n\n",sql);
    } else {
        NSLog(@"❤❤❤❤❤❤\n\n<Query>: <%@>\n\n❤❤❤❤❤❤",sql);
    }
    
#endif
    [self open];
    
    BOOL isSuccess = NO;
    sqlite3_stmt *statement = NULL;
    
    if (sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, NULL) != SQLITE_OK) {
        sqlite3_finalize(statement);
        @try {
            [NSException exceptionWithName: @"DBException" reason: [NSString stringWithFormat: @"Failed to perform query with SQL statement. '%p'", sqlite3_errmsg16(_database)] userInfo: nil];
        }
        @catch (NSException *exception) {
#if SQLITER ==1
            NSLog(@"Sqlite Error : %@",exception);
#endif
        }
        
    }
    if(sqlite3_step(statement) == SQLITE_DONE) {
        isSuccess = YES;
    }
    
    sqlite3_finalize(statement);
    statement = NULL;
    return isSuccess;
}
#pragma mark - Insert RawMaterials
- (void)insertRawMaterials:(NSArray*)rawMaterials{


    __block NSInteger totalRecords = [rawMaterials count];
    
    [self deleteFromTable:@"DELETE FROM Rawmaterial_Master"];

    [rawMaterials enumerateObjectsUsingBlock:^(Rawmaterials *rawmaterials, NSUInteger idx, BOOL *stop) {
        


        if (idx %5 == 0) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:PROGRESS_COUNT object:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:totalRecords],@"totalRecords",[NSNumber numberWithInteger:idx],@"totalInsertedRecords", nil]];
        }
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                            
                              rawmaterials.rawmaterialgroupid,@"rawmaterialgroupid",
                              rawmaterials.abbrname,@"abbrname",
                              rawmaterials.colorid,@"colorid",
                              rawmaterials.name,@"name",
                              rawmaterials.rawmaterialid,@"rawmaterialid",

                              nil];
        
        [self insertInto:@"Rawmaterial_Master" ColumnsAndValues:dict];
        
    }];
    





}

- (void)insertLasts:(NSArray*)lastsArr{
    
    
    __block NSInteger totalRecords = [lastsArr count];
    
    [self deleteFromTable:@"DELETE FROM Lasts_Master"];
    
    [lastsArr enumerateObjectsUsingBlock:^(Lasts *lasts, NSUInteger idx, BOOL *stop) {
        
        if (idx %5 == 0) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:PROGRESS_COUNT object:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:totalRecords],@"totalRecords",[NSNumber numberWithInteger:idx],@"totalInsertedRecords", nil]];
        }
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              lasts.lastid,@"lastid",
                              lasts.lastname,@"lastname",
                              nil];
        [self insertInto:@"Lasts_Master" ColumnsAndValues:dict];
        
    }];
    
    
    
    
    
    
}
#pragma mark - Insert Articles
- (void)insertArticleMasters:(NSArray*)articleArr{
    
    __block NSInteger totalRecords = [articleArr count];

    
    [self deleteFromTable:@"DELETE FROM Article_Rawmaterials"];
    [self deleteFromTable:@"DELETE FROM Article_Master"];
    [self deleteFromTable:@"DELETE FROM Article_Images"];

    
    [articleArr enumerateObjectsUsingBlock:^(Articles *article, NSUInteger idx, BOOL *stop) {
        
        
        
        if (idx %5 == 0) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:PROGRESS_COUNT object:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:totalRecords],@"totalRecords",[NSNumber numberWithInteger:idx],@"totalInsertedRecords", nil]];
        }
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              
                              [[article soleid] checkEmptyString],@"soleid",
                              [[article artbuyerid] checkEmptyString],@"artbuyerid",
                              [[article lastid] checkEmptyString],@"lastid",
                              [[article articlename] checkEmptyString],@"articlename",
                              [[article price] checkEmptyString],@"price",
                              [[article articleid] checkEmptyString],@"articleid",
                              [[article sizeto] checkEmptyString],@"sizeto",
                              [[article mLC] checkEmptyString],@"mLC",
                              [[article sizefrom] checkEmptyString],@"sizefrom",
                              nil];
        
        [self insertInto:@"Article_Master" ColumnsAndValues:dict];
        
        
        
        
        [[article rawmaterials] enumerateObjectsUsingBlock:^(ArticlesRawmaterials *articlesRawmaterial, NSUInteger idx, BOOL *stop) {
            
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  
                                  [[articlesRawmaterial rawmaterialgroupid] checkEmptyString],@"rawmaterialgroupid",
                                  [[articlesRawmaterial insraw] checkEmptyString],@"insraw",
                                  [[articlesRawmaterial insraw] checkEmptyString],@"leatherpriority",
                                  [[articlesRawmaterial insraw] checkEmptyString],@"colorid",
                                  [[articlesRawmaterial insraw] checkEmptyString],@"rawmaterialid",
                                  
                                  nil];
            
            [self insertInto:@"Article_Rawmaterials" ColumnsAndValues:dict];
            
        }];
        
        
        
        
        

        [[article images] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  article.articleid,@"articleid",
                                  [obj objectForKey:@"image_path"],@"url",
                                  nil];
            
            [self insertInto:@"Article_Images" ColumnsAndValues:dict];
            
        }];

        
    }];
    
    
    
    
    
    
}
#pragma mark - Insert Color
- (void)insertColors:(NSArray*)colors{
    
    
    
    __block NSInteger totalRecords = [colors count];

    
    [self deleteFromTable:@"DELETE FROM Colors"];
    
    [colors enumerateObjectsUsingBlock:^(Colors *color, NSUInteger idx, BOOL *stop) {
        
        
        if (idx %5 == 0) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:PROGRESS_COUNT object:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:totalRecords],@"totalRecords",[NSNumber numberWithInteger:idx],@"totalInsertedRecords", nil]];
        }

        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              color.colorid,@"colorid",
                              color.colorname,@"colorname",
                              nil];
        [self insertInto:@"Colors" ColumnsAndValues:dict];
        
    }];
    
    
    
    
    
    
}
#pragma mark - Insert Clients
- (void)insertClient_Master:(NSArray*)clients{
    
    
    
    __block NSInteger totalRecords = [clients count];

    [self deleteFromTable:@"DELETE FROM Client_Master"];
    [self deleteFromTable:@"DELETE FROM Agents_Master"];

    [clients enumerateObjectsUsingBlock:^(Clients *client, NSUInteger idx, BOOL *stop) {
        
        if (idx %5 == 0) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:PROGRESS_COUNT object:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:totalRecords],@"totalRecords",[NSNumber numberWithInteger:idx],@"totalInsertedRecords", nil]];
        }

        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              
                              [[client name] checkEmptyString],@"name",
                              [[client clientcode] checkEmptyString],@"clientcode",
                              [[client address1] checkEmptyString],@"address1",
                              [[client address2] checkEmptyString],@"address2",
                              [[client company] checkEmptyString],@"company",
                              [[client couriernumber] checkEmptyString],@"couriernumber",
                              [[client couriername] checkEmptyString],@"couriername",
                              [[client city] checkEmptyString],@"city",
                              [[client clienttype] checkEmptyString],@"clienttype",
                              [[client contactperson] checkEmptyString],@"contactperson",
                              [[client country] checkEmptyString],@"country",
                              
                              nil];
        
        [self insertInto:@"Client_Master" ColumnsAndValues:dict];
        
        
        
        
        [[client agents] enumerateObjectsUsingBlock:^(Agents *agent, NSUInteger idx, BOOL *stop) {
            
            
            
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  
                                  [[agent agentid] checkEmptyString],@"agentid",
                                  [[agent address1] checkEmptyString],@"address1",
                                  [[agent faxno] checkEmptyString],@"faxno",
                                  [[agent agentcode] checkEmptyString],@"agentcode",
                                  [[agent address2] checkEmptyString],@"address2",
                                  [[agent company] checkEmptyString],@"company",
                                  [[agent mobileno] checkEmptyString],@"mobileno",
                                  [[agent city] checkEmptyString],@"city",
                                  [[agent phno] checkEmptyString],@"phno",
                                  [[agent pin] checkEmptyString],@"pin",
                                  [[agent contactperson] checkEmptyString],@"contactperson",
                                  [[agent pin] checkEmptyString],@"country",
                                  [[agent contactperson] checkEmptyString],@"email",
                                  
                                  nil];
            
            [self insertInto:@"Agents_Master" ColumnsAndValues:dict];

            
            
        }];
        
        
        
    }];
    
    
    
    
    
    
}

- (void)insertSingleClient:(Clients*)client{

    [self deleteFromTable:[NSString stringWithFormat:@"DELETE FROM Client_Master WHERE clientid = %@",[client.clientid sqliteString]]];

    //TODO::
    //    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
//                          [client.name checkEmptyString],@"name",
//                          [client.address checkEmptyString],@"address",
//                          [client.country checkEmptyString],@"country",
//                          [client.email checkEmptyString],@"email",
//                          [client.clientid checkEmptyString],@"clientid",
//                          [client.state checkEmptyString],@"state",
//                          [client.contactNumber checkEmptyString],@"contactNumber",
//                          nil];
//    
//    [self insertInto:@"Client_Master" ColumnsAndValues:dict];


}
#pragma mark - Get Articles
- (NSArray*)getAllArticles{
    return [self runQuery:@"SELECT * FROM Article_Master" asObject:[Articles class]];
}

- (NSArray*)getAllClients{
    return [self runQuery:@"SELECT * FROM Client_Master" asObject:[Clients class]];
}

@end
