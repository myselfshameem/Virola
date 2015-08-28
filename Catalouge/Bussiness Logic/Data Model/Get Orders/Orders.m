//
//  Orders.m
//
//  Created by iVend  on 8/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Orders.h"


NSString *const kOrdersPaymentTerms = @"PaymentTerms";
NSString *const kOrdersModeShippingTerms = @"ModeShippingTerms";
NSString *const kOrdersShippingTermsRemarks = @"ShippingTermsRemarks";
NSString *const kOrdersClientType = @"ClientType";
NSString *const kOrdersOrderID = @"OrderID";
NSString *const kOrdersOrderDate = @"OrderDate";
NSString *const kOrdersRemark = @"Remark";
NSString *const kOrdersPaymentTermsRemarks = @"PaymentTermsRemarks";
NSString *const kOrdersCompany = @"Company";
NSString *const kOrdersOrderNo = @"OrderNo";
NSString *const kOrdersShippingTerms = @"ShippingTerms";
NSString *const kOrdersBuyerID = @"BuyerID";
NSString *const kOrdersClientCode = @"ClientCode";
NSString *const kOrdersAgentID = @"AgentID";
NSString *const kOrdersModeShippingTermsRemarks = @"ModeShippingTermsRemarks";
NSString *const kOrdersOrderType = @"OrderType";


@interface Orders ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Orders

@synthesize paymentTerms = _paymentTerms;
@synthesize modeShippingTerms = _modeShippingTerms;
@synthesize shippingTermsRemarks = _shippingTermsRemarks;
@synthesize clientType = _clientType;
@synthesize orderID = _orderID;
@synthesize orderDate = _orderDate;
@synthesize remark = _remark;
@synthesize paymentTermsRemarks = _paymentTermsRemarks;
@synthesize company = _company;
@synthesize orderNo = _orderNo;
@synthesize shippingTerms = _shippingTerms;
@synthesize buyerID = _buyerID;
@synthesize clientCode = _clientCode;
@synthesize agentID = _agentID;
@synthesize modeShippingTermsRemarks = _modeShippingTermsRemarks;
@synthesize orderType = _orderType;


