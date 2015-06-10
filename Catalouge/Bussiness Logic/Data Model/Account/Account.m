//
//  Account.m
//
//  Created by iVend  on 5/21/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Account.h"
#import "User.h"


NSString *const kAccountSuccess = @"success";
NSString *const kAccountMessage = @"message";
NSString *const kAccountErrorcode = @"errorcode";
NSString *const kAccountSessionId = @"session_id";
NSString *const kAccountUser = @"user";
NSString *const kAccountVersion = @"version";


@interface Account ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Account

@synthesize success = _success;
@synthesize message = _message;
@synthesize errorcode = _errorcode;
@synthesize sessionId = _sessionId;
@synthesize user = _user;
@synthesize version = _version;


+ (Account *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Account *instance = [[Account alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.success = [self objectOrNilForKey:kAccountSuccess fromDictionary:dict];
            self.message = [self objectOrNilForKey:kAccountMessage fromDictionary:dict];
            self.errorcode = [self objectOrNilForKey:kAccountErrorcode fromDictionary:dict];
            self.sessionId = [self objectOrNilForKey:kAccountSessionId fromDictionary:dict];
            self.user = [User modelObjectWithDictionary:[dict objectForKey:kAccountUser]];
            self.version = [self objectOrNilForKey:kAccountVersion fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.success forKey:kAccountSuccess];
    [mutableDict setValue:self.message forKey:kAccountMessage];
    [mutableDict setValue:self.errorcode forKey:kAccountErrorcode];
    [mutableDict setValue:self.sessionId forKey:kAccountSessionId];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kAccountUser];
    [mutableDict setValue:self.version forKey:kAccountVersion];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.success = [aDecoder decodeObjectForKey:kAccountSuccess];
    self.message = [aDecoder decodeObjectForKey:kAccountMessage];
    self.errorcode = [aDecoder decodeObjectForKey:kAccountErrorcode];
    self.sessionId = [aDecoder decodeObjectForKey:kAccountSessionId];
    self.user = [aDecoder decodeObjectForKey:kAccountUser];
    self.version = [aDecoder decodeObjectForKey:kAccountVersion];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_success forKey:kAccountSuccess];
    [aCoder encodeObject:_message forKey:kAccountMessage];
    [aCoder encodeObject:_errorcode forKey:kAccountErrorcode];
    [aCoder encodeObject:_sessionId forKey:kAccountSessionId];
    [aCoder encodeObject:_user forKey:kAccountUser];
    [aCoder encodeObject:_version forKey:kAccountVersion];
}


@end
