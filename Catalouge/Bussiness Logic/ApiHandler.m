//
//  ApiHandler.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/21/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "ApiHandler.h"
#import "AppDataManager.h"
#import "Account.h"
#import "User.h"

static ApiHandler *apiHandler;
@implementation ApiHandler





+(ApiHandler*)sharedApiHandler{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        if (!apiHandler) {
            apiHandler = [[ApiHandler alloc] init];
        }
    });
    
    return apiHandler;
}


- (NSOperationQueue*)apiHandlerQueue{

    if (!_apiHandlerQueue) {
        
        _apiHandlerQueue = [[NSOperationQueue alloc] init];
        [_apiHandlerQueue setName:@"com.shameem.apihandler"];
    }
    
    return _apiHandlerQueue;
}


- (void)loginApiHandlerWithUserName:(NSString*)userName password:(NSString*)pdw LoginApiCallBlock:(LoginApiCallBlock)loginApiCallBlock{


    [NSURLConnection sendAsynchronousRequest:[self getURLRequestForLoginAPIWith:userName andPassword:pdw] queue:[self apiHandlerQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            loginApiCallBlock(nil,connectionError);
        }else{
        
            NSError *jsonError = nil;
            id responsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            loginApiCallBlock(responsedData,connectionError);

        }
        
        
    }];
    
}

- (void)logoutApiHandlerWithLogoutApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock{

    
    [NSURLConnection sendAsynchronousRequest:[self getURLRequestForLogOut] queue:[self apiHandlerQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
             logoutApiCallBlock(nil,connectionError);
        }else{
            
            NSError *jsonError = nil;
            id responsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            logoutApiCallBlock(responsedData,connectionError);
        }
        
        
    }];

}





- (void)getArticlesApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock{
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PROGRESS_COUNT object:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:0],@"totalRecords",[NSNumber numberWithInteger:0],@"totalInsertedRecords",@"Fetching Articles...",@"Title", nil]];

    [NSURLConnection sendAsynchronousRequest:[self getURLRequestForGetarticles] queue:[self apiHandlerQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            logoutApiCallBlock(nil,connectionError);
        }else{
            
            NSError *jsonError = nil;
            id responsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            ArticlesApiResponse *response = [[ArticlesApiResponse alloc] initWithDictionary:responsedData];
            if ([[response articles] isKindOfClass:[NSArray class]])
                [[CXSSqliteHelper sharedSqliteHelper] insertArticleMasters:[response articles]];

            logoutApiCallBlock(responsedData,connectionError);
        }
        
        
    }];
    
}

- (void)getRawMaterialApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock{

    
    [[NSNotificationCenter defaultCenter] postNotificationName:PROGRESS_COUNT object:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:0],@"totalRecords",[NSNumber numberWithInteger:0],@"totalInsertedRecords",@"Fetching Rawmaterials...",@"Title", nil]];

    [NSURLConnection sendAsynchronousRequest:[self getURLRequestForRawmaterials] queue:[self apiHandlerQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            logoutApiCallBlock(nil,connectionError);
        }else{
            
            NSError *jsonError = nil;
            id responsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            RawmaterialApiResponse *response = [[RawmaterialApiResponse alloc] initWithDictionary:responsedData];
            
            //Update to DB
            if ([[response rawmaterials] isKindOfClass:[NSArray class]])
                [[CXSSqliteHelper sharedSqliteHelper] insertRawMaterials:[response rawmaterials]];
            
            if ([[response rawmaterials] isKindOfClass:[NSArray class]])
                [[CXSSqliteHelper sharedSqliteHelper] insertLasts:[response lasts]];

            
            logoutApiCallBlock(responsedData,connectionError);
        }
        
        
    }];
    
    

}

- (void)getColorApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PROGRESS_COUNT object:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:0],@"totalRecords",[NSNumber numberWithInteger:0],@"totalInsertedRecords",@"Fetching Colors...",@"Title", nil]];

    [NSURLConnection sendAsynchronousRequest:[self getURLRequestForGetcolors] queue:[self apiHandlerQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            logoutApiCallBlock(nil,connectionError);
        }else{
            
            NSError *jsonError = nil;
            id responsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            ArticleColor *response = [[ArticleColor alloc] initWithDictionary:responsedData];
            //Update to DB
            if ([[response colors] isKindOfClass:[NSArray class]])
                [[CXSSqliteHelper sharedSqliteHelper] insertColors:[response colors]];

            logoutApiCallBlock(responsedData,connectionError);
        }
        
        
    }];
    
    
    
}


