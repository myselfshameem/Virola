//
//  ClientsApiResponse.m
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ClientsApiResponse.h"
#import "Clients.h"


NSString *const kClientsApiResponseSuccess = @"success";
NSString *const kClientsApiResponseMessage = @"message";
NSString *const kClientsApiResponseErrorcode = @"errorcode";
NSString *const kClientsApiResponseClients = @"clients";
NSString *const kClientsApiResponseVersion = @"version";


@interface ClientsApiResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ClientsApiResponse

@synthesize success = _success;
@synthesize message = _message;
@synthesize errorcode = _errorcode;
@synthesize clients = _clients;
@synthesize version = _version;


+ (ClientsApiResponse *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ClientsApiResponse *instance = [[ClientsApiResponse alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.success = [self objectOrNilForKey:kClientsApiResponseSuccess fromDictionary:dict];
            self.message = [self objectOrNilForKey:kClientsApiResponseMessage fromDictionary:dict];
            self.errorcode = [self objectOrNilForKey:kClientsApiResponseErrorcode fromDictionary:dict];
    NSObject *receivedClients = [dict objectForKey:kClientsApiResponseClients];
    NSMutableArray *parsedClients = [NSMutableArray array];
    if ([receivedClients isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedClients) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedClients addObject:[Clients modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedClients isKindOfClass:[NSDictionary class]]) {
       [parsedClients addObject:[Clients modelObjectWithDictionary:(NSDictionary *)receivedClients]];
    }

    self.clients = [NSArray arrayWithArray:parsedClients];
            self.version = [self objectOrNilForKey:kClientsApiResponseVersion fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.success forKey:kClientsApiResponseSuccess];
    [mutableDict setValue:self.message forKey:kClientsApiResponseMessage];
    [mutableDict setValue:self.errorcode forKey:kClientsApiResponseErrorcode];
NSMutableArray *tempArrayForClients = [NSMutableArray array];
    for (NSObject *subArrayObject in self.clients) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForClients addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForClients addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForClients] forKey:@"kClientsApiResponseClients"];
    [mutableDict setValue:self.version forKey:kClientsApiResponseVersion];

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

    self.success = [aDecoder decodeObjectForKey:kClientsApiResponseSuccess];
    self.message = [aDecoder decodeObjectForKey:kClientsApiResponseMessage];
    self.errorcode = [aDecoder decodeObjectForKey:kClientsApiResponseErrorcode];
    self.clients = [aDecoder decodeObjectForKey:kClientsApiResponseClients];
    self.version = [aDecoder decodeObjectForKey:kClientsApiResponseVersion];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_success forKey:kClientsApiResponseSuccess];
    [aCoder encodeObject:_message forKey:kClientsApiResponseMessage];
    [aCoder encodeObject:_errorcode forKey:kClientsApiResponseErrorcode];
    [aCoder encodeObject:_clients forKey:kClientsApiResponseClients];
    [aCoder encodeObject:_version forKey:kClientsApiResponseVersion];
}


@end
