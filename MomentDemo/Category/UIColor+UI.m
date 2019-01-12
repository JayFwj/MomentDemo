//
//  UIColor+UI.m
//  
//
//  Created by JAY on 2018/7/27.
//  Copyright © 2018 . All rights reserved.
//

#import "UIColor+UI.h"

@implementation UIColor (UI)

+ (UIColor *)MainColor
{
    return [self colorWithHexString:@"#25CFFF"];
}

+ (UIColor *)PageControlNormalColor
{
    return [self colorWithHexString:@"#B5B5B5"];
}
+ (UIColor *)StartDescColor
{
    return [self colorWithHexString:@"#999999"];
}

+ (UIColor *)FirstColor
{
    return [self colorWithHexString:@"#333333"];
}

+ (UIColor *)SecondaryColor
{
    return [self colorWithHexString:@"#A0A0A0"];
}


+ (UIColor *)NavTitleColor
{
    return [self colorWithHexString:@"#333333"];
}

+ (UIColor *)TabbarSelectedColor
{
    return [self colorWithHexString:@"#333333"];
}

+ (UIColor *)LineColor
{
    return [self colorWithHexString:@"#CDCCD0"];
}

+ (UIColor *)VCBgColor
{
    return [self colorWithHexString:@"#ECEEEE"];
}

+ (UIColor *)DiapadPhoneNoColor
{
    return [self colorWithHexString:@"#333333"];
}

+ (UIColor *)DiapadNumberColor
{
    return [self colorWithHexString:@"#333333"];
}

+ (UIColor *)DiapadLetterColor
{
    return [self colorWithHexString:@"#333333"];
}

+ (UIColor *)DiapadBalanceTitleColor
{
    return [self colorWithHexString:@"#A0A0A0"];
}

+ (UIColor *)DiapadBalanceColor
{
    return [self colorWithHexString:@"#333333"];
}

#pragma -mark Calling

+ (UIColor *)CallingBgColor
{
    return [self colorWithHexString:@"#34383A"];
}


+ (UIColor *)CallingNickColor
{
    return [self colorWithHexString:@"#FFFFFF"];
}


+ (UIColor *)CallingStatusColor
{
    return [self colorWithHexString:@"#FFFFFF"];
}

#pragma -mark DTMF
+ (UIColor *)DtmfHideColor
{
    return [self colorWithHexString:@"#FFFFFF"];
}
+ (UIColor *)DtmfNumberColor
{
    return [self colorWithHexString:@"#FFFFFF"];
}
+ (UIColor *)DtmfLetterColor
{
    return [self colorWithHexString:@"#FFFFFF"];
}

+ (UIColor *)SearchTextFieldBgColor
{
    return [self colorWithHexString:@"#EDEEEE"];
}
+ (UIColor *)SearchTextFieldPlaceholderColor
{
    return [self colorWithHexString:@"#8E9E93"];
}
+ (UIColor *)SearchTextFieldTxtColor
{
    return [self colorWithHexString:@"#333333"];
}

+ (UIColor *)ContactNickColor
{
    return [self colorWithHexString:@"#333333"];
}

+ (UIColor *)ContactSectionIndexColor
{
    return [self colorWithHexString:@"#A0A0A0"];
}

+ (UIColor *)CallsSegmentNormalColor
{
   return [self colorWithHexString:@"#333333"];
}

+ (UIColor *)CallsSegmentSelectedColor
{
    return [self colorWithHexString:@"#76D0FA"];
}

+ (UIColor *)SettingNameColor
{
    return [self colorWithHexString:@"#333333"];
}
+ (UIColor *)SettingPhoneNoColor
{
    return [self colorWithHexString:@"#A0A0A0"];
}

+ (UIColor *)AccountTitleColor
{
    return [self SettingNameColor];
}
+ (UIColor *)AccountValueColor
{
    return [self SettingPhoneNoColor];
}

+ (UIColor *)ContactDetailBgColor
{
    return [self colorWithHexString:@"#F6F6FA"];
}
+ (UIColor *)ContactDetailHeaderTitleColor
{
    return [self colorWithHexString:@"#9494A3"];
}
+ (UIColor *)ContactDetailTitleColor
{
    return [self colorWithHexString:@"#333333"];
}
+ (UIColor *)ContactDetailFeeColor
{
    return [self colorWithHexString:@"#25DFFF"];
}


+ (UIColor *)colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
    cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
    cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
    return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}




@end
