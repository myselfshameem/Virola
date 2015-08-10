//
//  GetOtherDetailsApiResponse.m
//
//  Created by iVend  on 8/5/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GetOtherDetailsApiResponse.h"
#import "Modeofshipping.h"
#import "ShippingTerms.h"
#import "PaymentTerms.h"


NSString *const kGetOtherDetailsApiResponseModeofshipping = @"modeofshipping";
NSString *const kGetOtherDetailsApiResponseErrorcode = @"errorcode";
NSString *const kGetOtherDetailsApiResponseSuccess = @"success";
NSString *const kGetOtherDetailsApiResponseMessage = @"message";
NSString *const kGetOtherDetailsApiResponseShippingTerms = @"shipping_terms";
NSString *const kGetOtherDetailsApiResponseVersion = @"version";
NSString *const kGetOtherDetailsApiResponsePaymentTerms = @"payment_terms";


@interface GetOtherDetailsApiResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetOtherDetailsApiResponse

@synthesize modeofshipping = _modeofshipping;
@synthesize errorcode = _errorcode;
@synthesize success = _success;
@synthesize message = _message;
@synthesize shippingTerms = _shippingTerms;
@synthesize version = _version;
@synthesize paymentTerms = _paymentTerms;


+ (GetOtherDetailsApiResponse *)modelObjectWithDictionary:(NSDictionary *)dict
{
    GetOtherDetailsApiResponse *instance = [[GetOtherDetailsApiResponse alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedModeofshipping = [dict objectForKey:kGetOtherDetailsApiResponseModeofshipping];
    NSMutableArray *parsedModeofshipping = [NSMutableArray array];
    if ([receivedModeofshipping isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedModeofshipping) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedModeofshipping addObject:[Modeofshipping modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedModeofshipping isKindOfClass:[NSDictionary class]]) {
       [parsedModeofshipping addObject:[Modeofshipping modelObjectWithDictionary:(NSDictionary *)receivedModeofshipping]];
    }

    self.modeofshipping = [NSArray arrayWithArray:parsedModeofshipping];
            self.errorcode = [self objectOrNilForKey:kGetOtherDetailsApiResponseErrorcode fromDictionary:dict];
            self.success = [self objectOrNilForKey:kGetOtherDetailsApiResponseSuccess fromDictionary:dict];
            self.message = [self objectOrNilForKey:kGetOtherDetailsApiResponseMessage fromDictionary:dict];
    NSObject *receivedShippingTerms = [dict objectForKey:kGetOtherDetailsApiResponseShippingTerms];
    NSMutableArray *parsedShippingTerms = [NSMutableArray array];
    if ([receivedShippingTerms isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedShippingTerms) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedShippingTerms addObject:[ShippingTerms modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedShippingTerms isKindOfClass:[NSDictionary class]]) {
       [parsedShippingTerms addObject:[ShippingTerms modelObjectWithDictionary:(NSDictionary *)receivedShippingTerms]];
    }

    self.shippingTerms = [NSArray arrayWithArray:parsedShippingTerms];
            self.version = [self objectOrNilForKey:kGetOtherDetailsApiResponseVersion fromDictionary:dict];
    NSObject *receivedPaymentTerms = [dict objectForKey:kGetOtherDetailsApiResponsePaymentTerms];
    NSMutableArray *parsedPaymentTerms = [NSMutableArray array];
    if ([receivedPaymentTerms isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPaymentTerms) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPaymentTerms addObject:[PaymentTerms modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPaymentTerms isKindOfClass:[NSDictionary class]]) {
       [parsedPaymentTerms addObject:[PaymentTerms modelObjectWithDictionary:(NSDictionary *)receivedPaymentTerms]];
    }

    self.paymentTerms = [NSArray arrayWithArray:parsedPaymentTerms];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForModeofshipping = [NSMutableArray array];
    for (NSObject *subArrayObject in self.modeofshipping) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForModeofshipping addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForModeofshipping addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForModeofshipping] forKey:@"kGetOtherDetailsApiResponseModeofshipping"];
    [mutableDict setValue:self.errorcode forKey:kGetOtherDetailsApiResponseErrorcode];
    [mutableDict setValue:self.success forKey:kGetOtherDetailsApiResponseSuccess];
    [mutableDict setValue:self.message forKey:kGetOtherDetailsApiResponseMessage];
NSMutableArray *tempArrayForShippingTerms = [NSMutableArray array];
    for (NSObject *subArrayObject in self.shippingTerms) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForShippingTerms addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForShippingTerms addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForShippingTerms] forKey:@"kGetOtherDetailsApiResponseShippingTerms"];
    [mutableDict setValue:self.version forKey:kGetOtherDetailsApiResponseVersion];
NSMutableArray *tempArrayForPaymentTerms = [NSMutableArray array];
    for (NSObject *subArrayObject in self.paymentTerms) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPaymentTerms addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPaymentTerms addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPaymentTerms] forKey:@"kGetOtherDetailsApiResponsePaymentTerms"];

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

    self.modeofshipping = [aDecoder decodeObjectForKey:kGetOtherDetailsApiResponseModeofshipping];
    self.errorcode = [aDecoder decodeObjectForKey:kGetOtherDetailsApiResponseErrorcode];
    self.success = [aDecoder decodeObjectForKey:kGetOtherDetailsApiResponseSuccess];
    self.message = [aDecoder decodeObjectForKey:kGetOtherDetailsApiResponseMessage];
    self.shippingTerms = [aDecoder decodeObjectForKey:kGetOtherDetailsApiResponseShippingTerms];
    self.version = [aDecoder decodeObjectForKey:kGetOtherDetailsApiResponseVersion];
    self.paymentTerms = [aDecoder decodeObjectForKey:kGetOtherDetailsApiResponsePaymentTerms];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_modeofshipping forKey:kGetOtherDetailsApiResponseModeofshipping];
    [aCoder encodeObject:_errorcode forKey:kGetOtherDetailsApiResponseErrorcode];
    [aCoder encodeObject:_success forKey:kGetOtherDetailsApiResponseSuccess];
    [aCoder encodeObject:_message forKey:kGetOtherDetailsApiResponseMessage];
    [aCoder encodeObject:_shippingTerms forKey:kGetOtherDetailsApiResponseShippingTerms];
    [aCoder encodeObject:_version forKey:kGetOtherDetailsApiResponseVersion];
    [aCoder encodeObject:_paymentTerms forKey:kGetOtherDetailsApiResponsePaymentTerms];
}


@end
