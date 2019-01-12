//
//  NSUserDefaults+UI.h
//  
//
//  Created by JAY on 2018/8/9.
//  Copyright © 2018 . All rights reserved.
//

#import <Foundation/Foundation.h>

#define KEY_CALL_TYPE_VOIP @"VOIP"
#define KEY_CALL_TYPE_DIAL_BACK @"DIAL_BACK"
#define NOTIFICATION_CALL_TYPE_CHANGED_NAME @"NOTIFICATION_CALL_TYPE_CHANGED_NAME"

@interface NSUserDefaults (UI)

- (NSString *)getCallType;

- (void)setCallType:(NSString *)callType;

@end
