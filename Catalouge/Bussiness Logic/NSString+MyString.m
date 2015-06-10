//
//  NSString+MyString.m
//  Catalouge
//
//  Created by Shameem Ahamad on 6/1/15.
//  Copyright (c) 2015 Shameem Ahamad. All rights reserved.
//

#import "NSString+MyString.h"

@implementation NSString (MyString)
- (NSString *) sqliteString {
    if ((self == nil) || [(NSNull*)self isKindOfClass: [NSNull class]]) {
        return @"''";
    }
    else if ([self isKindOfClass: [NSArray class]]) {
        NSArray *selfArray = (NSArray*)self;
        NSMutableString *buffer = [NSMutableString string];
        [buffer appendString: @"("];
        for (int i = 0; i < [selfArray count]; i++) {
            if (i > 0) {
                [buffer appendString: @", "];
            }
            [buffer appendString: [[selfArray objectAtIndex: i] sqliteString]];
        }
        [buffer appendString: @")"];
        return buffer;
    }
    else if ([self isKindOfClass: [NSNumber class]]) {
        return [NSString stringWithFormat: @"%@", self];
    }
    else if ([self isKindOfClass: [NSString class]]) {
        char *escapedself = sqlite3_mprintf("'%q'", [(NSString *)self UTF8String]);
        NSString *string = [NSString stringWithUTF8String: (const char *)escapedself];
        sqlite3_free(escapedself);
        return string;
    }
    else if ([self isKindOfClass: [NSData class]]) {
        NSData *data = (NSData *)self;
        int length = [data length];
        NSMutableString *buffer = [NSMutableString string];
        [buffer appendString: @"x'"];
        const unsigned char *dataBuffer = [data bytes];
        for (int i = 0; i < length; i++) {
            [buffer appendFormat: @"%02lx", (unsigned long)dataBuffer[i]];
        }
        [buffer appendString: @"'"];
        return buffer;
    }
    else if ([self isKindOfClass: [NSDate class]]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSString *date = [NSString stringWithFormat: @"'%@'", [formatter stringFromDate: (NSDate *)self]];
        return date;
    }
    
    //TODO::
    /*else if ([self isKindOfClass: [ZIMSqlExpression class]]) {
     return [(ZIMSqlExpression *)self expression];
     }
     else if ([self isKindOfClass: [ZIMSqlSelectStatement class]]) {
     NSString *statement = [(ZIMSqlSelectStatement *)self statement];
     statement = [statement substringWithRange: NSMakeRange(0, [statement length] - 1)];
     statement = [NSString stringWithFormat: @"(%@)", statement];
     return statement;
     }*/
    else {
        @throw [NSException exceptionWithName: @"SqlException" reason: [NSString stringWithFormat: @"Unable to prepare self. '%@'", self] userInfo: nil];
    }
}
- (NSString *) checkEmptyString {

    if (self) {
        return [self length] ? self : @"";
  
    
    }else{
    
    
        return @"";
    }
}
@end