- (void)getClientsApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock{
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PROGRESS_COUNT object:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:0],@"totalRecords",[NSNumber numberWithInteger:0],@"totalInsertedRecords",@"Fetching Clients...",@"Title", nil]];

    [NSURLConnection sendAsynchronousRequest:[self getURLRequestForGetclients] queue:[self apiHandlerQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            logoutApiCallBlock(nil,connectionError);
        }else{
            
            NSError *jsonError = nil;
            id responsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            ClientsApiResponse *response = [[ClientsApiResponse alloc] initWithDictionary:responsedData];
            //Update to DB
            if ([[response clients] isKindOfClass:[NSArray class]])
                [[CXSSqliteHelper sharedSqliteHelper] insertClient_Master:[response clients]];
            
            logoutApiCallBlock(responsedData,connectionError);
        }
        
        
    }];
    
    
    
}


- (void)addClientsApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock withClient:(id)client{
    
    __block __weak Clients *weakClient = (Clients*)client;
    
    [NSURLConnection sendAsynchronousRequest:[self getURLRequestForAddClients:weakClient] queue:[self apiHandlerQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            logoutApiCallBlock(nil,connectionError);
        }else{
            
            NSError *jsonError = nil;
            id responsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];

            if ([[responsedData objectForKey:@"errorcode"] isEqualToString:@"200"]) {

                //TODO::
                NSString *clientId = [responsedData objectForKey:@"clientid"];
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [[AppDataManager sharedAppDatamanager] validateString:clientId],@"clientid",
                                      [[AppDataManager sharedAppDatamanager] validateString:[client company]],@"company",
                                      [[AppDataManager sharedAppDatamanager] validateString:[client contactperson]],@"contactperson",
                                      [[AppDataManager sharedAppDatamanager] validateString:[client email]],@"email",
                                      [[AppDataManager sharedAppDatamanager] validateString:[client address1]],@"address1",
                                      [[AppDataManager sharedAppDatamanager] validateString:[client address2]],@"address2",
                                      [[AppDataManager sharedAppDatamanager] validateString:[client city]],@"city",
                                      [[AppDataManager sharedAppDatamanager] validateString:[client country]],@"country",
                                      nil];

                [[CXSSqliteHelper sharedSqliteHelper] insertInto:@"Client_Master" ColumnsAndValues:dict];

            }

            logoutApiCallBlock(responsedData,nil);
        }
        
        
    }];
    
    
    
}

- (void)updateClientsApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock withClient:(id)client{
    
    __block __weak Clients *weakClient = (Clients*)client;
    
    [NSURLConnection sendAsynchronousRequest:[self getURLRequestForUpdateClients:weakClient] queue:[self apiHandlerQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            logoutApiCallBlock(nil,connectionError);
        }else{
            
            //TODO::
            NSError *jsonError = nil;
            id responsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
//            Client_Master *response = [[Client_Master alloc] initWithDictionary:responsedData];
//            //Update to DB
//            if ([[response clients] isKindOfClass:[NSArray class]])
//                [[CXSSqliteHelper sharedSqliteHelper] insertClient_Master:[response clients]];
//            
//            logoutApiCallBlock(responsedData,connectionError);
        }
        
        
    }];
    
    
    
}


- (void)getPaymentShippingTermsApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock{
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PROGRESS_COUNT object:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:0],@"totalRecords",[NSNumber numberWithInteger:0],@"totalInsertedRecords",@"Fetching Payment Term...",@"Title", nil]];

    [NSURLConnection sendAsynchronousRequest:[self getURLRequestForGetPaymentShippingTerms] queue:[self apiHandlerQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            logoutApiCallBlock(nil,connectionError);
        }else{
            
            NSError *jsonError = nil;
            id responsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            GetOtherDetailsApiResponse *response = [[GetOtherDetailsApiResponse alloc] initWithDictionary:responsedData];
            //Update to DB
            if ([[response paymentTerms] isKindOfClass:[NSArray class]])
                [[CXSSqliteHelper sharedSqliteHelper] insertPaymentTerms:[response paymentTerms]];

            if ([[response paymentTerms] isKindOfClass:[NSArray class]])
                [[CXSSqliteHelper sharedSqliteHelper] insertShippingTerms:[response shippingTerms]];

            if ([[response paymentTerms] isKindOfClass:[NSArray class]])
                [[CXSSqliteHelper sharedSqliteHelper] insertModeofshipping:[response modeofshipping]];

            logoutApiCallBlock(responsedData,connectionError);
        }
        
        
    }];
    
    
    
}


