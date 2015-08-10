//
//  PaymentTerms.h
//
//  Created by iVend  on 8/5/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PaymentTerms : NSObject <NSCoding>

@property (nonatomic, strong) NSString *paymentTermId;
@property (nonatomic, strong) NSArray *paymentTermRemarks;
@property (nonatomic, strong) NSString *paymentTerm;

+ (PaymentTerms *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
