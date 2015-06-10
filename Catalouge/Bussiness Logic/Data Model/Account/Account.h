//
//  Account.h
//
//  Created by iVend  on 5/21/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface Account : NSObject <NSCoding>

@property (nonatomic, strong) NSString *success;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *errorcode;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *version;

+ (Account *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
