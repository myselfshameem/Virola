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

    [NSURLConnection sendAsynchronousRequest:[self getURLRequestForRawmaterials] queue:[self apiHandlerQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            
            logoutApiCallBlock(nil,connectionError);
        }else{
            
            NSError *jsonError = nil;
            id responsedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
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
//                NSString *clientId = [responsedData objectForKey:@"clientid"];
//                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
//                                      [clientId length]? clientId : @"",@"clientid",
//                                      [weakClient.name length]? weakClient.name : @"",@"name",
//                                      [weakClient.address length]? weakClient.address : @"",@"address",
//                                      [weakClient.country length]? weakClient.country : @"",@"country",
//                                      [weakClient.email length]? weakClient.email : @"",@"email",
//                                      [weakClient.state length]? weakClient.state : @"",@"state",
//                                      [weakClient.contactNumber length]? weakClient.contactNumber : @"",@"contactNumber",
//                                      nil];
//
//                [[CXSSqliteHelper sharedSqliteHelper] insertInto:@"Client_Master" ColumnsAndValues:dict];

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


#pragma mark - NSURLRequest

- (NSURLRequest*)getURLRequestForLoginAPIWith:(NSString*)username andPassword:(NSString*)pwd{

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH ,GET_LOG_IN_API]];
    
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    NSString *postString = [NSString stringWithFormat:@"username=%@&password=%@&device_id=%@",username,pwd,[[UIDevice currentDevice]uniqueDeviceIdentifierWithOutEncription]];
    NSString *postString = [NSString stringWithFormat:@"username=%@&password=%@",@"test",@"test"];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    return request;

}

- (NSURLRequest*)getURLRequestForLogOut{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH ,GET_LOG_OUT_API]];
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
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


- (NSURLRequest*)getURLRequestForAddClients:(Clients*)client{
    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",ROOT_API_PATH ,ADD_CLIENTS_API]];
//    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    AppDataManager *sharedAppDatamanager = [AppDataManager sharedAppDatamanager];
//    
//    
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
//                          [client.name length]? client.name : @"",@"name",
//                          [client.address length]? client.address : @"",@"address",
//                          [client.country length]? client.country : @"",@"country",
//                          [client.email length]? client.email : @"",@"email",
//                          [client.state length]? client.state : @"",@"state",
//                          [client.contactNumber length]? client.contactNumber : @"",@"contactNumber",
//                          nil];
//    
//    
//    NSDictionary *mainDict = [NSDictionary dictionaryWithObjectsAndKeys:dict,@"client" ,nil];
//
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mainDict
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:&error];
//    
//    
//    NSString*aStr;
//    aStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    //
//    
//    
//    
//    
//    NSString *postString = [NSString stringWithFormat:@"userid=%@&sessionid=%@&payload=%@",[[[sharedAppDatamanager account] user] userId],[[sharedAppDatamanager account] sessionId],aStr];
//    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:postData];
    return nil;
    
}

@end
