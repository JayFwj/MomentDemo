

//
//  VETTitleItemView.m
//  
//
//  Created by JAY on 2019/1/5.
//  Copyright © 2019 . All rights reserved.
//

#import "VETTitleItemView.h"

@implementation VETTitleItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectedIndexChanged:) name:VETTitleItemViewDidSelectedIndexChanged object:nil];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didSelectedIndexChanged:(NSNotification *)notification{
    BOOL status = (self.selectedIndex == [notification.userInfo[@"SelectedIndex"] integerValue]);
    [self showSelectedStyle:status];
    if(!status){
        self.selectedIndex = -1;
    }
}

- (void)showSelectedStyle:(BOOL)selected{
    UIColor *bgColor = selected ? [UIColor blackColor] : [UIColor whiteColor];
    UIColor *txtColor = selected ? [UIColor whiteColor] : [UIColor blackColor];
    self.backgroundColor  = bgColor;
    [self setTitleColor:txtColor forState:UIControlStateNormal];
}

@end
