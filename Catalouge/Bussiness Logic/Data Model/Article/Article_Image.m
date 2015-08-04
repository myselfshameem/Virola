//
//  Images.m
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Article_Image.h"


NSString *const kImagesImagePath = @"image_path";


@interface Article_Image ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Article_Image

@synthesize imagePath = _imagePath;


+ (Article_Image *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Article_Image *instance = [[Article_Image alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.imagePath = [self objectOrNilForKey:kImagesImagePath fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imagePath forKey:kImagesImagePath];
    
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
    
    self.imagePath = [aDecoder decodeObjectForKey:kImagesImagePath];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_imagePath forKey:kImagesImagePath];
}


@end
