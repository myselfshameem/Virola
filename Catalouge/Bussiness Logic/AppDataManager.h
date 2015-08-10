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
@class PaymentTerms;
@class PaymentTermRemarks;
@class ShippingTerms;
@class Modeofshipping;
@class Rawmaterials;
@interface AppDataManager : NSObject

+(AppDataManager*)sharedAppDatamanager;
@property (strong, nonatomic) Account *account;
@property (strong, nonatomic) __block TrxTransaction *transaction;
@property (strong, nonatomic) Clients *selectedClient;
@property (strong, nonatomic) NSMutableArray *quantityOption;

//Payments Terms
@property (strong, nonatomic) PaymentTerms *paymentTerms;
@property (strong, nonatomic) PaymentTermRemarks *paymentTermRemakrs;
@property (strong, nonatomic) ShippingTerms *shippingTerms;
@property (strong, nonatomic) Modeofshipping *modeofshipping;
@property (strong, nonatomic) NSString *shippingTermsRemarks;



@property (strong, nonatomic) NSString *DevelopmentImageDir;
- (TrxTransaction*)newTransactionWithArticleId:(NSString*)articleId withNewDevelopment:(BOOL)flag;
- (void)writeDataToImageFileName:(NSString*)filename withData:(NSData*)data;
- (NSString*)imageDirPath;
- (void)deleteLoggedInUserDetails;
- (void)saveLoggedInUserDetails:(Account*)account;
- (Account*)lastLoggedInUser;
- (NSString*)fetchNewDevelopmentImageDir;
- (NSString*)validateString:(NSString*)value;
- (void)insertIntoTrx_Rawmaterials:(Rawmaterials*)rawmaterial withTrx:(TrxTransaction*)local;
- (NSMutableArray*)getSizeArr;
- (void)addRawMaterialLeather:(Rawmaterials*)raw;
- (void)addRawMaterialLining:(Rawmaterials*)raw;
- (NSString*)getIsChange;
@end
