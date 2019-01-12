//
//  VETPhotoContainerView.h
//  
//
//  Created by gsd on 15/12/23.
//  Copyright © 2015年  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VETPhotoContainerView : UIView

@property (nonatomic, strong) NSArray *picPathStringsArray;

@property (nonatomic, strong) UIViewController * superView;
@property (nonatomic, assign) int customImgWidth;

+ (CGSize)getContainerSizeWithPicPathStringsArray:(NSArray *)picPathStringsArray;

@end
