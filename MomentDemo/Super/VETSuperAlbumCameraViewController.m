//
//  VETSuperAlbumCameraViewController.m
//  
//
//  Created by JAY on 2019/1/9.
//  Copyright © 2019 . All rights reserved.
//

#import "VETSuperAlbumCameraViewController.h"
#import <AssetsLibrary/ALAsset.h>
#import <Photos/PHPhotoLibrary.h>
#import "MLSelectPhotoPickerViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface VETSuperAlbumCameraViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIImagePickerController *cameraPickerVC;
}
@end

@implementation VETSuperAlbumCameraViewController


- (void)didSetPhotos:(NSMutableArray *)photos{
}

//显示选择图片和拍照的对话框，并且包含有权限判断
- (void)showPickImgDialog:(NSInteger)maxCount {
    _photos = [NSMutableArray array];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:[@"Discover.TakePhoto" localized] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            if (![self checkCamera]) {
                
                UIAlertAction *settingAction = [UIAlertAction actionWithTitle:[@"Common.Settings" localized] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }];
                UIAlertAction *gotItAction = [UIAlertAction actionWithTitle:[@"Discover.IGotIt" localized] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:[@"Discover.CameraUnavailable" localized] message:[@"Discover.CameraUnavailable.Hint" localized] preferredStyle:UIAlertControllerStyleActionSheet];
                [alertVC addAction:settingAction];
                [alertVC addAction:gotItAction];
                
                [self presentViewController:alertVC animated:YES completion:nil];
                
            } else {
                
                // 创建UIImagePickerController实例
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                // 设置代理
                imagePickerController.delegate = self;
                // 是否显示裁剪框编辑（默认为NO），等于YES的时候，照片拍摄完成可以进行裁剪
                imagePickerController.allowsEditing = YES;
                // 设置照片来源为相机
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                // 设置进入相机时使用前置或后置摄像头
                imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                // 展示选取照片控制器 
                cameraPickerVC = imagePickerController;
                [self presentViewController:cameraPickerVC animated:YES completion:nil];
            }
        }
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:[@"Discover.Album" localized] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (![self checkPhotoLibrary]) {
            
            UIAlertAction *gotItAction = [UIAlertAction actionWithTitle:[@"Discover.IGotIt" localized] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            UIAlertAction *settingAction = [UIAlertAction actionWithTitle:[@"Common.Settings" localized] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];

            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:[@"Discover.AlbumUnavailable" localized] message:[@"Discover.AlbumUnavailable.Hint" localized] preferredStyle:UIAlertControllerStyleActionSheet];
            [alertVC addAction:settingAction];
            [alertVC addAction:gotItAction];
            [self presentViewController:alertVC animated:YES completion:nil];
            
        } else {
            MLSelectPhotoPickerViewController *pickerVc = [MLSelectPhotoPickerViewController new];
            [pickerVc setMaxCount:maxCount];
            [pickerVc setStatus:PickerViewShowStatusCameraRoll];
            [pickerVc showPickerVc:self];
            __weak typeof(self) weakSelf = self;
            [pickerVc setCallBack:^(NSArray *assets) {
                [assets enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
                    UIImage *photo = [MLSelectPhotoPickerViewController getImageWithObj:asset];
                    [weakSelf.photos addObject:photo];
                }];
                [weakSelf didSetPhotos:self.photos];
            }];
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:[@"Cancle" localized] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:cameraAction];
    [alertVC addAction:albumAction];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if ([info[@"UIImagePickerControllerMediaType"] isEqualToString:@"public.image"]) {
        NSString *imageType = picker.allowsEditing?
    UIImagePickerControllerEditedImage:
        UIImagePickerControllerOriginalImage;
        UIImage *image = [UIImage fixOrientation:[info objectForKey:imageType]];
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            [self.photos addObject:image];
        }
        __weak typeof(self) weakSelf = self;
        [picker dismissViewControllerAnimated:YES completion:^{
            [weakSelf didSetPhotos:self.photos];
        }];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 保存照片到相册中
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) {
        NSLog(@"保存照片成功");
    }
}

#pragma mark -
- (BOOL)checkCamera {
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authorStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authorStatus == AVAuthorizationStatusRestricted ||
        authorStatus == AVAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

- (BOOL)checkPhotoLibrary {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
    {
        return NO;
    }
    return YES;
}

@end
