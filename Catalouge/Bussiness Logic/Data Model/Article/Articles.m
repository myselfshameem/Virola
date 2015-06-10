//
//  Articles.m
//
//  Created by iVend  on 5/30/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Articles.h"
#import "ArticlesRawmaterials.h"


NSString *const kArticlesImages = @"images";
NSString *const kArticlesSizeto = @"sizeto";
NSString *const kArticlesArticlename = @"articlename";
NSString *const kArticlesPrice = @"price";
NSString *const kArticlesRawmaterials = @"rawmaterials";
NSString *const kArticlesArticleid = @"articleid";
NSString *const kArticlesMLC = @"m_l_c";
NSString *const kArticlesSizefrom = @"sizefrom";


@interface Articles ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Articles

@synthesize images = _images;
@synthesize sizeto = _sizeto;
@synthesize articlename = _articlename;
@synthesize price = _price;
@synthesize rawmaterials = _rawmaterials;
@synthesize articleid = _articleid;
@synthesize mLC = _mLC;
@synthesize sizefrom = _sizefrom;


+ (Articles *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Articles *instance = [[Articles alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.images = [self objectOrNilForKey:kArticlesImages fromDictionary:dict];
            self.sizeto = [self objectOrNilForKey:kArticlesSizeto fromDictionary:dict];
            self.articlename = [self objectOrNilForKey:kArticlesArticlename fromDictionary:dict];
            self.price = [self objectOrNilForKey:kArticlesPrice fromDictionary:dict];
    NSObject *receivedRawmaterials = [dict objectForKey:kArticlesRawmaterials];
    NSMutableArray *parsedRawmaterials = [NSMutableArray array];
    if ([receivedRawmaterials isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedRawmaterials) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedRawmaterials addObject:[ArticlesRawmaterials modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedRawmaterials isKindOfClass:[NSDictionary class]]) {
       [parsedRawmaterials addObject:[ArticlesRawmaterials modelObjectWithDictionary:(NSDictionary *)receivedRawmaterials]];
    }

    self.rawmaterials = [NSArray arrayWithArray:parsedRawmaterials];
            self.articleid = [self objectOrNilForKey:kArticlesArticleid fromDictionary:dict];
            self.mLC = [self objectOrNilForKey:kArticlesMLC fromDictionary:dict];
            self.sizefrom = [self objectOrNilForKey:kArticlesSizefrom fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForImages = [NSMutableArray array];
    for (NSObject *subArrayObject in self.images) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImages addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImages addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImages] forKey:@"kArticlesImages"];
    [mutableDict setValue:self.sizeto forKey:kArticlesSizeto];
    [mutableDict setValue:self.articlename forKey:kArticlesArticlename];
    [mutableDict setValue:self.price forKey:kArticlesPrice];
NSMutableArray *tempArrayForRawmaterials = [NSMutableArray array];
    for (NSObject *subArrayObject in self.rawmaterials) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRawmaterials addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRawmaterials addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRawmaterials] forKey:@"kArticlesRawmaterials"];
    [mutableDict setValue:self.articleid forKey:kArticlesArticleid];
    [mutableDict setValue:self.mLC forKey:kArticlesMLC];
    [mutableDict setValue:self.sizefrom forKey:kArticlesSizefrom];

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

- (NSArray*)rawmaterials{

    if (!_rawmaterials) {
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM Article_Rawmaterials WHERE articleid = '%@'",self.articleid];
        _rawmaterials = [[CXSSqliteHelper sharedSqliteHelper] runQuery:query asObject:[ArticlesRawmaterials class]];
    }
    return  _rawmaterials;
}
#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.images = [aDecoder decodeObjectForKey:kArticlesImages];
    self.sizeto = [aDecoder decodeObjectForKey:kArticlesSizeto];
    self.articlename = [aDecoder decodeObjectForKey:kArticlesArticlename];
    self.price = [aDecoder decodeObjectForKey:kArticlesPrice];
    self.rawmaterials = [aDecoder decodeObjectForKey:kArticlesRawmaterials];
    self.articleid = [aDecoder decodeObjectForKey:kArticlesArticleid];
    self.mLC = [aDecoder decodeObjectForKey:kArticlesMLC];
    self.sizefrom = [aDecoder decodeObjectForKey:kArticlesSizefrom];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_images forKey:kArticlesImages];
    [aCoder encodeObject:_sizeto forKey:kArticlesSizeto];
    [aCoder encodeObject:_articlename forKey:kArticlesArticlename];
    [aCoder encodeObject:_price forKey:kArticlesPrice];
    [aCoder encodeObject:_rawmaterials forKey:kArticlesRawmaterials];
    [aCoder encodeObject:_articleid forKey:kArticlesArticleid];
    [aCoder encodeObject:_mLC forKey:kArticlesMLC];
    [aCoder encodeObject:_sizefrom forKey:kArticlesSizefrom];
}

- (Article_Image*)image{


    NSArray *arr = [[CXSSqliteHelper sharedSqliteHelper] runQuery:[NSString stringWithFormat:@"SELECT * FROM Article_Images WHERE articleid = '%@' LIMIT 1",self.articleid] asObject:[Article_Image class]];
    
    Article_Image *image = nil;
    if ([arr count]) {
        image = [arr firstObject];
    }
    
    return image;
}
@end
