//
//  NSUserDefaults+UserDetail.m
//  Catalouge
//
//  Created by Shameem Ahamad on 5/10/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "NSUserDefaults+UserDetail.h"
#define USER_LOG_IN_BOOL @"USER_LOG_IN_BOOL"
#define LAST_SYN_TIME @"LAST_SYN_TIME"

@implementation NSUserDefaults (UserDetail)
+ (BOOL)isUserLoggedIn{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:USER_LOG_IN_BOOL] boolValue];
}

+ (void)setIsUserLoggedIn:(BOOL)flag{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:flag] forKey:USER_LOG_IN_BOOL];
}

+(NSString*)lastSynTime{

    if (![[NSUserDefaults standardUserDefaults] objectForKey:LAST_SYN_TIME]) {
        NSString *date = [self currentDate];
        [[NSUserDefaults standardUserDefaults] setObject:date forKey:LAST_SYN_TIME];
        return date;
    }else{
        return [[NSUserDefaults standardUserDefaults] objectForKey:LAST_SYN_TIME];
    }
    

}
+(void)setLastSynTime:(NSString*)lastSynTime{
    [[NSUserDefaults standardUserDefaults] setObject:[self currentDate] forKey:LAST_SYN_TIME];
}

+ (NSString*)currentDate{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"dd-MM-YYYY"];
    NSString *date = [dateFormatter stringFromDate:[NSDate date]];

    return date;
}
@end
