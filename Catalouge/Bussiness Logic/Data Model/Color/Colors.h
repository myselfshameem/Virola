//
//  Colors.h
//
//  Created by iVend  on 6/4/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Colors : NSObject <NSCoding>

@property (nonatomic, strong) NSString *colorid;
@property (nonatomic, strong) NSString *colorname;

+ (Colors *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
