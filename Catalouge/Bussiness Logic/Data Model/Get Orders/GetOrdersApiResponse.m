//
//  GetOrdersApiResponse.m
//
//  Created by iVend  on 8/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "GetOrdersApiResponse.h"
#import "Orders.h"


NSString *const kGetOrdersApiResponseSuccess = @"success";
NSString *const kGetOrdersApiResponseOrders = @"orders";
NSString *const kGetOrdersApiResponseErrorcode = @"errorcode";
NSString *const kGetOrdersApiResponseMessage = @"message";
NSString *const kGetOrdersApiResponseVersion = @"version";


@interface GetOrdersApiResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GetOrdersApiResponse

@synthesize success = _success;
@synthesize orders = _orders;
@synthesize errorcode = _errorcode;
@synthesize message = _message;
@synthesize version = _version;


+ (GetOrdersApiResponse *)modelObjectWithDictionary:(NSDictionary *)dict
{
    GetOrdersApiResponse *instance = [[GetOrdersApiResponse alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.success = [self objectOrNilForKey:kGetOrdersApiResponseSuccess fromDictionary:dict];
    NSObject *receivedOrders = [dict objectForKey:kGetOrdersApiResponseOrders];
    NSMutableArray *parsedOrders = [NSMutableArray array];
    if ([receivedOrders isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedOrders) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedOrders addObject:[Orders modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedOrders isKindOfClass:[NSDictionary class]]) {
       [parsedOrders addObject:[Orders modelObjectWithDictionary:(NSDictionary *)receivedOrders]];
    }

    self.orders = [NSArray arrayWithArray:parsedOrders];
            self.errorcode = [self objectOrNilForKey:kGetOrdersApiResponseErrorcode fromDictionary:dict];
            self.message = [self objectOrNilForKey:kGetOrdersApiResponseMessage fromDictionary:dict];
            self.version = [self objectOrNilForKey:kGetOrdersApiResponseVersion fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.success forKey:kGetOrdersApiResponseSuccess];
NSMutableArray *tempArrayForOrders = [NSMutableArray array];
    for (NSObject *subArrayObject in self.orders) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForOrders addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForOrders addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForOrders] forKey:@"kGetOrdersApiResponseOrders"];
    [mutableDict setValue:self.errorcode forKey:kGetOrdersApiResponseErrorcode];
    [mutableDict setValue:self.message forKey:kGetOrdersApiResponseMessage];
    [mutableDict setValue:self.version forKey:kGetOrdersApiResponseVersion];

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

    self.success = [aDecoder decodeObjectForKey:kGetOrdersApiResponseSuccess];
    self.orders = [aDecoder decodeObjectForKey:kGetOrdersApiResponseOrders];
    self.errorcode = [aDecoder decodeObjectForKey:kGetOrdersApiResponseErrorcode];
    self.message = [aDecoder decodeObjectForKey:kGetOrdersApiResponseMessage];
    self.version = [aDecoder decodeObjectForKey:kGetOrdersApiResponseVersion];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_success forKey:kGetOrdersApiResponseSuccess];
    [aCoder encodeObject:_orders forKey:kGetOrdersApiResponseOrders];
    [aCoder encodeObject:_errorcode forKey:kGetOrdersApiResponseErrorcode];
    [aCoder encodeObject:_message forKey:kGetOrdersApiResponseMessage];
    [aCoder encodeObject:_version forKey:kGetOrdersApiResponseVersion];
}


@end
