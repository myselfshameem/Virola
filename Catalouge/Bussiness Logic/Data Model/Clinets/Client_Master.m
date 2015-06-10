//
//  Client_Master.m
//
//  Created by iVend  on 6/5/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Client_Master.h"
#import "Clients.h"


NSString *const kClient_MasterSuccess = @"success";
NSString *const kClient_MasterMessage = @"message";
NSString *const kClient_MasterErrorcode = @"errorcode";
NSString *const kClient_MasterClients = @"clients";
NSString *const kClient_MasterVersion = @"version";


@interface Client_Master ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Client_Master

@synthesize success = _success;
@synthesize message = _message;
@synthesize errorcode = _errorcode;
@synthesize clients = _clients;
@synthesize version = _version;


+ (Client_Master *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Client_Master *instance = [[Client_Master alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.success = [self objectOrNilForKey:kClient_MasterSuccess fromDictionary:dict];
            self.message = [self objectOrNilForKey:kClient_MasterMessage fromDictionary:dict];
            self.errorcode = [self objectOrNilForKey:kClient_MasterErrorcode fromDictionary:dict];
    NSObject *receivedClients = [dict objectForKey:kClient_MasterClients];
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
            self.version = [self objectOrNilForKey:kClient_MasterVersion fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.success forKey:kClient_MasterSuccess];
    [mutableDict setValue:self.message forKey:kClient_MasterMessage];
    [mutableDict setValue:self.errorcode forKey:kClient_MasterErrorcode];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForClients] forKey:@"kClient_MasterClients"];
    [mutableDict setValue:self.version forKey:kClient_MasterVersion];

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

    self.success = [aDecoder decodeObjectForKey:kClient_MasterSuccess];
    self.message = [aDecoder decodeObjectForKey:kClient_MasterMessage];
    self.errorcode = [aDecoder decodeObjectForKey:kClient_MasterErrorcode];
    self.clients = [aDecoder decodeObjectForKey:kClient_MasterClients];
    self.version = [aDecoder decodeObjectForKey:kClient_MasterVersion];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_success forKey:kClient_MasterSuccess];
    [aCoder encodeObject:_message forKey:kClient_MasterMessage];
    [aCoder encodeObject:_errorcode forKey:kClient_MasterErrorcode];
    [aCoder encodeObject:_clients forKey:kClient_MasterClients];
    [aCoder encodeObject:_version forKey:kClient_MasterVersion];
}


@end
