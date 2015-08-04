//
//  Rawmaterials.h
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Colors;
@interface Rawmaterials : NSObject <NSCoding>

@property (nonatomic, strong) NSString *rawmaterialgroupid;
@property (nonatomic, strong) NSString *abbrname;
@property (nonatomic, strong) NSString *colorid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *rawmaterialid;
@property (nonatomic, strong) Colors *colors;
+ (Rawmaterials *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