+ (Orders *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Orders *instance = [[Orders alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.paymentTerms = [self objectOrNilForKey:kOrdersPaymentTerms fromDictionary:dict];
            self.modeShippingTerms = [self objectOrNilForKey:kOrdersModeShippingTerms fromDictionary:dict];
            self.shippingTermsRemarks = [self objectOrNilForKey:kOrdersShippingTermsRemarks fromDictionary:dict];
            self.clientType = [self objectOrNilForKey:kOrdersClientType fromDictionary:dict];
            self.orderID = [self objectOrNilForKey:kOrdersOrderID fromDictionary:dict];
            self.orderDate = [self objectOrNilForKey:kOrdersOrderDate fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kOrdersRemark fromDictionary:dict];
            self.paymentTermsRemarks = [self objectOrNilForKey:kOrdersPaymentTermsRemarks fromDictionary:dict];
            self.company = [self objectOrNilForKey:kOrdersCompany fromDictionary:dict];
            self.orderNo = [self objectOrNilForKey:kOrdersOrderNo fromDictionary:dict];
            self.shippingTerms = [self objectOrNilForKey:kOrdersShippingTerms fromDictionary:dict];
            self.buyerID = [self objectOrNilForKey:kOrdersBuyerID fromDictionary:dict];
            self.clientCode = [self objectOrNilForKey:kOrdersClientCode fromDictionary:dict];
            self.agentID = [self objectOrNilForKey:kOrdersAgentID fromDictionary:dict];
            self.modeShippingTermsRemarks = [self objectOrNilForKey:kOrdersModeShippingTermsRemarks fromDictionary:dict];
            self.orderType = [self objectOrNilForKey:kOrdersOrderType fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.paymentTerms forKey:kOrdersPaymentTerms];
    [mutableDict setValue:self.modeShippingTerms forKey:kOrdersModeShippingTerms];
    [mutableDict setValue:self.shippingTermsRemarks forKey:kOrdersShippingTermsRemarks];
    [mutableDict setValue:self.clientType forKey:kOrdersClientType];
    [mutableDict setValue:self.orderID forKey:kOrdersOrderID];
    [mutableDict setValue:self.orderDate forKey:kOrdersOrderDate];
    [mutableDict setValue:self.remark forKey:kOrdersRemark];
    [mutableDict setValue:self.paymentTermsRemarks forKey:kOrdersPaymentTermsRemarks];
    [mutableDict setValue:self.company forKey:kOrdersCompany];
    [mutableDict setValue:self.orderNo forKey:kOrdersOrderNo];
    [mutableDict setValue:self.shippingTerms forKey:kOrdersShippingTerms];
    [mutableDict setValue:self.buyerID forKey:kOrdersBuyerID];
    [mutableDict setValue:self.clientCode forKey:kOrdersClientCode];
    [mutableDict setValue:self.agentID forKey:kOrdersAgentID];
    [mutableDict setValue:self.modeShippingTermsRemarks forKey:kOrdersModeShippingTermsRemarks];
    [mutableDict setValue:self.orderType forKey:kOrdersOrderType];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.paymentTerms = [aDecoder decodeObjectForKey:kOrdersPaymentTerms];
    self.modeShippingTerms = [aDecoder decodeObjectForKey:kOrdersModeShippingTerms];
    self.shippingTermsRemarks = [aDecoder decodeObjectForKey:kOrdersShippingTermsRemarks];
    self.clientType = [aDecoder decodeObjectForKey:kOrdersClientType];
    self.orderID = [aDecoder decodeObjectForKey:kOrdersOrderID];
    self.orderDate = [aDecoder decodeObjectForKey:kOrdersOrderDate];
    self.remark = [aDecoder decodeObjectForKey:kOrdersRemark];
    self.paymentTermsRemarks = [aDecoder decodeObjectForKey:kOrdersPaymentTermsRemarks];
    self.company = [aDecoder decodeObjectForKey:kOrdersCompany];
    self.orderNo = [aDecoder decodeObjectForKey:kOrdersOrderNo];
    self.shippingTerms = [aDecoder decodeObjectForKey:kOrdersShippingTerms];
    self.buyerID = [aDecoder decodeObjectForKey:kOrdersBuyerID];
    self.clientCode = [aDecoder decodeObjectForKey:kOrdersClientCode];
    self.agentID = [aDecoder decodeObjectForKey:kOrdersAgentID];
    self.modeShippingTermsRemarks = [aDecoder decodeObjectForKey:kOrdersModeShippingTermsRemarks];
    self.orderType = [aDecoder decodeObjectForKey:kOrdersOrderType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_paymentTerms forKey:kOrdersPaymentTerms];
    [aCoder encodeObject:_modeShippingTerms forKey:kOrdersModeShippingTerms];
    [aCoder encodeObject:_shippingTermsRemarks forKey:kOrdersShippingTermsRemarks];
    [aCoder encodeObject:_clientType forKey:kOrdersClientType];
    [aCoder encodeObject:_orderID forKey:kOrdersOrderID];
    [aCoder encodeObject:_orderDate forKey:kOrdersOrderDate];
    [aCoder encodeObject:_remark forKey:kOrdersRemark];
    [aCoder encodeObject:_paymentTermsRemarks forKey:kOrdersPaymentTermsRemarks];
    [aCoder encodeObject:_company forKey:kOrdersCompany];
    [aCoder encodeObject:_orderNo forKey:kOrdersOrderNo];
    [aCoder encodeObject:_shippingTerms forKey:kOrdersShippingTerms];
    [aCoder encodeObject:_buyerID forKey:kOrdersBuyerID];
    [aCoder encodeObject:_clientCode forKey:kOrdersClientCode];
    [aCoder encodeObject:_agentID forKey:kOrdersAgentID];
    [aCoder encodeObject:_modeShippingTermsRemarks forKey:kOrdersModeShippingTermsRemarks];
    [aCoder encodeObject:_orderType forKey:kOrdersOrderType];
}


@end
