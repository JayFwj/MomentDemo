//
//  YYEditViewController.m
//  
//
//  Created by  on 16/8/1.
//  Copyright © 2016年 . All rights reserved.
//

#import "YYEditViewController.h"
#import "CustomTextView.h"
#import "YYPhotosView.h"
#import "YYBottomView.h"
#import <AssetsLibrary/ALAsset.h>
#import <AVFoundation/AVFoundation.h>
#import "MLSelectPhotoBrowserViewController.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "UIView+MLExtension.h"
#import "UIBarButtonItem+Extension.h"
#import "VETNavigationController.h"
#import "VETLocationViewController.h"
@interface YYEditViewController ()<UIScrollViewDelegate,UITextViewDelegate,YYPhotosViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,VETLocationViewControllerDelegate>
@property (nonatomic, strong) CustomTextView   *textView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) YYPhotosView *photosView;
@property (nonatomic, strong) YYBottomView *bottomView;
@property (nonatomic, strong) AMapPOI *selectedMapPOI;
@end

@implementation YYEditViewController

#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.photoArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem barButtonItemWithTitle:[@"Cancle" localized] titleColor:[UIColor colorWithHexString:@"#000000"] target:self action:@selector(cancelBtnClick)];
    self.navigationItem.rightBarButtonItem =
    [UIBarButtonItem barButtonItemWithTitle:[@"Discover.Publish" localized] titleColor:[UIColor colorWithHexString:@"#25CFFF"] target:self action:@selector(sendBtnClick)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard) name:hideKeyboardNotification object:nil];
    [self setupSubView];
    [self setNavWithWhiteBackground];
}

- (void)setupSubView {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.textView];
    [self.scrollView addSubview:self.photosView];
    [self.scrollView addSubview:self.bottomView];
}

- (void)hideKeyboard {
    [self.textView endEditing:YES];
}

#pragma mark -
- (void)sendBtnClick {
    UIImage *compressImg = nil;
    for (NSInteger i = 0; i < [self.photoArray count]; i++) {
        NSData *imageData = UIImageJPEGRepresentation(self.photoArray[i], 0.5);
        UIImage *newImage = [UIImage imageWithData:imageData];
        compressImg = [UIImage compressSourceImage:newImage
                                       targetWidth:[UIScreen mainScreen].bounds.size.width];
        NSLog(@"压缩比例前:%@",newImage);
        NSLog(@"压缩比例后:%@",compressImg);
    }
    //[self.photoArray removeAllObjects];
    [self.view showMessageWithText:@"send"];
}

- (void)cancelBtnClick {
    UIAlertAction *leaveAction = [UIAlertAction actionWithTitle:[@"Confirm" localized] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self.textView isFirstResponder]) {
            [self.textView endEditing:YES];
        }
        [self.photoArray removeAllObjects];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:[@"Cancle" localized] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:[@"Discover.Publish.LeaveAlert" localized] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:leaveAction];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[_textView class]]) {
        //[self.textView becomeFirstResponder];
    } else {
        [self.textView endEditing:YES];
    }
}

#pragma mark - viewWillLayoutSubviews
- (void)viewWillLayoutSubviews {
    CGFloat x = 20;
    CGFloat width = (self.view.ml_width - (x * 2));
    [self.photosView setFrame:
     CGRectMake(x, CGRectGetMaxY(_textView.frame) + 10, width, _photosView.imageMaxHeight + 8)];
    [self.bottomView setNeedsLayout];
    [self.bottomView setFrame:CGRectMake(x, CGRectGetMaxY(_photosView.frame) + 50, width, 45)];
    [self updatePublishBtnStatus];
}

- (void)updatePublishBtnStatus{
    if (![self.photoArray count] && self.textView.text.length == 0) {
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    } else {
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }
}

- (void)bottomViewBtnClick:(UIButton *)button {
    VETLocationViewController *vc = [[VETLocationViewController alloc]init];
    vc.delegate = self;
    VETNavigationController *nav = [[VETNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)textViewDidChange:(UITextView *)textView{
    [self updatePublishBtnStatus];
}

#pragma mark - YYPhotosViewDelegate
- (void)photosView:(YYPhotosView *)photosView withImgCount:(NSInteger)imgCount {
    if ([self.textView isFirstResponder]) {
        [self.textView endEditing:YES];
    }
    [self showPickImgDialog:(9 - self.photoArray.count)];
}

- (void)didSetPhotos:(NSMutableArray *)photos{
    [self.photoArray appendObjects:photos];
    [self.photosView addImages:self.photoArray];
    [self.view setNeedsLayout];
}
- (void)didDeletePhoto:(NSArray *)photos{
    self.photoArray = [[NSMutableArray alloc]initWithArray:photos];
    [self.view setNeedsLayout];
}

#pragma -mark VETLocationViewControllerDelegate
- (void)didReceivedSelectedLoc:(AMapPOI *)mapPOI{
    self.selectedMapPOI = mapPOI;
    [self.bottomView setSelectedLocation:mapPOI.name];
}

#pragma mark -
- (CustomTextView *)textView {
    if (!_textView) {
        _textView = [[CustomTextView alloc] init];
        _textView.backgroundColor = [UIColor whiteColor];
        [_textView setFrame:CGRectMake(18, 22, (self.view.ml_width - 2*22), 80)];
        _textView.placeHolder = [@"Discover.Hint" localized];
        _textView.textColor = [UIColor colorWithHexString:@"#000000"];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.placeHolderColor = [UIColor lightGrayColor];
        _textView.textContainerInset = UIEdgeInsetsMake(10, 3, 0, 0);
        _textView.alwaysBounceVertical = YES;
        [_textView becomeFirstResponder];
        _textView.delegate = self;
    }
    return _textView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        [_scrollView setFrame:CGRectMake(0, 0, self.view.ml_width, self.view.ml_height)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.view.ml_width, self.view.ml_height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (YYPhotosView *)photosView {
    if (!_photosView) {
        _photosView = [[YYPhotosView alloc] init];
        _photosView.delegate = self;
        _photosView.imgCountRow = 3;
        _photosView.backgroundColor = [UIColor whiteColor];
        [_photosView setFrame:CGRectMake(0, CGRectGetMaxY(_textView.frame), self.view.ml_width, 0)];
        [_photosView addImages:self.photoArray];
    }
    return _photosView;
}

- (YYBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [YYBottomView bottomView];
        __weak typeof(self) weakSele = self;
        _bottomView.block = ^(UIButton *button) {
            [weakSele bottomViewBtnClick:button];
        };
    }
    return _bottomView;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