- (void)getOrdersApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock{
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PROGRESS_COUNT object:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:0],@"totalRecords",[NSNumber numberWithInteger:0],@"totalInsertedRecords",@"Fetching Orders...",@"Title", nil]];
    
    [NSURLConnection sendAsynchronousRequest:[self getURLRequestForGetOrders] queue:[self apiHandlerQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            logoutApiCallBlock(nil,connectionError);
        }else{
            
            NSError *jsonError = nil;
            id responsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
            GetOrdersApiResponse *response = [[GetOrdersApiResponse alloc] initWithDictionary:responsedData];
            //Update to DB
            if ([[response orders] isKindOfClass:[NSArray class]])
                [[CXSSqliteHelper sharedSqliteHelper] insertOrdersTerms:[response orders]];
            
            logoutApiCallBlock(responsedData,connectionError);
        }
        
        
    }];
    
    
    
}


- (void)reSendOrderApiHandlerWithApiCallBlock:(LoginApiCallBlock)logoutApiCallBlock withOrderId:(NSString*)orderId{
    
    
    
    [NSURLConnection sendAsynchronousRequest:[self getURLRequestForReSendOrderWithOrderId:orderId] queue:[self apiHandlerQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            logoutApiCallBlock(nil,connectionError);
        }else{
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSInteger statusCode = [httpResponse statusCode];
            if (statusCode == 200) {
                logoutApiCallBlock(data,nil);
            }else
                logoutApiCallBlock(nil,connectionError);

            
        }
        
        
    }];
    
    
    
}
- (void)changePassword:(LoginApiCallBlock)logoutApiCallBlock withOldPassword:(NSString*)oldpassword andNewPassword:(NSString*)newpassword{
    
    
    
    [NSURLConnection sendAsynchronousRequest:[self getURLRequestForChangePassword:oldpassword newPassword:newpassword] queue:[self apiHandlerQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            logoutApiCallBlock(nil,connectionError);
        }else{
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSInteger statusCode = [httpResponse statusCode];
            if (statusCode == 200) {
                logoutApiCallBlock(data,nil);
            }else
                logoutApiCallBlock(nil,connectionError);
            
            
        }
        
        
    }];
    
    
    
}

#pragma mark - NSURLRequest

- (NSURLRequest*)getURLRequestForLoginAPIWith:(NSString*)username andPassword:(NSString*)pwd{

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH ,GET_LOG_IN_API]];
    
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:180];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *postString = [NSString stringWithFormat:@"username=%@&password=%@&device_id=%@",username,pwd,[[UIDevice currentDevice]uniqueDeviceIdentifierWithOutEncription]];
//    NSString *postString = [NSString stringWithFormat:@"username=%@&password=%@",@"test",@"test"];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    return request;

}

- (NSURLRequest*)getURLRequestForLogOut{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH ,GET_LOG_OUT_API]];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:180];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    AppDataManager *sharedAppDatamanager = [AppDataManager sharedAppDatamanager];
    NSString *postString = [NSString stringWithFormat:@"user_id=%@&session_id=%@",[[[sharedAppDatamanager account] user] userId],[[sharedAppDatamanager account] sessionId]];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    return request;
    
}

//getarticles.php

- (NSURLRequest*)getURLRequestForGetarticles{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH ,GET_ARTICLE_API]];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:180];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    AppDataManager *sharedAppDatamanager = [AppDataManager sharedAppDatamanager];
    NSString *postString = [NSString stringWithFormat:@"userid=%@&sessionid=%@",[[[sharedAppDatamanager account] user] userId],[[sharedAppDatamanager account] sessionId]];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    return request;
    
}
- (NSURLRequest*)getURLRequestForRawmaterials{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH ,GET_RAW_MATERIAL_API]];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:180];

    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    AppDataManager *sharedAppDatamanager = [AppDataManager sharedAppDatamanager];
    NSString *postString = [NSString stringWithFormat:@"userid=%@&sessionid=%@",[[[sharedAppDatamanager account] user] userId],[[sharedAppDatamanager account] sessionId]];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    return request;
    
}

- (NSURLRequest*)getURLRequestForGetcolors{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH ,GET_COLOR_API]];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:180];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    AppDataManager *sharedAppDatamanager = [AppDataManager sharedAppDatamanager];
    NSString *postString = [NSString stringWithFormat:@"userid=%@&sessionid=%@",[[[sharedAppDatamanager account] user] userId],[[sharedAppDatamanager account] sessionId]];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    return request;
    
}

- (NSURLRequest*)getURLRequestForGetclients{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH ,GET_CLIENTS_API]];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:180];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    AppDataManager *sharedAppDatamanager = [AppDataManager sharedAppDatamanager];
    NSString *postString = [NSString stringWithFormat:@"userid=%@&sessionid=%@",[[[sharedAppDatamanager account] user] userId],[[sharedAppDatamanager account] sessionId]];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    return request;
    
}


- (NSURLRequest*)getURLRequestForUpdateClients:(Clients*)client{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH ,UPDATE_CLIENTS_API]];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:180];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    AppDataManager *sharedAppDatamanager = [AppDataManager sharedAppDatamanager];
    
