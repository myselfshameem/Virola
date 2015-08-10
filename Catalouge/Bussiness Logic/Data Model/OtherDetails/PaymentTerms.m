//
//  PaymentTerms.m
//
//  Created by iVend  on 8/5/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "PaymentTerms.h"
#import "PaymentTermRemarks.h"


NSString *const kPaymentTermsPaymentTermId = @"payment_term_id";
NSString *const kPaymentTermsPaymentTermRemarks = @"payment_term_remarks";
NSString *const kPaymentTermsPaymentTerm = @"payment_term";


@interface PaymentTerms ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PaymentTerms

@synthesize paymentTermId = _paymentTermId;
@synthesize paymentTermRemarks = _paymentTermRemarks;
@synthesize paymentTerm = _paymentTerm;


+ (PaymentTerms *)modelObjectWithDictionary:(NSDictionary *)dict
{
    PaymentTerms *instance = [[PaymentTerms alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.paymentTermId = [self objectOrNilForKey:kPaymentTermsPaymentTermId fromDictionary:dict];
    NSObject *receivedPaymentTermRemarks = [dict objectForKey:kPaymentTermsPaymentTermRemarks];
    NSMutableArray *parsedPaymentTermRemarks = [NSMutableArray array];
    if ([receivedPaymentTermRemarks isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPaymentTermRemarks) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPaymentTermRemarks addObject:[PaymentTermRemarks modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPaymentTermRemarks isKindOfClass:[NSDictionary class]]) {
       [parsedPaymentTermRemarks addObject:[PaymentTermRemarks modelObjectWithDictionary:(NSDictionary *)receivedPaymentTermRemarks]];
    }

    self.paymentTermRemarks = [NSArray arrayWithArray:parsedPaymentTermRemarks];
            self.paymentTerm = [self objectOrNilForKey:kPaymentTermsPaymentTerm fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.paymentTermId forKey:kPaymentTermsPaymentTermId];
NSMutableArray *tempArrayForPaymentTermRemarks = [NSMutableArray array];
    for (NSObject *subArrayObject in self.paymentTermRemarks) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPaymentTermRemarks addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPaymentTermRemarks addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPaymentTermRemarks] forKey:@"kPaymentTermsPaymentTermRemarks"];
    [mutableDict setValue:self.paymentTerm forKey:kPaymentTermsPaymentTerm];

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

    self.paymentTermId = [aDecoder decodeObjectForKey:kPaymentTermsPaymentTermId];
    self.paymentTermRemarks = [aDecoder decodeObjectForKey:kPaymentTermsPaymentTermRemarks];
    self.paymentTerm = [aDecoder decodeObjectForKey:kPaymentTermsPaymentTerm];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_paymentTermId forKey:kPaymentTermsPaymentTermId];
    [aCoder encodeObject:_paymentTermRemarks forKey:kPaymentTermsPaymentTermRemarks];
    [aCoder encodeObject:_paymentTerm forKey:kPaymentTermsPaymentTerm];
}


@end
