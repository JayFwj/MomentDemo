//
//  UIImage+LYXExtension.h
//  DunyunLock
//
//  Created by young on 16/8/23.
//  Copyright © 2016年 duyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LYXExtension)

+ (UIImage *)imageWithColor:(UIColor *)color ;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *) resizeCodeImage:(CIImage *)image withSize:(CGSize)size;

@end
