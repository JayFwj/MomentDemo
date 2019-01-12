//
//  UIButton+UI.h
//  
//
//  Created by JAY on 2018/7/27.
//  Copyright © 2018 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (UI)

- (void)setImg:(NSString *)normal  withSelected:(NSString *)selected;

- (void)addImage:(UIImage *)image withSize:(CGSize)size  withMargleft:(CGFloat)marginLeft;

@end