//    NSString *clientString = @"";
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
//                          client.clientid,@"clientid",
//                          client.name,@"name",
//                          client.email,@"email",
//                          client.contactNumber,@"contact_number",
//                          client.address,@"address",
//                          client.state,@"state",
//                          client.country,@"country",
//                          nil];
//    
//    NSDictionary *mainDict = [NSDictionary dictionaryWithObject:dict forKey:@"client"];
    
//    NSData *data = [[NSString alloc] in];
//    
//    NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:<#(NSData *)#> options:<#(NSJSONReadingOptions)#> error:<#(NSError *__autoreleasing *)#>];
//    
//    
    
    
    
    
//    NSString *postString = [NSString stringWithFormat:@"userid=%@&sessionid=%@&payload=%@",[[[sharedAppDatamanager account] user] userId],[[sharedAppDatamanager account] sessionId],clientString];
//    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:postData];
    return nil;
    
}

- (NSURLRequest*)getURLRequestForReSendOrderWithOrderId:(NSString*)orderId{
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH ,RE_RESEND_ORFDER_API]];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:180];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    AppDataManager *sharedAppDatamanager = [AppDataManager sharedAppDatamanager];
    
    NSString *postString = [NSString stringWithFormat:@"userid=%@&sessionid=%@&OrderId=%@",[[[sharedAppDatamanager account] user] userId],[[sharedAppDatamanager account] sessionId],orderId];
    NSData *postData = [[self escapeChar:postString] dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    return request;
    
}
- (NSURLRequest*)getURLRequestForAddClients:(Clients*)client{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH ,ADD_CLIENTS_API]];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:180];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    AppDataManager *sharedAppDatamanager = [AppDataManager sharedAppDatamanager];
    
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          
                          [[AppDataManager sharedAppDatamanager] validateString:[client company]],@"company",
                          [[AppDataManager sharedAppDatamanager] validateString:[client contactperson]],@"contactperson",
                          [[AppDataManager sharedAppDatamanager] validateString:[client email]],@"email",
                          [[AppDataManager sharedAppDatamanager] validateString:[client address1]],@"address1",
                          [[AppDataManager sharedAppDatamanager] validateString:[client address2]],@"address2",
                          [[AppDataManager sharedAppDatamanager] validateString:[client city]],@"city",
                          [[AppDataManager sharedAppDatamanager] validateString:[client country]],@"country",
                          nil];
    
    
    NSDictionary *mainDict = [NSDictionary dictionaryWithObjectsAndKeys:dict,@"client" ,nil];

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mainDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    
    NSString*aStr;
    aStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //
    
    
    
    
    NSString *postString = [NSString stringWithFormat:@"userid=%@&sessionid=%@&payload=%@",[[[sharedAppDatamanager account] user] userId],[[sharedAppDatamanager account] sessionId],aStr];
    
    
    
    NSString *escapedString = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (__bridge_retained CFStringRef)postString,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8);

    
    NSData *postData = [escapedString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    return request;
    
}

- (NSURLRequest*)getURLRequestForGetPaymentShippingTerms{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH ,GET_PAYMENT_SHIPPING_TERMS]];
    
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:180];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    AppDataManager *sharedAppDatamanager = [AppDataManager sharedAppDatamanager];
    NSString *postString = [NSString stringWithFormat:@"userid=%@&sessionid=%@",[[[sharedAppDatamanager account] user] userId],[[sharedAppDatamanager account] sessionId]];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    return request;
    
}
- (NSURLRequest*)getURLRequestForGetOrders{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH ,GET_Orders]];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:180];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    AppDataManager *sharedAppDatamanager = [AppDataManager sharedAppDatamanager];
    NSString *postString = [NSString stringWithFormat:@"userid=%@&sessionid=%@",[[[sharedAppDatamanager account] user] userId],[[sharedAppDatamanager account] sessionId]];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    return request;
    
}

- (NSURLRequest*)getURLRequestForChangePassword:(NSString*)oldPassword newPassword:(NSString*)newPassword{
    
    AppDataManager *sharedAppDatamanager = [AppDataManager sharedAppDatamanager];
    NSString *postString = [NSString stringWithFormat:@"userid=%@&sessionid=%@&oldpassword=%@&newpassword=%@",[[[sharedAppDatamanager account] user] userId],[[sharedAppDatamanager account] sessionId],oldPassword,newPassword];
    

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?%@",ROOT_API_PATH ,CHNAGE_PASSWORD,postString]];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:180];
    
    [request setHTTPMethod:@"GET"];

    return request;
    
}

#pragma mark-

- (NSString*)escapeChar:(NSString*)str{


    
    
    NSString *escapedString = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (__bridge_retained CFStringRef)str,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8);
    
    return escapedString;

}
@end
