//
//  Rawmaterials2.m
//
//  Created by iVend  on 5/24/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "RawmaterialApiResponse.h"
#import "Rawmaterials.h"


NSString *const kRawmaterials2Success = @"success";
NSString *const kRawmaterials2Rawmaterials = @"rawmaterials";
NSString *const kRawmaterials2Errorcode = @"errorcode";
NSString *const kRawmaterials2Message = @"message";
NSString *const kRawmaterials2Version = @"version";


@interface RawmaterialApiResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RawmaterialApiResponse

@synthesize success = _success;
@synthesize rawmaterials = _rawmaterials;
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
            self.success = [self objectOrNilForKey:kRawmaterials2Success fromDictionary:dict];
    NSObject *receivedRawmaterials = [dict objectForKey:kRawmaterials2Rawmaterials];
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
            self.errorcode = [self objectOrNilForKey:kRawmaterials2Errorcode fromDictionary:dict];
            self.message = [self objectOrNilForKey:kRawmaterials2Message fromDictionary:dict];
            self.version = [self objectOrNilForKey:kRawmaterials2Version fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.success forKey:kRawmaterials2Success];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRawmaterials] forKey:@"kRawmaterials2Rawmaterials"];
    [mutableDict setValue:self.errorcode forKey:kRawmaterials2Errorcode];
    [mutableDict setValue:self.message forKey:kRawmaterials2Message];
    [mutableDict setValue:self.version forKey:kRawmaterials2Version];

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

    self.success = [aDecoder decodeObjectForKey:kRawmaterials2Success];
    self.rawmaterials = [aDecoder decodeObjectForKey:kRawmaterials2Rawmaterials];
    self.errorcode = [aDecoder decodeObjectForKey:kRawmaterials2Errorcode];
    self.message = [aDecoder decodeObjectForKey:kRawmaterials2Message];
    self.version = [aDecoder decodeObjectForKey:kRawmaterials2Version];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_success forKey:kRawmaterials2Success];
    [aCoder encodeObject:_rawmaterials forKey:kRawmaterials2Rawmaterials];
    [aCoder encodeObject:_errorcode forKey:kRawmaterials2Errorcode];
    [aCoder encodeObject:_message forKey:kRawmaterials2Message];
    [aCoder encodeObject:_version forKey:kRawmaterials2Version];
}


@end
