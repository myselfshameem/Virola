//
//  Rawmaterials.m
//
//  Created by iVend  on 5/24/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Rawmaterials.h"


NSString *const kRawmaterialsRawmaterialgroupid = @"rawmaterialgroupid";
NSString *const kRawmaterialsColorid = @"colorid";
NSString *const kRawmaterialsName = @"name";
NSString *const kRawmaterialsRawmaterialid = @"rawmaterialid";


@interface Rawmaterials ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Rawmaterials

@synthesize rawmaterialgroupid = _rawmaterialgroupid;
@synthesize colorid = _colorid;
@synthesize name = _name;
@synthesize rawmaterialid = _rawmaterialid;


+ (Rawmaterials *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Rawmaterials *instance = [[Rawmaterials alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.rawmaterialgroupid = [self objectOrNilForKey:kRawmaterialsRawmaterialgroupid fromDictionary:dict];
            self.colorid = [self objectOrNilForKey:kRawmaterialsColorid fromDictionary:dict];
            self.name = [self objectOrNilForKey:kRawmaterialsName fromDictionary:dict];
            self.rawmaterialid = [self objectOrNilForKey:kRawmaterialsRawmaterialid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.rawmaterialgroupid forKey:kRawmaterialsRawmaterialgroupid];
    [mutableDict setValue:self.colorid forKey:kRawmaterialsColorid];
    [mutableDict setValue:self.name forKey:kRawmaterialsName];
    [mutableDict setValue:self.rawmaterialid forKey:kRawmaterialsRawmaterialid];

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

    self.rawmaterialgroupid = [aDecoder decodeObjectForKey:kRawmaterialsRawmaterialgroupid];
    self.colorid = [aDecoder decodeObjectForKey:kRawmaterialsColorid];
    self.name = [aDecoder decodeObjectForKey:kRawmaterialsName];
    self.rawmaterialid = [aDecoder decodeObjectForKey:kRawmaterialsRawmaterialid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_rawmaterialgroupid forKey:kRawmaterialsRawmaterialgroupid];
    [aCoder encodeObject:_colorid forKey:kRawmaterialsColorid];
    [aCoder encodeObject:_name forKey:kRawmaterialsName];
    [aCoder encodeObject:_rawmaterialid forKey:kRawmaterialsRawmaterialid];
}

- (Colors*)colors{
    
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM Colors WHERE colorid = '%@'",_colorid];
        NSArray *arr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[Colors class]];
        _colors = [arr count] ? [arr firstObject] : nil;
    return _colors;
}
@end
