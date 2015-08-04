//
//  Articles.m
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Articles.h"
#import "Rawmaterials.h"


NSString *const kArticlesSoleid = @"soleid";
NSString *const kArticlesArtbuyerid = @"artbuyerid";
NSString *const kArticlesLastid = @"lastid";
NSString *const kArticlesArticlename = @"articlename";
NSString *const kArticlesPrice = @"price";
NSString *const kArticlesArticleid = @"articleid";
NSString *const kArticlesSizeto = @"sizeto";
NSString *const kArticlesRawmaterials = @"rawmaterials";
NSString *const kArticlesMLC = @"m_l_c";
NSString *const kArticlesImages = @"images";
NSString *const kArticlesSizefrom = @"sizefrom";


@interface Articles ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Articles

@synthesize soleid = _soleid;
@synthesize artbuyerid = _artbuyerid;
@synthesize lastid = _lastid;
@synthesize articlename = _articlename;
@synthesize price = _price;
@synthesize articleid = _articleid;
@synthesize sizeto = _sizeto;
@synthesize rawmaterials = _rawmaterials;
@synthesize mLC = _mLC;
@synthesize images = _images;
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
        self.soleid = [self objectOrNilForKey:kArticlesSoleid fromDictionary:dict];
        self.artbuyerid = [self objectOrNilForKey:kArticlesArtbuyerid fromDictionary:dict];
        self.lastid = [self objectOrNilForKey:kArticlesLastid fromDictionary:dict];
        self.articlename = [self objectOrNilForKey:kArticlesArticlename fromDictionary:dict];
        self.price = [self objectOrNilForKey:kArticlesPrice fromDictionary:dict];
        self.articleid = [self objectOrNilForKey:kArticlesArticleid fromDictionary:dict];
        self.sizeto = [self objectOrNilForKey:kArticlesSizeto fromDictionary:dict];
        NSObject *receivedRawmaterials = [dict objectForKey:kArticlesRawmaterials];
        NSMutableArray *parsedRawmaterials = [NSMutableArray array];
        if ([receivedRawmaterials isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedRawmaterials) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedRawmaterials addObject:[Rawmaterials modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedRawmaterials isKindOfClass:[NSDictionary class]]) {
            [parsedRawmaterials addObject:[Rawmaterials modelObjectWithDictionary:(NSDictionary *)receivedRawmaterials]];
        }
        
        self.rawmaterials = [NSArray arrayWithArray:parsedRawmaterials];
        self.mLC = [self objectOrNilForKey:kArticlesMLC fromDictionary:dict];
        self.images = [self objectOrNilForKey:kArticlesImages fromDictionary:dict];
        self.sizefrom = [self objectOrNilForKey:kArticlesSizefrom fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.soleid forKey:kArticlesSoleid];
    [mutableDict setValue:self.artbuyerid forKey:kArticlesArtbuyerid];
    [mutableDict setValue:self.lastid forKey:kArticlesLastid];
    [mutableDict setValue:self.articlename forKey:kArticlesArticlename];
    [mutableDict setValue:self.price forKey:kArticlesPrice];
    [mutableDict setValue:self.articleid forKey:kArticlesArticleid];
    [mutableDict setValue:self.sizeto forKey:kArticlesSizeto];
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
    [mutableDict setValue:self.mLC forKey:kArticlesMLC];
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


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.soleid = [aDecoder decodeObjectForKey:kArticlesSoleid];
    self.artbuyerid = [aDecoder decodeObjectForKey:kArticlesArtbuyerid];
    self.lastid = [aDecoder decodeObjectForKey:kArticlesLastid];
    self.articlename = [aDecoder decodeObjectForKey:kArticlesArticlename];
    self.price = [aDecoder decodeObjectForKey:kArticlesPrice];
    self.articleid = [aDecoder decodeObjectForKey:kArticlesArticleid];
    self.sizeto = [aDecoder decodeObjectForKey:kArticlesSizeto];
    self.rawmaterials = [aDecoder decodeObjectForKey:kArticlesRawmaterials];
    self.mLC = [aDecoder decodeObjectForKey:kArticlesMLC];
    self.images = [aDecoder decodeObjectForKey:kArticlesImages];
    self.sizefrom = [aDecoder decodeObjectForKey:kArticlesSizefrom];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_soleid forKey:kArticlesSoleid];
    [aCoder encodeObject:_artbuyerid forKey:kArticlesArtbuyerid];
    [aCoder encodeObject:_lastid forKey:kArticlesLastid];
    [aCoder encodeObject:_articlename forKey:kArticlesArticlename];
    [aCoder encodeObject:_price forKey:kArticlesPrice];
    [aCoder encodeObject:_articleid forKey:kArticlesArticleid];
    [aCoder encodeObject:_sizeto forKey:kArticlesSizeto];
    [aCoder encodeObject:_rawmaterials forKey:kArticlesRawmaterials];
    [aCoder encodeObject:_mLC forKey:kArticlesMLC];
    [aCoder encodeObject:_images forKey:kArticlesImages];
    [aCoder encodeObject:_sizefrom forKey:kArticlesSizefrom];
}

- (NSArray*)images{

    if (!_images)
        _images = [[CXSSqliteHelper sharedSqliteHelper] runQuery:@"SELECT * FROM Article_Image WHERE %@" asObject:[Article_Image class]];

    return _images;
}
@end
