//
//  UIImage+Extension.h
//  
//
//  Created by  on 16/8/10.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
+ (UIImage *)fixOrientation:(UIImage *)aImage;
+ (UIImage *)compressSourceImage:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
@end
