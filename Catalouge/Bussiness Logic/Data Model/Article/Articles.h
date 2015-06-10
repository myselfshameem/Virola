//
//  Articles.h
//
//  Created by iVend  on 5/30/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Article_Image;
@interface Articles : NSObject <NSCoding>

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *sizeto;
@property (nonatomic, strong) NSString *articlename;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSArray *rawmaterials;
@property (nonatomic, strong) NSString *articleid;
@property (nonatomic, strong) NSString *mLC;
@property (nonatomic, strong) NSString *sizefrom;
@property (nonatomic, strong) Article_Image *image;














+ (Articles *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
