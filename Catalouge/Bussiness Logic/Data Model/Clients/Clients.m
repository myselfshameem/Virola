//
//  Clients.m
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Clients.h"
#import "Agents.h"

NSString *const kClientsName = @"name";

NSString *const kClientsAgents = @"agents";
NSString *const kClientsClientcode = @"clientcode";
NSString *const kClientsAddress1 = @"address1";
NSString *const kClientsAddress2 = @"address2";
NSString *const kClientsClientid = @"clientid";
NSString *const kClientsCompany = @"company";
NSString *const kClientsCouriernumber = @"couriernumber";
NSString *const kClientsCouriername = @"couriername";
NSString *const kClientsCity = @"city";
NSString *const kClientsClienttype = @"clienttype";
NSString *const kClientsContactperson = @"contactperson";
NSString *const kClientsCountry = @"country";


@interface Clients ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Clients

@synthesize agents = _agents;
@synthesize clientcode = _clientcode;
@synthesize address1 = _address1;
@synthesize address2 = _address2;
@synthesize clientid = _clientid;
@synthesize company = _company;
@synthesize couriernumber = _couriernumber;
@synthesize couriername = _couriername;
@synthesize city = _city;
@synthesize clienttype = _clienttype;
@synthesize contactperson = _contactperson;
@synthesize country = _country;
@synthesize name = _name;

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
    NSObject *receivedAgents = [dict objectForKey:kClientsAgents];
    NSMutableArray *parsedAgents = [NSMutableArray array];
    if ([receivedAgents isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedAgents) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedAgents addObject:[Agents modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedAgents isKindOfClass:[NSDictionary class]]) {
       [parsedAgents addObject:[Agents modelObjectWithDictionary:(NSDictionary *)receivedAgents]];
    }

    self.agents = [NSArray arrayWithArray:parsedAgents];
            self.clientcode = [self objectOrNilForKey:kClientsClientcode fromDictionary:dict];
            self.address1 = [self objectOrNilForKey:kClientsAddress1 fromDictionary:dict];
            self.address2 = [self objectOrNilForKey:kClientsAddress2 fromDictionary:dict];
            self.clientid = [self objectOrNilForKey:kClientsClientid fromDictionary:dict];
            self.company = [self objectOrNilForKey:kClientsCompany fromDictionary:dict];
            self.couriernumber = [self objectOrNilForKey:kClientsCouriernumber fromDictionary:dict];
            self.couriername = [self objectOrNilForKey:kClientsCouriername fromDictionary:dict];
            self.city = [self objectOrNilForKey:kClientsCity fromDictionary:dict];
            self.clienttype = [self objectOrNilForKey:kClientsClienttype fromDictionary:dict];
            self.contactperson = [self objectOrNilForKey:kClientsContactperson fromDictionary:dict];
            self.country = [self objectOrNilForKey:kClientsCountry fromDictionary:dict];
            self.name = [self objectOrNilForKey:kClientsName fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForAgents = [NSMutableArray array];
    for (NSObject *subArrayObject in self.agents) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAgents addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAgents addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAgents] forKey:@"kClientsAgents"];
    [mutableDict setValue:self.clientcode forKey:kClientsClientcode];
    [mutableDict setValue:self.address1 forKey:kClientsAddress1];
    [mutableDict setValue:self.address2 forKey:kClientsAddress2];
    [mutableDict setValue:self.clientid forKey:kClientsClientid];
    [mutableDict setValue:self.company forKey:kClientsCompany];
    [mutableDict setValue:self.couriernumber forKey:kClientsCouriernumber];
    [mutableDict setValue:self.couriername forKey:kClientsCouriername];
    [mutableDict setValue:self.city forKey:kClientsCity];
    [mutableDict setValue:self.clienttype forKey:kClientsClienttype];
    [mutableDict setValue:self.contactperson forKey:kClientsContactperson];
    [mutableDict setValue:self.country forKey:kClientsCountry];
    [mutableDict setValue:self.name forKey:kClientsName];

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

    self.agents = [aDecoder decodeObjectForKey:kClientsAgents];
    self.clientcode = [aDecoder decodeObjectForKey:kClientsClientcode];
    self.address1 = [aDecoder decodeObjectForKey:kClientsAddress1];
    self.address2 = [aDecoder decodeObjectForKey:kClientsAddress2];
    self.clientid = [aDecoder decodeObjectForKey:kClientsClientid];
    self.company = [aDecoder decodeObjectForKey:kClientsCompany];
    self.couriernumber = [aDecoder decodeObjectForKey:kClientsCouriernumber];
    self.couriername = [aDecoder decodeObjectForKey:kClientsCouriername];
    self.city = [aDecoder decodeObjectForKey:kClientsCity];
    self.clienttype = [aDecoder decodeObjectForKey:kClientsClienttype];
    self.contactperson = [aDecoder decodeObjectForKey:kClientsContactperson];
    self.country = [aDecoder decodeObjectForKey:kClientsCountry];
    self.name = [aDecoder decodeObjectForKey:kClientsName];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_agents forKey:kClientsAgents];
    [aCoder encodeObject:_clientcode forKey:kClientsClientcode];
    [aCoder encodeObject:_address1 forKey:kClientsAddress1];
    [aCoder encodeObject:_address2 forKey:kClientsAddress2];
    [aCoder encodeObject:_clientid forKey:kClientsClientid];
    [aCoder encodeObject:_company forKey:kClientsCompany];
    [aCoder encodeObject:_couriernumber forKey:kClientsCouriernumber];
    [aCoder encodeObject:_couriername forKey:kClientsCouriername];
    [aCoder encodeObject:_city forKey:kClientsCity];
    [aCoder encodeObject:_clienttype forKey:kClientsClienttype];
    [aCoder encodeObject:_contactperson forKey:kClientsContactperson];
    [aCoder encodeObject:_country forKey:kClientsCountry];
    [aCoder encodeObject:_name forKey:kClientsName];

}

- (NSArray*)agents{

    if (!_agents) {
        _agents = [[CXSSqliteHelper sharedSqliteHelper] runQuery:[NSString stringWithFormat:@"SELECT * FROM Agents_Master Where clientid = '%@'",self.clientid] asObject:[Agents class]];
    }

    return _agents;
}

- (Agents*)defaultAgent{
    
    if (!_defaultAgent) {
        
        NSArray *arr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:[NSString stringWithFormat:@"SELECT * FROM Agents_Master Where clientid = '%@'",self.clientid] asObject:[Agents class]];
        [arr count] ? (_defaultAgent = [arr firstObject]) : nil;
    }
    
    return _defaultAgent;
}
@end
