//
//  VETContactTitleView.h
//
//
//  Created by JAY on 2019/1/5.
//  Copyright © 2019 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol VETContactTitleViewDelegate <NSObject>

- (void)didItemClick:(NSInteger)index;

@end
@interface VETContactTitleView : UIView

@property (nonatomic,assign) id<VETContactTitleViewDelegate> delegate;
- (instancetype)init:(NSArray *)titles;
- (void)setSelectedIndex:(long)index;
@end

NS_ASSUME_NONNULL_END
