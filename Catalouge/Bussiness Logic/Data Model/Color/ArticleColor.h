//
//  ArticleColor.h
//
//  Created by iVend  on 6/4/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ArticleColor : NSObject <NSCoding>

@property (nonatomic, strong) NSString *success;
@property (nonatomic, strong) NSString *errorcode;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *version;

+ (ArticleColor *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
