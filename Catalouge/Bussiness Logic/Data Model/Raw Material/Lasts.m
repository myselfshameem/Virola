//
//  Lasts.m
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Lasts.h"


NSString *const kLastsLastid = @"lastid";
NSString *const kLastsLastname = @"lastname";


@interface Lasts ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Lasts

@synthesize lastid = _lastid;
@synthesize lastname = _lastname;


+ (Lasts *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Lasts *instance = [[Lasts alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.lastid = [self objectOrNilForKey:kLastsLastid fromDictionary:dict];
            self.lastname = [self objectOrNilForKey:kLastsLastname fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.lastid forKey:kLastsLastid];
    [mutableDict setValue:self.lastname forKey:kLastsLastname];

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

    self.lastid = [aDecoder decodeObjectForKey:kLastsLastid];
    self.lastname = [aDecoder decodeObjectForKey:kLastsLastname];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_lastid forKey:kLastsLastid];
    [aCoder encodeObject:_lastname forKey:kLastsLastname];
}


@end
