//
//  GetOrdersApiResponse.h
//
//  Created by iVend  on 8/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GetOrdersApiResponse : NSObject <NSCoding>

@property (nonatomic, strong) NSString *success;
@property (nonatomic, strong) NSArray *orders;
@property (nonatomic, strong) NSString *errorcode;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *version;

+ (GetOrdersApiResponse *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
