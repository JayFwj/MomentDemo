
//
//  NSUserDefaults+UI.m
//  
//
//  Created by JAY on 2018/8/9.
//  Copyright © 2018 . All rights reserved.
//

#import "NSUserDefaults+UI.h"
#import "NSString+UI.h"
//呼叫类型
#define KEY_CALL_TYPE @"CALL_TYPE"

@implementation NSUserDefaults (UI)

- (NSString *)getCallType
{
    NSString *callType = [self stringForKey:KEY_CALL_TYPE];
    if([NSString isNull:callType])
    {
        return [@"Setting.CallType.VOIP" localized];
    }else
    {
        return [KEY_CALL_TYPE_VOIP isEqualToString:callType] ? [@"Setting.CallType.VOIP" localized] : [@"Setting.CallType.DialBack" localized];
    }
}

- (void)setCallType:(NSString *)callType
{
    [self setObject:callType forKey:KEY_CALL_TYPE];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CALL_TYPE_CHANGED_NAME object:nil];
}

@end
