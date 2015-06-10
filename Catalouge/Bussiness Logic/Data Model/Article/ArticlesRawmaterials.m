//
//  Rawmaterials.m
//
//  Created by iVend  on 5/30/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ArticlesRawmaterials.h"


NSString *const kRawmaterialsRawmaterialidArticle = @"rawmaterialid";
NSString *const kRawmaterialsRawmaterialgroupidArticle = @"rawmaterialgroupid";
NSString *const kRawmaterialsLeatherpriorityArticle = @"leatherpriority";


@interface ArticlesRawmaterials ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ArticlesRawmaterials

@synthesize rawmaterialid = _rawmaterialid;
@synthesize rawmaterialgroupid = _rawmaterialgroupid;
@synthesize leatherpriority = _leatherpriority;


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
            self.rawmaterialid = [self objectOrNilForKey:kRawmaterialsRawmaterialidArticle fromDictionary:dict];
            self.rawmaterialgroupid = [self objectOrNilForKey:kRawmaterialsRawmaterialgroupidArticle fromDictionary:dict];
            self.leatherpriority = [self objectOrNilForKey:kRawmaterialsLeatherpriorityArticle fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.rawmaterialid forKey:kRawmaterialsRawmaterialidArticle];
    [mutableDict setValue:self.rawmaterialgroupid forKey:kRawmaterialsRawmaterialgroupidArticle];
    [mutableDict setValue:self.leatherpriority forKey:kRawmaterialsLeatherpriorityArticle];

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

    self.rawmaterialid = [aDecoder decodeObjectForKey:kRawmaterialsRawmaterialidArticle];
    self.rawmaterialgroupid = [aDecoder decodeObjectForKey:kRawmaterialsRawmaterialgroupidArticle];
    self.leatherpriority = [aDecoder decodeObjectForKey:kRawmaterialsLeatherpriorityArticle];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_rawmaterialid forKey:kRawmaterialsRawmaterialidArticle];
    [aCoder encodeObject:_rawmaterialgroupid forKey:kRawmaterialsRawmaterialgroupidArticle];
    [aCoder encodeObject:_leatherpriority forKey:kRawmaterialsLeatherpriorityArticle];
}


@end
