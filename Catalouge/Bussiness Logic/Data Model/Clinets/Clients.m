//
//  Clients.m
//
//  Created by iVend  on 6/5/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Clients.h"


NSString *const kClientsName = @"name";
NSString *const kClientsAddress = @"address";
NSString *const kClientsCountry = @"country";
NSString *const kClientsEmail = @"email";
NSString *const kClientsClientid = @"clientid";
NSString *const kClientsState = @"state";
NSString *const kClientsContactNumber = @"contact_number";


@interface Clients ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Clients

@synthesize name = _name;
@synthesize address = _address;
@synthesize country = _country;
@synthesize email = _email;
@synthesize clientid = _clientid;
@synthesize state = _state;
@synthesize contactNumber = _contactNumber;


+ (Clients *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Clients *instance = [[Clients alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.name = [self objectOrNilForKey:kClientsName fromDictionary:dict];
            self.address = [self objectOrNilForKey:kClientsAddress fromDictionary:dict];
            self.country = [self objectOrNilForKey:kClientsCountry fromDictionary:dict];
            self.email = [self objectOrNilForKey:kClientsEmail fromDictionary:dict];
            self.clientid = [self objectOrNilForKey:kClientsClientid fromDictionary:dict];
            self.state = [self objectOrNilForKey:kClientsState fromDictionary:dict];
            self.contactNumber = [self objectOrNilForKey:kClientsContactNumber fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kClientsName];
    [mutableDict setValue:self.address forKey:kClientsAddress];
    [mutableDict setValue:self.country forKey:kClientsCountry];
    [mutableDict setValue:self.email forKey:kClientsEmail];
    [mutableDict setValue:self.clientid forKey:kClientsClientid];
    [mutableDict setValue:self.state forKey:kClientsState];
    [mutableDict setValue:self.contactNumber forKey:kClientsContactNumber];

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

    self.name = [aDecoder decodeObjectForKey:kClientsName];
    self.address = [aDecoder decodeObjectForKey:kClientsAddress];
    self.country = [aDecoder decodeObjectForKey:kClientsCountry];
    self.email = [aDecoder decodeObjectForKey:kClientsEmail];
    self.clientid = [aDecoder decodeObjectForKey:kClientsClientid];
    self.state = [aDecoder decodeObjectForKey:kClientsState];
    self.contactNumber = [aDecoder decodeObjectForKey:kClientsContactNumber];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kClientsName];
    [aCoder encodeObject:_address forKey:kClientsAddress];
    [aCoder encodeObject:_country forKey:kClientsCountry];
    [aCoder encodeObject:_email forKey:kClientsEmail];
    [aCoder encodeObject:_clientid forKey:kClientsClientid];
    [aCoder encodeObject:_state forKey:kClientsState];
    [aCoder encodeObject:_contactNumber forKey:kClientsContactNumber];
}


@end
