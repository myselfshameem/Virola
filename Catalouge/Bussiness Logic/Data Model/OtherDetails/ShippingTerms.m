//
//  ShippingTerms.m
//
//  Created by iVend  on 8/5/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ShippingTerms.h"


NSString *const kShippingTermsShippingTerm = @"shipping_term";
NSString *const kShippingTermsShippingTermId = @"shipping_term_id";


@interface ShippingTerms ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ShippingTerms

@synthesize shippingTerm = _shippingTerm;
@synthesize shippingTermId = _shippingTermId;


+ (ShippingTerms *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ShippingTerms *instance = [[ShippingTerms alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.shippingTerm = [self objectOrNilForKey:kShippingTermsShippingTerm fromDictionary:dict];
            self.shippingTermId = [self objectOrNilForKey:kShippingTermsShippingTermId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.shippingTerm forKey:kShippingTermsShippingTerm];
    [mutableDict setValue:self.shippingTermId forKey:kShippingTermsShippingTermId];

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

    self.shippingTerm = [aDecoder decodeObjectForKey:kShippingTermsShippingTerm];
    self.shippingTermId = [aDecoder decodeObjectForKey:kShippingTermsShippingTermId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_shippingTerm forKey:kShippingTermsShippingTerm];
    [aCoder encodeObject:_shippingTermId forKey:kShippingTermsShippingTermId];
}


@end
