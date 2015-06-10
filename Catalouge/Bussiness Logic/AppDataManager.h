//
//  AppDataManager.h
//  Catalouge
//
//  Created by Shameem Ahamad on 5/21/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Account;
@class TrxTransaction;
@class Clients;
@interface AppDataManager : NSObject

+(AppDataManager*)sharedAppDatamanager;
@property (strong, nonatomic) Account *account;
@property (strong, nonatomic) TrxTransaction *transaction;
@property (strong, nonatomic) Clients *selectedClient;
- (TrxTransaction*)newTransactionWithArticleId:(NSString*)articleId;
- (void)writeDataToImageFileName:(NSString*)filename withData:(NSData*)data;
- (NSString*)imageDirPath;
@end
