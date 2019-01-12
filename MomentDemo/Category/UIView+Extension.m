//
//  UIView+Extension.m
//  Manager
//
//  Created by Young on 15/11/27.
//  Copyright (c) 2015年 LXJ. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

//x属性的get,set
-(void)setX:(CGFloat)x
{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
}
-(CGFloat)x
{
    return self.frame.origin.x;
}
//centerX属性的get,set
-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center=self.center;
    center.x=centerX;
    self.center=center;
}
-(CGFloat)centerX
{
    return self.center.x;
}
//centerY属性的get,set
-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center=self.center;
    center.y=centerY;
    self.center=center;
}
-(CGFloat)centerY
{
    return self.center.y;
}
//y属性的get,set
-(void)setY:(CGFloat)y
{
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
}
-(CGFloat)y
{
    return self.frame.origin.y;
}
//width属性的get,set
-(void)setWidth:(CGFloat)width
{
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;
}
-(CGFloat)width
{
    return self.frame.size.width;
}
//height属性的get,set
-(void)setHeight:(CGFloat)height
{
    CGRect frame=self.frame;
    frame.size.height=height;
    self.frame=frame;
}
-(CGFloat)height
{
    return self.frame.size.height;
}
//size属性的get,set
-(void)setSize:(CGSize)size
{
    CGRect frame=self.frame;
    frame.size.width=size.width;
    frame.size.height=size.height;
    self.frame=frame;
}
-(CGSize)size
{
    return self.frame.size;
}
//origin属性的get,set,用于设置坐标
-(void)setOrigin:(CGPoint)origin
{
    CGRect frame=self.frame;
    frame.origin.x=origin.x;
    frame.origin.y=origin.y;
    self.frame=frame;
}
-(CGPoint)origin
{
    return self.frame.origin;
}

- (void)addConer:(float)corner withBorderWidth:(float)borderWidth withBorderColor:(UIColor *)borderColor
{
    if(borderColor){self.layer.borderColor = borderColor.CGColor;}
    self.layer.borderWidth = borderWidth;
    self.layer.cornerRadius = corner;
    self.layer.masksToBounds = YES;
}

- (CGFloat)convertHeight:(CGFloat)height
{
    CGFloat scale = (height /  667);
    return (scale * SCREEN_HEIGHT);
}

- (CGFloat)convertWidth:(CGFloat)width
{
    CGFloat scale = (width /  375);
    return (scale * SCREEN_WIDTH);
}

+ (void)setTintColor:(UIColor *)tintColor forImgView:(UIImageView *)imageView
{
    imageView.tintColor = tintColor;
    UIImage *img = imageView.image;
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    imageView.image = img;
}

+ (void)setTintColorForButton:(UIColor *)tintColor button:(UIButton *)button image:(UIImage *)image
{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateSelected];
    button.tintColor = tintColor;
}

+ (UILabel *)lbl:(UIColor *)color font:(UIFont *)font value:(NSString *)val
{
    UILabel *lbl = [[UILabel alloc]init];
    lbl.text = val;
    lbl.textColor = color;
    lbl.font = font;
    return lbl;
}

+ (UITextField *)field:(UIColor *)color font:(UIFont *)font value:(NSString *)val placeholder:(NSString *)placeholder
{
    UITextField *lbl = [[UITextField alloc]init];
    lbl.text = val;
    lbl.textColor = color;
    lbl.font = font;
    lbl.placeholder = placeholder;
    return lbl;
}

+ (UIButton *)btn:(UIColor *)color font:(UIFont *)font value:(NSString *)val
{
    UIButton *lbl = [[UIButton alloc]init];
    [lbl setTitle:val forState:UIControlStateNormal];
    [lbl setTitle:val forState:UIControlStateHighlighted];
    [lbl setTitleColor:color forState:UIControlStateNormal];
    [lbl setTitleColor:color forState:UIControlStateHighlighted];
     
    lbl.titleLabel.font = font;
    return lbl;
}

- (UIView *)addLine:(UIColor *)lineColor withUp:(BOOL)up marginLeft:(CGFloat)marginLeft marginRight:(CGFloat)marginRight
{
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = lineColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(marginLeft);
        make.trailing.mas_equalTo(self).offset(-marginRight);
        make.height.equalTo(@0.5);
        if(up)
        {
            make.top.mas_equalTo(self);
        }else
        {
         make.bottom.mas_equalTo(self);
        }
    }];
    return line;
}

- (void)addRightArrow
{
    UIImageView *righgArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    [self addSubview:righgArrow];
    [righgArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@7);
        make.height.equalTo(@12);
        make.centerY.mas_equalTo(self);
        make.trailing.mas_equalTo(self).offset(-12);
    }];
}



@end
