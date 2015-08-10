//
//  ShippingTerms.h
//
//  Created by iVend  on 8/5/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ShippingTerms : NSObject <NSCoding>

@property (nonatomic, strong) NSString *shippingTerm;
@property (nonatomic, strong) NSString *shippingTermId;

+ (ShippingTerms *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
