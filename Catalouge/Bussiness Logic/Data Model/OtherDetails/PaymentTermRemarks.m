//
//  PaymentTermRemarks.m
//
//  Created by iVend  on 8/5/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PaymentTermRemarks.h"


NSString *const kPaymentTermRemarksPaymentTermRemarkId = @"payment_term_remark_id";
NSString *const kPaymentTermRemarksPaymentTermRemark = @"payment_term_remark";


@interface PaymentTermRemarks ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PaymentTermRemarks

@synthesize paymentTermRemarkId = _paymentTermRemarkId;
@synthesize paymentTermRemark = _paymentTermRemark;
@synthesize paymentTermId = _paymentTermId;

+ (PaymentTermRemarks *)modelObjectWithDictionary:(NSDictionary *)dict
{
    PaymentTermRemarks *instance = [[PaymentTermRemarks alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.paymentTermRemarkId = [self objectOrNilForKey:kPaymentTermRemarksPaymentTermRemarkId fromDictionary:dict];
            self.paymentTermRemark = [self objectOrNilForKey:kPaymentTermRemarksPaymentTermRemark fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.paymentTermRemarkId forKey:kPaymentTermRemarksPaymentTermRemarkId];
    [mutableDict setValue:self.paymentTermRemark forKey:kPaymentTermRemarksPaymentTermRemark];

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

    self.paymentTermRemarkId = [aDecoder decodeObjectForKey:kPaymentTermRemarksPaymentTermRemarkId];
    self.paymentTermRemark = [aDecoder decodeObjectForKey:kPaymentTermRemarksPaymentTermRemark];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_paymentTermRemarkId forKey:kPaymentTermRemarksPaymentTermRemarkId];
    [aCoder encodeObject:_paymentTermRemark forKey:kPaymentTermRemarksPaymentTermRemark];
}


@end
