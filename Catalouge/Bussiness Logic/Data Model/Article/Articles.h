//
//  Articles.h
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Articles : NSObject <NSCoding>

@property (nonatomic, strong) NSString *soleid;
@property (nonatomic, strong) NSString *artbuyerid;
@property (nonatomic, strong) NSString *lastid;
@property (nonatomic, strong) NSString *articlename;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *articleid;
@property (nonatomic, strong) NSString *sizeto;
@property (nonatomic, strong) NSArray *articlesRawmaterials;
@property (nonatomic, strong) NSString *mLC;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *sizefrom;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *soleName;
@property (nonatomic, strong) NSString *price_usd;
@property (nonatomic, strong) NSString *price_gbp;

+ (Articles *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
