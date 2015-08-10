//
//  Agents.m
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Agents.h"


NSString *const kAgentsAgentid = @"agentid";
NSString *const kAgentsAddress1 = @"address1";
NSString *const kAgentsFaxno = @"faxno";
NSString *const kAgentsAgentcode = @"agentcode";
NSString *const kAgentsAddress2 = @"address2";
NSString *const kAgentsCompany = @"company";
NSString *const kAgentsMobileno = @"mobileno";
NSString *const kAgentsCity = @"city";
NSString *const kAgentsPhno = @"phno";
NSString *const kAgentsPin = @"pin";
NSString *const kAgentsContactperson = @"contactperson";
NSString *const kAgentsCountry = @"country";
NSString *const kAgentsEmail = @"email";
NSString *const kClientid = @"clientid";

@interface Agents ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Agents

@synthesize agentid = _agentid;
@synthesize address1 = _address1;
@synthesize faxno = _faxno;
@synthesize agentcode = _agentcode;
@synthesize address2 = _address2;
@synthesize company = _company;
@synthesize mobileno = _mobileno;
@synthesize city = _city;
@synthesize phno = _phno;
@synthesize pin = _pin;
@synthesize contactperson = _contactperson;
@synthesize country = _country;
@synthesize email = _email;


+ (Agents *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Agents *instance = [[Agents alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.agentid = [self objectOrNilForKey:kAgentsAgentid fromDictionary:dict];
            self.address1 = [self objectOrNilForKey:kAgentsAddress1 fromDictionary:dict];
            self.faxno = [self objectOrNilForKey:kAgentsFaxno fromDictionary:dict];
            self.agentcode = [self objectOrNilForKey:kAgentsAgentcode fromDictionary:dict];
            self.address2 = [self objectOrNilForKey:kAgentsAddress2 fromDictionary:dict];
            self.company = [self objectOrNilForKey:kAgentsCompany fromDictionary:dict];
            self.mobileno = [self objectOrNilForKey:kAgentsMobileno fromDictionary:dict];
            self.city = [self objectOrNilForKey:kAgentsCity fromDictionary:dict];
            self.phno = [self objectOrNilForKey:kAgentsPhno fromDictionary:dict];
            self.pin = [self objectOrNilForKey:kAgentsPin fromDictionary:dict];
            self.contactperson = [self objectOrNilForKey:kAgentsContactperson fromDictionary:dict];
            self.country = [self objectOrNilForKey:kAgentsCountry fromDictionary:dict];
            self.email = [self objectOrNilForKey:kAgentsEmail fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.agentid forKey:kAgentsAgentid];
    [mutableDict setValue:self.address1 forKey:kAgentsAddress1];
    [mutableDict setValue:self.faxno forKey:kAgentsFaxno];
    [mutableDict setValue:self.agentcode forKey:kAgentsAgentcode];
    [mutableDict setValue:self.address2 forKey:kAgentsAddress2];
    [mutableDict setValue:self.company forKey:kAgentsCompany];
    [mutableDict setValue:self.mobileno forKey:kAgentsMobileno];
    [mutableDict setValue:self.city forKey:kAgentsCity];
    [mutableDict setValue:self.phno forKey:kAgentsPhno];
    [mutableDict setValue:self.pin forKey:kAgentsPin];
    [mutableDict setValue:self.contactperson forKey:kAgentsContactperson];
    [mutableDict setValue:self.country forKey:kAgentsCountry];
    [mutableDict setValue:self.email forKey:kAgentsEmail];

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

    self.agentid = [aDecoder decodeObjectForKey:kAgentsAgentid];
    self.address1 = [aDecoder decodeObjectForKey:kAgentsAddress1];
    self.faxno = [aDecoder decodeObjectForKey:kAgentsFaxno];
    self.agentcode = [aDecoder decodeObjectForKey:kAgentsAgentcode];
    self.address2 = [aDecoder decodeObjectForKey:kAgentsAddress2];
    self.company = [aDecoder decodeObjectForKey:kAgentsCompany];
    self.mobileno = [aDecoder decodeObjectForKey:kAgentsMobileno];
    self.city = [aDecoder decodeObjectForKey:kAgentsCity];
    self.phno = [aDecoder decodeObjectForKey:kAgentsPhno];
    self.pin = [aDecoder decodeObjectForKey:kAgentsPin];
    self.contactperson = [aDecoder decodeObjectForKey:kAgentsContactperson];
    self.country = [aDecoder decodeObjectForKey:kAgentsCountry];
    self.email = [aDecoder decodeObjectForKey:kAgentsEmail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_agentid forKey:kAgentsAgentid];
    [aCoder encodeObject:_address1 forKey:kAgentsAddress1];
    [aCoder encodeObject:_faxno forKey:kAgentsFaxno];
    [aCoder encodeObject:_agentcode forKey:kAgentsAgentcode];
    [aCoder encodeObject:_address2 forKey:kAgentsAddress2];
    [aCoder encodeObject:_company forKey:kAgentsCompany];
    [aCoder encodeObject:_mobileno forKey:kAgentsMobileno];
    [aCoder encodeObject:_city forKey:kAgentsCity];
    [aCoder encodeObject:_phno forKey:kAgentsPhno];
    [aCoder encodeObject:_pin forKey:kAgentsPin];
    [aCoder encodeObject:_contactperson forKey:kAgentsContactperson];
    [aCoder encodeObject:_country forKey:kAgentsCountry];
    [aCoder encodeObject:_email forKey:kAgentsEmail];
}


@end
