//
//  GetOtherDetailsApiResponse.h
//
//  Created by iVend  on 8/5/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GetOtherDetailsApiResponse : NSObject <NSCoding>

@property (nonatomic, strong) NSArray *modeofshipping;
@property (nonatomic, strong) NSString *errorcode;
@property (nonatomic, strong) NSString *success;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *shippingTerms;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSArray *paymentTerms;

+ (GetOtherDetailsApiResponse *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
