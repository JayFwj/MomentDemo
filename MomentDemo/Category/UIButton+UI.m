//
//  UIButton+UI.m
//  
//
//  Created by JAY on 2018/7/27.
//  Copyright © 2018 . All rights reserved.
//

#import "UIButton+UI.h"
#import <Masonry/Masonry.h>
@implementation UIButton (UI)

- (void)setImg:(NSString *)normal  withSelected:(NSString *)selected
{
    [self setImage:[UIImage imageNamed:normal] forState:UIControlStateDisabled];
    [self setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:selected ] forState:UIControlStateSelected];
    [self setImage:[UIImage imageNamed:selected ] forState:UIControlStateHighlighted];
}

- (void)addImage:(UIImage *)image withSize:(CGSize)size withMargleft:(CGFloat)marginLeft
{
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.image = image;
    [self addSubview:imgView];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.leading.mas_equalTo(self).offset(marginLeft);
        make.width.equalTo(@(size.width));
        make.height.equalTo(@(size.height));
    }];
}

@end
