//
//  Rawmaterials.h
//
//  Created by iVend  on 5/30/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ArticlesRawmaterials : NSObject <NSCoding>


@property (nonatomic, strong) NSString *rawmaterialid;
@property (nonatomic, strong) NSString *rawmaterialgroupid;
@property (nonatomic, strong) NSString *leatherpriority;

+ (ArticlesRawmaterials *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
