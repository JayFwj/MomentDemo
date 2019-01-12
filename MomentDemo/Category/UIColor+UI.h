//
//  UIColor+UI.h
//  
//
//  Created by JAY on 2018/7/27.
//  Copyright © 2018 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UI)

+ (UIColor *)colorWithHexString: (NSString *)color;
+ (UIColor *)MainColor;
+ (UIColor *)NavTitleColor;
+ (UIColor *)PageControlNormalColor;
+ (UIColor *)StartDescColor;
+ (UIColor *)LineColor;
+ (UIColor *)TabbarSelectedColor;
+ (UIColor *)VCBgColor;
+ (UIColor *)FirstColor;
+ (UIColor *)SecondaryColor;

+ (UIColor *)DiapadPhoneNoColor;
+ (UIColor *)DiapadNumberColor;
+ (UIColor *)DiapadLetterColor;
+ (UIColor *)DiapadBalanceTitleColor;
+ (UIColor *)DiapadBalanceColor;

+ (UIColor *)CallingBgColor;
+ (UIColor *)CallingNickColor;
+ (UIColor *)CallingStatusColor;

+ (UIColor *)DtmfHideColor;
+ (UIColor *)DtmfNumberColor;
+ (UIColor *)DtmfLetterColor;

+ (UIColor *)SearchTextFieldBgColor;
+ (UIColor *)SearchTextFieldPlaceholderColor;
+ (UIColor *)SearchTextFieldTxtColor;

+ (UIColor *)ContactNickColor;
+ (UIColor *)ContactSectionIndexColor;

+ (UIColor *)CallsSegmentNormalColor;
+ (UIColor *)CallsSegmentSelectedColor;

+ (UIColor *)SettingNameColor;
+ (UIColor *)SettingPhoneNoColor;

+ (UIColor *)AccountTitleColor;
+ (UIColor *)AccountValueColor;

+ (UIColor *)ContactDetailBgColor;
+ (UIColor *)ContactDetailHeaderTitleColor;
+ (UIColor *)ContactDetailTitleColor;
+ (UIColor *)ContactDetailFeeColor;



@end
