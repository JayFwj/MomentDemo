//
//  MBProgressHUD+Alert.m
//  SunMall
//
//  Created by yunxuan on 15/11/10.
//  Copyright © 2015年 huangshupeng. All rights reserved.
//

#import "MBProgressHUD+Alert.h"
#import "AppDelegate.h"
#import <objc/runtime.h>

static MBProgressHUD *theMBProgress = nil;
static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation MBProgressHUD (Alert)


+ (MBProgressHUD *)shareInstance
{
    @synchronized(self){
        if(theMBProgress == nil){
            theMBProgress = [[MBProgressHUD alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-200)/2, 0, 200, 100)];
        }
    }
    return theMBProgress;
}

+ (MBProgressHUD *)shareManager
{
    @synchronized(self){
        if(theMBProgress == nil){
            theMBProgress = [[MBProgressHUD alloc] initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH-100, 30)];
        }
    }
    return theMBProgress;
}

- (void) ShowMessage :(NSString *)msg showView:(UIView *)view
{

    if (!view) {
        UIWindow *widow = [[UIApplication sharedApplication].delegate window];
        view = widow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];

}

- (MBProgressHUD *)showLoding :(NSString *)msg showView:(UIView *)view
{
    if (!view) {
        UIWindow *widow = [[UIApplication sharedApplication].delegate window];
        view = widow;
    }
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.label.text = msg;
    HUD.tag = HUD_VIEW_TAG;
    [view addSubview:HUD];
    [HUD showAnimated:YES];
    [self setHUD:HUD];
    return HUD;
}

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
