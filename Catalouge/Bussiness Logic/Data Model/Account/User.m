//
//  User.m
//
//  Created by iVend  on 5/21/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "User.h"


NSString *const kUserEmail = @"email";
NSString *const kUserUsername = @"username";
NSString *const kUserUserId = @"user_id";
NSString *const kUserName = @"name";
NSString *const kUserContactNumber = @"contact_number";


@interface User ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation User

@synthesize email = _email;
@synthesize username = _username;
@synthesize userId = _userId;
@synthesize name = _name;
@synthesize contactNumber = _contactNumber;


+ (User *)modelObjectWithDictionary:(NSDictionary *)dict
{
    User *instance = [[User alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.email = [self objectOrNilForKey:kUserEmail fromDictionary:dict];
            self.username = [self objectOrNilForKey:kUserUsername fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kUserUserId fromDictionary:dict];
            self.name = [self objectOrNilForKey:kUserName fromDictionary:dict];
            self.contactNumber = [self objectOrNilForKey:kUserContactNumber fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.email forKey:kUserEmail];
    [mutableDict setValue:self.username forKey:kUserUsername];
    [mutableDict setValue:self.userId forKey:kUserUserId];
    [mutableDict setValue:self.name forKey:kUserName];
    [mutableDict setValue:self.contactNumber forKey:kUserContactNumber];

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

    self.email = [aDecoder decodeObjectForKey:kUserEmail];
    self.username = [aDecoder decodeObjectForKey:kUserUsername];
    self.userId = [aDecoder decodeObjectForKey:kUserUserId];
    self.name = [aDecoder decodeObjectForKey:kUserName];
    self.contactNumber = [aDecoder decodeObjectForKey:kUserContactNumber];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_email forKey:kUserEmail];
    [aCoder encodeObject:_username forKey:kUserUsername];
    [aCoder encodeObject:_userId forKey:kUserUserId];
    [aCoder encodeObject:_name forKey:kUserName];
    [aCoder encodeObject:_contactNumber forKey:kUserContactNumber];
}


@end
