//
//  VETTitleItemView.h
//  
//
//  Created by JAY on 2019/1/5.
//  Copyright © 2019 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define VETTitleItemViewDidSelectedIndexChanged @"VETTitleItemViewDidSelectedIndexChanged"
@interface VETTitleItemView : UIButton

@property (nonatomic) NSInteger selectedIndex;
- (void)showSelectedStyle:(BOOL)selected;

@end

NS_ASSUME_NONNULL_END
