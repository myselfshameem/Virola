//
//  ClientsApiResponse.h
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ClientsApiResponse : NSObject <NSCoding>

@property (nonatomic, strong) NSString *success;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *errorcode;
@property (nonatomic, strong) NSArray *clients;
@property (nonatomic, strong) NSString *version;

+ (ClientsApiResponse *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
