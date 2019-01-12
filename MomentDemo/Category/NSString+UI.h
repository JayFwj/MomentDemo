//
//  NSString+UI.h
//  
//
//  Created by JAY on 2018/7/28.
//  Copyright © 2018 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
@interface NSString (UI)

+ (NSString *)getLanguage;

+ (BOOL)isChinaLanguage;

- (BOOL)isChinese;

- (NSString *)firstLetter;

- (NSString *)getNickFirstLetter;

- (BOOL)isZIMU;

- (CGFloat)getTxtWidth:(CGFloat)height withFont:(UIFont *)font;

- (NSString *)localized;

+ (BOOL)isNull:(NSString *)str;
//日期转换
+(NSString *)convertDate:(NSDate *)date withFormat:(NSString *)format;

//md5 32位 加密
- (NSString*)md532BitLower;

+ (NSString *)convert:(NSString *)str;

- (BOOL)checkEmail;

@end
