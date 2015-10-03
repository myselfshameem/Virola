//
//  ArticlesRawmaterials.h
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ArticlesRawmaterials : NSObject <NSCoding>

@property (nonatomic, strong) NSString *rawmaterialgroupid;
@property (nonatomic, strong) NSString *insraw;
@property (nonatomic, strong) NSString *leatherpriority;
@property (nonatomic, strong) NSString *colorid;
@property (nonatomic, strong) NSString *rawmaterialid;
@property (nonatomic, strong) NSString *rawmaterialname;
@property (nonatomic, strong) Colors   *colors;
+ (ArticlesRawmaterials *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
@end
