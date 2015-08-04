//
//  CXSSqliteHelper.h
//  iVendPOS
//
//  Created by Shameem Ahamad on 7/24/14.
//  Copyright (c) 2014 cxsmac2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h> // Requires libsqlite3.dylib

@interface CXSSqliteHelper : NSObject
{

@protected
    NSString *_dataSource;
    sqlite3 *_database;
    BOOL _isConnected;

}

+ (CXSSqliteHelper*)sharedSqliteHelper;
- (NSArray *)runQuery: (NSString *)sql;
- (NSArray *) runQuery: (NSString *)sql asObject: (Class)model ;
- (void)deleteRequiredTableDataFromDataBase ;
- (void)insertInto: (NSString *)table ColumnsAndValues:(NSDictionary*)cv ;
- (void)updateTable: (NSString *)table ColumnsAndValues:(NSDictionary*)cv Where:(NSDictionary*)whereClause;
- (void)deleteFromTable: (NSString *)table Where:(NSDictionary*)whereClause;
- (NSArray*)hasMany:(Class)cls foreignKeyValues:(NSDictionary*)foreignKeyValues;
- (BOOL)updateIntoTable:(NSString*)sql;
- (int)rowCount: (NSString *)sql;
- (void)close;
- (void)open;
- (void)dataSourceForDocumentNumberSeriesCheck:(NSString*)path;
- (BOOL)runRawQuery:(NSString*)sql;
- (BOOL)checkColumnExists:(NSString*)sqlStatement;
- (NSMutableArray*)getCustomerUDFList: (NSString*)query withIsNewCustomer:(BOOL)isNewCustomer;
- (NSMutableArray*)getInvUDFList: (NSString*)query;
- (void)insertRawMaterials:(NSArray*)rawMaterials;
- (void)insertArticleMasters:(NSArray*)articleArr;
- (void)insertColors:(NSArray*)colors;
- (void)insertClient_Master:(NSArray*)clients;
- (void)insertSingleClient:(Clients*)client;
- (void)insertLasts:(NSArray*)lastsArr;

- (NSArray*)getAllArticles;
- (NSArray*)getAllClients;
@end
