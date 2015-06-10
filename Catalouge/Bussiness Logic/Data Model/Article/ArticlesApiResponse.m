//
//  ArticlesApiResponse.m
//
//  Created by iVend  on 5/30/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ArticlesApiResponse.h"
#import "Articles.h"


NSString *const kArticlesApiResponseSuccess = @"success";
NSString *const kArticlesApiResponseMessage = @"message";
NSString *const kArticlesApiResponseErrorcode = @"errorcode";
NSString *const kArticlesApiResponseArticles = @"articles";
NSString *const kArticlesApiResponseVersion = @"version";


@interface ArticlesApiResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ArticlesApiResponse

@synthesize success = _success;
@synthesize message = _message;
@synthesize errorcode = _errorcode;
@synthesize articles = _articles;
@synthesize version = _version;


+ (ArticlesApiResponse *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ArticlesApiResponse *instance = [[ArticlesApiResponse alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.success = [self objectOrNilForKey:kArticlesApiResponseSuccess fromDictionary:dict];
            self.message = [self objectOrNilForKey:kArticlesApiResponseMessage fromDictionary:dict];
            self.errorcode = [self objectOrNilForKey:kArticlesApiResponseErrorcode fromDictionary:dict];
    NSObject *receivedArticles = [dict objectForKey:kArticlesApiResponseArticles];
    NSMutableArray *parsedArticles = [NSMutableArray array];
    if ([receivedArticles isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedArticles) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedArticles addObject:[Articles modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedArticles isKindOfClass:[NSDictionary class]]) {
       [parsedArticles addObject:[Articles modelObjectWithDictionary:(NSDictionary *)receivedArticles]];
    }

    self.articles = [NSArray arrayWithArray:parsedArticles];
            self.version = [self objectOrNilForKey:kArticlesApiResponseVersion fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.success forKey:kArticlesApiResponseSuccess];
    [mutableDict setValue:self.message forKey:kArticlesApiResponseMessage];
    [mutableDict setValue:self.errorcode forKey:kArticlesApiResponseErrorcode];
NSMutableArray *tempArrayForArticles = [NSMutableArray array];
    for (NSObject *subArrayObject in self.articles) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForArticles addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForArticles addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForArticles] forKey:@"kArticlesApiResponseArticles"];
    [mutableDict setValue:self.version forKey:kArticlesApiResponseVersion];

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

    self.success = [aDecoder decodeObjectForKey:kArticlesApiResponseSuccess];
    self.message = [aDecoder decodeObjectForKey:kArticlesApiResponseMessage];
    self.errorcode = [aDecoder decodeObjectForKey:kArticlesApiResponseErrorcode];
    self.articles = [aDecoder decodeObjectForKey:kArticlesApiResponseArticles];
    self.version = [aDecoder decodeObjectForKey:kArticlesApiResponseVersion];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_success forKey:kArticlesApiResponseSuccess];
    [aCoder encodeObject:_message forKey:kArticlesApiResponseMessage];
    [aCoder encodeObject:_errorcode forKey:kArticlesApiResponseErrorcode];
    [aCoder encodeObject:_articles forKey:kArticlesApiResponseArticles];
    [aCoder encodeObject:_version forKey:kArticlesApiResponseVersion];
}


@end
