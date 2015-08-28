//
//  ApiHandler.h
//  Catalouge
//
//  Created by Shameem Ahamad on 5/21/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiHandler : NSObject

{

    
}


@property(nonatomic,strong ) NSOperationQueue *apiHandlerQueue;




+(ApiHandler*)sharedApiHandler;
typedef void(^LoginApiCallBlock)(id data,NSError *error);
- (NSURLRequest*)getURLRequestForRawmaterials;

- (void)loginApiHandlerWithUserName:(NSString*)userName password:(NSString*)pdw LoginApiCallBlock:(LoginApiCallBlock)loginApiCallBlock;
- (void)logoutApiHandlerWithLogoutApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock;
- (void)getArticlesApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock;
- (void)getRawMaterialApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock;
- (void)getColorApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock;
- (void)getClientsApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock;
- (void)updateClientsApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock withClient:(id)client;
- (void)addClientsApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock withClient:(id)client;
- (void)getPaymentShippingTermsApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock;
- (void)getOrdersApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock;
@end
