//
//  Agents.h
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Agents : NSObject <NSCoding>

@property (nonatomic, strong) NSString *agentid;
@property (nonatomic, strong) NSString *address1;
@property (nonatomic, strong) NSString *faxno;
@property (nonatomic, strong) NSString *agentcode;
@property (nonatomic, strong) NSString *address2;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *mobileno;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *phno;
@property (nonatomic, strong) NSString *pin;
@property (nonatomic, strong) NSString *contactperson;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *clientid;
+ (Agents *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
