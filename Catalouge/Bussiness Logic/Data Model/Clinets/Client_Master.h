//
//  Client_Master.h
//
//  Created by iVend  on 6/5/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Client_Master : NSObject <NSCoding>

@property (nonatomic, strong) NSString *success;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *errorcode;
@property (nonatomic, strong) NSArray *clients;
@property (nonatomic, strong) NSString *version;

+ (Client_Master *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
