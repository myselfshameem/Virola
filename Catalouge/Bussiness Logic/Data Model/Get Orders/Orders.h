//
//  Orders.h
//
//  Created by iVend  on 8/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Orders : NSObject <NSCoding>

@property (nonatomic, strong) NSString *paymentTerms;
@property (nonatomic, strong) NSString *modeShippingTerms;
@property (nonatomic, strong) NSString *shippingTermsRemarks;
@property (nonatomic, strong) NSString *clientType;
@property (nonatomic, strong) NSString *orderID;
@property (nonatomic, strong) NSString *orderDate;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *paymentTermsRemarks;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *shippingTerms;
@property (nonatomic, strong) NSString *buyerID;
@property (nonatomic, strong) NSString *clientCode;
@property (nonatomic, strong) NSString *agentID;
@property (nonatomic, strong) NSString *modeShippingTermsRemarks;
@property (nonatomic, strong) NSString *orderType;

+ (Orders *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
