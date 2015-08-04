//
//  RawmaterialApiResponse.h
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RawmaterialApiResponse : NSObject <NSCoding>

@property (nonatomic, strong) NSString *success;
@property (nonatomic, strong) NSArray *rawmaterials;
@property (nonatomic, strong) NSArray *lasts;
@property (nonatomic, strong) NSString *errorcode;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *version;

+ (RawmaterialApiResponse *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
