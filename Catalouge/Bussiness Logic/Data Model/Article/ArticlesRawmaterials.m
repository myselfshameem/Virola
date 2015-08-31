//
//  ArticlesRawmaterials.m
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ArticlesRawmaterials.h"


NSString *const kArticlesRawmaterialsRawmaterialgroupid = @"rawmaterialgroupid";
NSString *const kArticlesRawmaterialsInsraw = @"insraw";
NSString *const kArticlesRawmaterialsLeatherpriority = @"leatherpriority";
NSString *const kArticlesRawmaterialsColorid = @"colorid";
NSString *const kArticlesRawmaterialsRawmaterialid = @"rawmaterialid";


@interface ArticlesRawmaterials ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ArticlesRawmaterials

@synthesize rawmaterialgroupid = _rawmaterialgroupid;
@synthesize insraw = _insraw;
@synthesize leatherpriority = _leatherpriority;
@synthesize colorid = _colorid;
@synthesize rawmaterialid = _rawmaterialid;


+ (ArticlesRawmaterials *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ArticlesRawmaterials *instance = [[ArticlesRawmaterials alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.rawmaterialgroupid = [self objectOrNilForKey:kArticlesRawmaterialsRawmaterialgroupid fromDictionary:dict];
        self.insraw = [self objectOrNilForKey:kArticlesRawmaterialsInsraw fromDictionary:dict];
        self.leatherpriority = [self objectOrNilForKey:kArticlesRawmaterialsLeatherpriority fromDictionary:dict];
        self.colorid = [self objectOrNilForKey:kArticlesRawmaterialsColorid fromDictionary:dict];
        self.rawmaterialid = [self objectOrNilForKey:kArticlesRawmaterialsRawmaterialid fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.rawmaterialgroupid forKey:kArticlesRawmaterialsRawmaterialgroupid];
    [mutableDict setValue:self.insraw forKey:kArticlesRawmaterialsInsraw];
    [mutableDict setValue:self.leatherpriority forKey:kArticlesRawmaterialsLeatherpriority];
    [mutableDict setValue:self.colorid forKey:kArticlesRawmaterialsColorid];
    [mutableDict setValue:self.rawmaterialid forKey:kArticlesRawmaterialsRawmaterialid];
    
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
    
    self.rawmaterialgroupid = [aDecoder decodeObjectForKey:kArticlesRawmaterialsRawmaterialgroupid];
    self.insraw = [aDecoder decodeObjectForKey:kArticlesRawmaterialsInsraw];
    self.leatherpriority = [aDecoder decodeObjectForKey:kArticlesRawmaterialsLeatherpriority];
    self.colorid = [aDecoder decodeObjectForKey:kArticlesRawmaterialsColorid];
    self.rawmaterialid = [aDecoder decodeObjectForKey:kArticlesRawmaterialsRawmaterialid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_rawmaterialgroupid forKey:kArticlesRawmaterialsRawmaterialgroupid];
    [aCoder encodeObject:_insraw forKey:kArticlesRawmaterialsInsraw];
    [aCoder encodeObject:_leatherpriority forKey:kArticlesRawmaterialsLeatherpriority];
    [aCoder encodeObject:_colorid forKey:kArticlesRawmaterialsColorid];
    [aCoder encodeObject:_rawmaterialid forKey:kArticlesRawmaterialsRawmaterialid];
}
- (Colors*)colors{
    
    if (!_colors) {
        if ([[self colorid] length]) {
            NSArray *arr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:[NSString stringWithFormat:@"SELECT * FROM Colors WHERE colorid = '%@'",[self colorid]] asObject:[Colors class]];
            [arr count] ? _colors = [arr firstObject] : nil;
        }
    }
    return _colors;
}


@end
