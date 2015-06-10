//
//  Trx_Rawmaterials.m
//
//  Created by iVend  on 6/6/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Trx_Rawmaterials.h"


NSString *const kTrx_RawmaterialsRawmaterialgroupid = @"rawmaterialgroupid";
NSString *const kTrx_RawmaterialsColorid = @"colorid";
NSString *const kTrx_RawmaterialsLeatherpriority = @"leatherpriority";
NSString *const kTrx_RawmaterialsRawmaterialid = @"rawmaterialid";


@interface Trx_Rawmaterials ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Trx_Rawmaterials

@synthesize rawmaterialgroupid = _rawmaterialgroupid;
@synthesize colorid = _colorid;
@synthesize leatherpriority = _leatherpriority;
@synthesize rawmaterialid = _rawmaterialid;


+ (Trx_Rawmaterials *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Trx_Rawmaterials *instance = [[Trx_Rawmaterials alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.rawmaterialgroupid = [self objectOrNilForKey:kTrx_RawmaterialsRawmaterialgroupid fromDictionary:dict];
            self.colorid = [self objectOrNilForKey:kTrx_RawmaterialsColorid fromDictionary:dict];
            self.leatherpriority = [self objectOrNilForKey:kTrx_RawmaterialsLeatherpriority fromDictionary:dict];
            self.rawmaterialid = [self objectOrNilForKey:kTrx_RawmaterialsRawmaterialid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.rawmaterialgroupid forKey:kTrx_RawmaterialsRawmaterialgroupid];
    [mutableDict setValue:self.colorid forKey:kTrx_RawmaterialsColorid];
    [mutableDict setValue:self.leatherpriority forKey:kTrx_RawmaterialsLeatherpriority];
    [mutableDict setValue:self.rawmaterialid forKey:kTrx_RawmaterialsRawmaterialid];

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

    self.rawmaterialgroupid = [aDecoder decodeObjectForKey:kTrx_RawmaterialsRawmaterialgroupid];
    self.colorid = [aDecoder decodeObjectForKey:kTrx_RawmaterialsColorid];
    self.leatherpriority = [aDecoder decodeObjectForKey:kTrx_RawmaterialsLeatherpriority];
    self.rawmaterialid = [aDecoder decodeObjectForKey:kTrx_RawmaterialsRawmaterialid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_rawmaterialgroupid forKey:kTrx_RawmaterialsRawmaterialgroupid];
    [aCoder encodeObject:_colorid forKey:kTrx_RawmaterialsColorid];
    [aCoder encodeObject:_leatherpriority forKey:kTrx_RawmaterialsLeatherpriority];
    [aCoder encodeObject:_rawmaterialid forKey:kTrx_RawmaterialsRawmaterialid];
}


@end
