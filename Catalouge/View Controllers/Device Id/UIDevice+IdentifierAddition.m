//
//  UIDevice(Identifier).m
//  UIDeviceAddition
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import "UIDevice+IdentifierAddition.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation UIDevice (IdentifierAddition)


- (NSString *)uniqueDeviceIdentifierWithOutEncription {
    return [self udid];
}

- (NSString *)udid {

    return @"12345";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"kCXSiVendPOSUDID"]) {
        return [defaults objectForKey:@"kCXSiVendPOSUDID"];
    }else{
        NSLocale *uslocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:uslocale];
        [formatter setCalendar:gregorian];
        [formatter setDateFormat:@"'CTX-'YYYYMMDD'-'HHmmssSSS"];
        NSString *temp = [formatter stringFromDate:[NSDate date]];
        NSUUID *udid = [[NSUUID alloc] init];
        NSString *deviceId = [NSString stringWithFormat:@"%@-%@", temp, [udid UUIDString]];
        [defaults setObject:deviceId forKey:@"kCXSiVendPOSUDID"];
        [defaults synchronize];
        uslocale = nil;
        formatter = nil;
        gregorian = nil;
        udid = nil;
        return deviceId;
    }
}


@end
