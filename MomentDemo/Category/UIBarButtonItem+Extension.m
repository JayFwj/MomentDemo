//
//  UIBarButtonItem+Extension.m
//  DYBluetoothLock
//
//  Created by Young on 15/11/27.
//  Copyright (c) 2015年 youngLiu. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem*)itemWithImageName:(NSString*)imageName highImageName:(NSString*)highImageName target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    btn.size = btn.currentBackgroundImage.size;
    [btn addTarget: target action: action forControlEvents: UIControlEventTouchUpInside]; 
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:btn] ;

    return leftBarButton;
}


+ (instancetype)barButtonItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action {
    UIFont *titleFont = [UIFont systemFontOfSize:16];
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:titleFont}
                                           context:nil].size;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:titleFont];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor MainColor] forState:UIControlStateDisabled];
    [button setBounds:CGRectMake(0, 0, titleSize.width, titleSize.height)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (instancetype)barButtonItemWithNormalImg:(NSString *)normalImg HighlightedImg:(NSString *)highlightedImg target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *norImage = [UIImage imageNamed:normalImg];
    [button setImage:norImage forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImg] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setBounds:CGRectMake(0, 0, norImage.size.width, norImage.size.height)];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
