//
//  ArticleColor.m
//
//  Created by iVend  on 6/4/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ArticleColor.h"
#import "Colors.h"


NSString *const kArticleColorSuccess = @"success";
NSString *const kArticleColorErrorcode = @"errorcode";
NSString *const kArticleColorColors = @"colors";
NSString *const kArticleColorMessage = @"message";
NSString *const kArticleColorVersion = @"version";


@interface ArticleColor ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ArticleColor

@synthesize success = _success;
@synthesize errorcode = _errorcode;
@synthesize colors = _colors;
@synthesize message = _message;
@synthesize version = _version;


+ (ArticleColor *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ArticleColor *instance = [[ArticleColor alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.success = [self objectOrNilForKey:kArticleColorSuccess fromDictionary:dict];
            self.errorcode = [self objectOrNilForKey:kArticleColorErrorcode fromDictionary:dict];
    NSObject *receivedColors = [dict objectForKey:kArticleColorColors];
    NSMutableArray *parsedColors = [NSMutableArray array];
    if ([receivedColors isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedColors) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedColors addObject:[Colors modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedColors isKindOfClass:[NSDictionary class]]) {
       [parsedColors addObject:[Colors modelObjectWithDictionary:(NSDictionary *)receivedColors]];
    }

    self.colors = [NSArray arrayWithArray:parsedColors];
            self.message = [self objectOrNilForKey:kArticleColorMessage fromDictionary:dict];
            self.version = [self objectOrNilForKey:kArticleColorVersion fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.success forKey:kArticleColorSuccess];
    [mutableDict setValue:self.errorcode forKey:kArticleColorErrorcode];
NSMutableArray *tempArrayForColors = [NSMutableArray array];
    for (NSObject *subArrayObject in self.colors) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForColors addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForColors addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForColors] forKey:@"kArticleColorColors"];
    [mutableDict setValue:self.message forKey:kArticleColorMessage];
    [mutableDict setValue:self.version forKey:kArticleColorVersion];

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

    self.success = [aDecoder decodeObjectForKey:kArticleColorSuccess];
    self.errorcode = [aDecoder decodeObjectForKey:kArticleColorErrorcode];
    self.colors = [aDecoder decodeObjectForKey:kArticleColorColors];
    self.message = [aDecoder decodeObjectForKey:kArticleColorMessage];
    self.version = [aDecoder decodeObjectForKey:kArticleColorVersion];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_success forKey:kArticleColorSuccess];
    [aCoder encodeObject:_errorcode forKey:kArticleColorErrorcode];
    [aCoder encodeObject:_colors forKey:kArticleColorColors];
    [aCoder encodeObject:_message forKey:kArticleColorMessage];
    [aCoder encodeObject:_version forKey:kArticleColorVersion];
}


@end
