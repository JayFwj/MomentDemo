//
//  UIView+UI.m
//  SOFTPHONE
//
//  Created by JAY on 2018/8/23.
//  Copyright © 2018 Jiangsu Minle Data Service Co., Ltd. All rights reserved.
//

#import "UIView+UI.h"

@implementation UIView (UI)
//添加拖动事件
- (void)addPanAction{
    UIPanGestureRecognizer *tapGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGSize size = self.frame.size;
    float halfWidth = size.width / 2;
    float halfHeight = size.height / 2;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"FlyElephant---视图拖动开始");
    } else if(recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint location = [recognizer locationInView:self.superview];
        if (location.y < 0 || location.y > self.superview.bounds.size.height) {
            return;
        }
        CGPoint translation = [recognizer translationInView:self.superview];
        
        NSLog(@"当前视图在View的位置:%@----平移位置:%@",NSStringFromCGPoint(location),NSStringFromCGPoint(translation));
        
        
        CGPoint center = CGPointMake(recognizer.view.center.x + translation.x,recognizer.view.center.y + translation.y);
        if((center.x - halfWidth) < 0){
            center.x = halfWidth;
        }
        
        if((center.x + halfWidth) > SCREEN_WIDTH){
            center.x = SCREEN_WIDTH - halfWidth;
        }
        
        if((center.y - halfHeight) < 0){
            center.y = halfHeight;
        }
        
        if((center.y + halfHeight) > SCREEN_HEIGHT){
            center.y = SCREEN_HEIGHT - halfHeight;
        }
        
        recognizer.view.center = center;
        
        [recognizer setTranslation:CGPointZero inView:self.superview];
    
    } else if(recognizer.state == UIGestureRecognizerStateEnded ||
              recognizer.state == UIGestureRecognizerStateCancelled) {
        NSLog(@"FlyElephant---视图拖动结束");
        
        CGPoint point = recognizer.view.center;
        if(point.x < (SCREEN_WIDTH / 2)){
            point.x = halfWidth;
        }else{
            point.x = SCREEN_WIDTH - halfWidth;
        }
//        if(point.y < (SCREEN_HEIGHT / 2)){
//            point.y = halfWidth;
//        }else{
//            point.y = SCREEN_HEIGHT - halfWidth;
//        }
        recognizer.view.center = point;
    }
    
}


@end
