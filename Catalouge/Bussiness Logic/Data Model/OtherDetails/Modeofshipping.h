//
//  Modeofshipping.h
//
//  Created by iVend  on 8/5/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Modeofshipping : NSObject <NSCoding>

@property (nonatomic, strong) NSString *shippingModeId;
@property (nonatomic, strong) NSString *shippingMode;

+ (Modeofshipping *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
