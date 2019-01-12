/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

static const void *HUDHintKey = &HUDHintKey;
static const void *HintKey = &HintKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)Hint{
    return objc_getAssociatedObject(self, HintKey);
}

- (void)setHint:(MBProgressHUD *)Hint{
    objc_setAssociatedObject(self, HintKey, Hint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD *)HUDHint{
    return objc_getAssociatedObject(self, HUDHintKey);
}

- (void)setHUDHint:(MBProgressHUD *)HUDHint{
    objc_setAssociatedObject(self, HUDHintKey, HUDHint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD  *hud;
    if (![self HUDHint]) {
        hud = [[MBProgressHUD alloc] initWithView:view];
        [self setHUDHint:hud];
        [view addSubview:hud];
    }
    hud.detailsLabel.text = hint;
    [hud showAnimated:YES];
}

- (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud;
    if (![self Hint]) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        [self setHint:hud];
    }
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = hint;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16.0];
    hud.margin = 10.f;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:3];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud;
    if (![self Hint]) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        [self setHint:hud];
    }
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    hud.offset = CGPointMake(hud.offset.x, hud.offset.y + yOffset);
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2];
}

- (void)hideHud{
    [[self Hint] hideAnimated:YES];
    [[self HUDHint] hideAnimated:YES];
    [self setHint:nil];
    [self setHUDHint:nil];
}

@end
