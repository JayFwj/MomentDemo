//
//  UIView+Extension.h
//  Manager
//
//  Created by Young on 15/11/27.
//  Copyright (c) 2015年 LXJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

//x坐标属性
@property (nonatomic,assign)CGFloat x;
//y坐标
@property (nonatomic,assign)CGFloat y;
//宽度
@property (nonatomic,assign)CGFloat width;
//高度
@property (nonatomic,assign)CGFloat height;
//大小
@property (nonatomic,assign)CGSize size;
//位置
@property (nonatomic,assign)CGPoint origin;
//中心点x
@property (nonatomic,assign)CGFloat centerX;
//中心点y
@property (nonatomic,assign)CGFloat centerY;

- (void)addConer:(float)corner withBorderWidth:(float)borderWidth withBorderColor:(UIColor *)borderColor;

- (CGFloat)convertHeight:(CGFloat)height;

- (CGFloat)convertWidth:(CGFloat)width;


+ (void)setTintColor:(UIColor *)tintColor forImgView:(UIImageView *)imageView;

+ (void)setTintColorForButton:(UIColor *)tintColor button:(UIButton *)button image:(UIImage *)image;

+ (UILabel *)lbl:(UIColor *)color font:(UIFont *)font value:(NSString *)val;

+ (UITextField *)field:(UIColor *)color font:(UIFont *)font value:(NSString *)val placeholder:(NSString *)placeholder;

+ (UIButton *)btn:(UIColor *)color font:(UIFont *)font value:(NSString *)val;

- (UIView *)addLine:(UIColor *)lineColor withUp:(BOOL)up marginLeft:(CGFloat)marginLeft marginRight:(CGFloat)marginRight;

- (void)addRightArrow;





@end
