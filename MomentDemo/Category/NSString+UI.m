//
//  NSString+UI.m
//  
//
//  Created by JAY on 2018/7/28.
//  Copyright © 2018 . All rights reserved.
//

#import "NSString+UI.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation NSString (UI)

+ (BOOL)isChinaLanguage
{
    NSString *languageStr = [self getPreferredLanguage];
    if ([languageStr isEqualToString:@"zh-Hans"] ||
        [languageStr isEqualToString:@"zh-Hans-US"] ||
        [languageStr isEqualToString:@"zh-Hans-HK"] ||
        [languageStr isEqualToString:@"zh-Hans-CN"] )  {
        return YES;
    } else  {
        return NO;
    }
}
+ (NSString *)getLanguage
{
    NSString *languageStr = [self getPreferredLanguage];
    if ([languageStr containsString:@"zh-Hans"])  {
        //简体中文
        return @"zh";
    } else if ([languageStr containsString:@"Hant"]) {
        //繁体中文
        return @"tc";
    } else {
        //其他语言 用英语
        return @"en";
    }
}
+ (NSString*)getPreferredLanguage
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString * preferredLang = [allLanguages objectAtIndex:0];
    return preferredLang;
}

- (CGFloat)getTxtWidth:(CGFloat)height withFont:(UIFont *)font{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
    return rect.size.width;
}

- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return  [predicate evaluateWithObject:self];
}

- (NSString *)firstLetter
{
    if(self.length == 0)
    {
        return @"";
    }
    return [self substringToIndex:1];
}

- (BOOL)isZIMU
{
    NSString *regex = @"[A-Za-z]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![predicate evaluateWithObject:self]) {
        return NO;
    } else {
        return YES;
    }
}

- (NSString *)localized
{
    return NSLocalizedString(self, @"");
}

+ (BOOL)isNull:(NSString *)str
{
    if (str==nil||![str isKindOfClass:[NSString class]]||[@"" isEqualToString:[str stringByReplacingOccurrencesOfString:@" " withString:@""]] || [str isEqualToString:@"null"] || [str isEqualToString:@"(null)"])
    {
        return YES;
    }else
    {
        return NO;
    }
}

//日期转换
+(NSString *)convertDate:(NSDate *)date withFormat:(NSString *)format
{
    //时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:format];
    
    NSString* time_c = [dateFormatter stringFromDate:date];
    
    return time_c;
}

//md5 32位 加密
- (NSString*)md532BitLower
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    NSMutableString *Mstr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [Mstr appendFormat:@"%02x",result[i]];
    }
    return Mstr;
}

+ (NSString *)convert:(NSString *)str
{
    if(str == nil)
    {
        return @"";
    }
    return  str;
}

- (BOOL)checkEmail {
    NSString *regex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [emailTest evaluateWithObject:self];
}


@end
