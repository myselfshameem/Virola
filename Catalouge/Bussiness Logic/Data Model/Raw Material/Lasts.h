//
//  Lasts.h
//
//  Created by iVend  on 8/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Lasts : NSObject <NSCoding>

@property (nonatomic, strong) NSString *lastid;
@property (nonatomic, strong) NSString *lastname;

+ (Lasts *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
