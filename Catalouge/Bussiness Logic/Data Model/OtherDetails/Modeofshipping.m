//
//  Modeofshipping.m
//
//  Created by iVend  on 8/5/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Modeofshipping.h"


NSString *const kModeofshippingShippingModeId = @"shipping_mode_id";
NSString *const kModeofshippingShippingMode = @"shipping_mode";


@interface Modeofshipping ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Modeofshipping

@synthesize shippingModeId = _shippingModeId;
@synthesize shippingMode = _shippingMode;


+ (Modeofshipping *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Modeofshipping *instance = [[Modeofshipping alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.shippingModeId = [self objectOrNilForKey:kModeofshippingShippingModeId fromDictionary:dict];
            self.shippingMode = [self objectOrNilForKey:kModeofshippingShippingMode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.shippingModeId forKey:kModeofshippingShippingModeId];
    [mutableDict setValue:self.shippingMode forKey:kModeofshippingShippingMode];

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

    self.shippingModeId = [aDecoder decodeObjectForKey:kModeofshippingShippingModeId];
    self.shippingMode = [aDecoder decodeObjectForKey:kModeofshippingShippingMode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_shippingModeId forKey:kModeofshippingShippingModeId];
    [aCoder encodeObject:_shippingMode forKey:kModeofshippingShippingMode];
}


@end
