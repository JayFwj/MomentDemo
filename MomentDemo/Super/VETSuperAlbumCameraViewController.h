//
//  VETSuperAlbumCameraViewController.h
//  
//
//  Created by JAY on 2019/1/9.
//  Copyright © 2019 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VETSuperViewController.h"
NS_ASSUME_NONNULL_BEGIN


@interface VETSuperAlbumCameraViewController : VETSuperViewController

@property (nonatomic, strong) NSMutableArray *photos;

//显示选择图片和拍照的对话框，并且包含有权限判断
- (void)showPickImgDialog:(NSInteger)maxCount;

- (void)didSetPhotos:(NSMutableArray *)photos;

@end

NS_ASSUME_NONNULL_END
