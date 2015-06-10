//
//  Colors.m
//
//  Created by iVend  on 6/4/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Colors.h"


NSString *const kColorsColorid = @"colorid";
NSString *const kColorsColorname = @"colorname";


@interface Colors ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Colors

@synthesize colorid = _colorid;
@synthesize colorname = _colorname;


+ (Colors *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Colors *instance = [[Colors alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.colorid = [self objectOrNilForKey:kColorsColorid fromDictionary:dict];
            self.colorname = [self objectOrNilForKey:kColorsColorname fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.colorid forKey:kColorsColorid];
    [mutableDict setValue:self.colorname forKey:kColorsColorname];

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

    self.colorid = [aDecoder decodeObjectForKey:kColorsColorid];
    self.colorname = [aDecoder decodeObjectForKey:kColorsColorname];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_colorid forKey:kColorsColorid];
    [aCoder encodeObject:_colorname forKey:kColorsColorname];
}


@end
