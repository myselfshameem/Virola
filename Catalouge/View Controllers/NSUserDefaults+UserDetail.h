//
//  NSUserDefaults+UserDetail.h
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (UserDetail)
+ (BOOL)isUserLoggedIn;
+ (void)setIsUserLoggedIn:(BOOL)flag;

+(NSString*)lastSynTime;
+(void)setLastSynTime:(NSString*)lastSynTime;
@end
