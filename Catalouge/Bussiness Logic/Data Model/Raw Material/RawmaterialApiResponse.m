//
//  RawmaterialApiResponse.m
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "RawmaterialApiResponse.h"
#import "Rawmaterials.h"
#import "Lasts.h"


NSString *const kRawmaterialApiResponseSuccess = @"success";
NSString *const kRawmaterialApiResponseRawmaterials = @"rawmaterials";
NSString *const kRawmaterialApiResponseLasts = @"lasts";
NSString *const kRawmaterialApiResponseErrorcode = @"errorcode";
NSString *const kRawmaterialApiResponseMessage = @"message";
NSString *const kRawmaterialApiResponseVersion = @"version";


@interface RawmaterialApiResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RawmaterialApiResponse

@synthesize success = _success;
@synthesize rawmaterials = _rawmaterials;
@synthesize lasts = _lasts;
@synthesize errorcode = _errorcode;
@synthesize message = _message;
@synthesize version = _version;


+ (RawmaterialApiResponse *)modelObjectWithDictionary:(NSDictionary *)dict
{
    RawmaterialApiResponse *instance = [[RawmaterialApiResponse alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.success = [self objectOrNilForKey:kRawmaterialApiResponseSuccess fromDictionary:dict];
    NSObject *receivedRawmaterials = [dict objectForKey:kRawmaterialApiResponseRawmaterials];
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
    NSObject *receivedLasts = [dict objectForKey:kRawmaterialApiResponseLasts];
    NSMutableArray *parsedLasts = [NSMutableArray array];
    if ([receivedLasts isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLasts) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLasts addObject:[Lasts modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLasts isKindOfClass:[NSDictionary class]]) {
       [parsedLasts addObject:[Lasts modelObjectWithDictionary:(NSDictionary *)receivedLasts]];
    }

    self.lasts = [NSArray arrayWithArray:parsedLasts];
            self.errorcode = [self objectOrNilForKey:kRawmaterialApiResponseErrorcode fromDictionary:dict];
            self.message = [self objectOrNilForKey:kRawmaterialApiResponseMessage fromDictionary:dict];
            self.version = [self objectOrNilForKey:kRawmaterialApiResponseVersion fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.success forKey:kRawmaterialApiResponseSuccess];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRawmaterials] forKey:@"kRawmaterialApiResponseRawmaterials"];
NSMutableArray *tempArrayForLasts = [NSMutableArray array];
    for (NSObject *subArrayObject in self.lasts) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForLasts addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForLasts addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForLasts] forKey:@"kRawmaterialApiResponseLasts"];
    [mutableDict setValue:self.errorcode forKey:kRawmaterialApiResponseErrorcode];
    [mutableDict setValue:self.message forKey:kRawmaterialApiResponseMessage];
    [mutableDict setValue:self.version forKey:kRawmaterialApiResponseVersion];

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

    self.success = [aDecoder decodeObjectForKey:kRawmaterialApiResponseSuccess];
    self.rawmaterials = [aDecoder decodeObjectForKey:kRawmaterialApiResponseRawmaterials];
    self.lasts = [aDecoder decodeObjectForKey:kRawmaterialApiResponseLasts];
    self.errorcode = [aDecoder decodeObjectForKey:kRawmaterialApiResponseErrorcode];
    self.message = [aDecoder decodeObjectForKey:kRawmaterialApiResponseMessage];
    self.version = [aDecoder decodeObjectForKey:kRawmaterialApiResponseVersion];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_success forKey:kRawmaterialApiResponseSuccess];
    [aCoder encodeObject:_rawmaterials forKey:kRawmaterialApiResponseRawmaterials];
    [aCoder encodeObject:_lasts forKey:kRawmaterialApiResponseLasts];
    [aCoder encodeObject:_errorcode forKey:kRawmaterialApiResponseErrorcode];
    [aCoder encodeObject:_message forKey:kRawmaterialApiResponseMessage];
    [aCoder encodeObject:_version forKey:kRawmaterialApiResponseVersion];
}


@end
