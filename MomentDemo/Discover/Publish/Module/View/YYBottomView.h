//
//  YYBottomView.h
//  
//
//  Created by  on 16/8/5.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnClick)(UIButton *button);

typedef NS_ENUM(NSUInteger, BtnType) {
    BtnTypeLocation,
    BtnTypeMention,
    BtnTypeWhoLook
};

@interface YYBottomView : UIView
+ (instancetype)bottomView;
@property (nonatomic, copy) btnClick block;

@property (nonatomic,strong) NSString *selectedLocation;

@end
