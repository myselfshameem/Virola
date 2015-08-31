//
//  Clients.h
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Clients : NSObject <NSCoding>

@property (nonatomic, strong) NSArray *agents;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *clientcode;
@property (nonatomic, strong) NSString *address1;
@property (nonatomic, strong) NSString *address2;
@property (nonatomic, strong) NSString *clientid;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *couriernumber;
@property (nonatomic, strong) NSString *couriername;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *clienttype;
@property (nonatomic, strong) NSString *contactperson;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *defaultAgentCode;
@property (nonatomic, strong) Agents *defaultAgent;

+ (Clients *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
