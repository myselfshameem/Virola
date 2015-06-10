//
//  Trx_Rawmaterials.h
//
//  Created by iVend  on 6/6/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Trx_Rawmaterials : NSObject <NSCoding>

@property (nonatomic, strong) NSString *rawmaterialgroupid;
@property (nonatomic, strong) NSString *colorid;
@property (nonatomic, strong) NSString *leatherpriority;
@property (nonatomic, strong) NSString *rawmaterialid;

+ (Trx_Rawmaterials *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
