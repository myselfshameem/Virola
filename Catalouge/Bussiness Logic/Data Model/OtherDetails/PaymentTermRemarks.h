//
//  PaymentTermRemarks.h
//
//  Created by iVend  on 8/5/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PaymentTermRemarks : NSObject <NSCoding>

@property (nonatomic, strong) NSString *paymentTermRemarkId;
@property (nonatomic, strong) NSString *paymentTermRemark;
@property (nonatomic, strong) NSString *paymentTermId;

+ (PaymentTermRemarks *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
