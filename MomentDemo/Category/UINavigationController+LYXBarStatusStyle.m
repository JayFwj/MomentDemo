//
//  UINavigationController+LYXBarStyle.m
//  MobileVoip
//
//  Created by Liu Yang on 02/06/2017.
//  Copyright © 2017 . All rights reserved.
//

#import "UINavigationController+LYXBarStatusStyle.h"
#import "UIImage+LYXExtension.h"
@implementation UINavigationController (LYXBarStatusStyle)

- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIViewController *rootViewController = self.viewControllers.firstObject;
    if (rootViewController) {
        return rootViewController.preferredStatusBarStyle;
    }
    return [super preferredStatusBarStyle];
}

- (void)convertNavigationBarToWhite
{
    UINavigationBar * bar = self.navigationBar;
    UIImage *bgImage = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(SCREEN_WIDTH, TopNavHeight)];
    [bar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[UIImage new]];
}

- (void)convertNavigationBarToWhiteAndkeepLine
{
    UINavigationBar * bar = self.navigationBar;
    UIImage *bgImage = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(SCREEN_WIDTH, TopNavHeight)];
    [bar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
}

@end
