//
//  VETPhotoContainerView.m
//  SDAutoLayout 测试 Demo
//
//  Created by gsd on 15/12/23.
//  Copyright © 2015年 gsd. All rights reserved.
//


#import "VETPhotoContainerView.h"

#import <UIImageView+WebCache.h>

#import "VETPhotoGroupView.h"


@interface VETPhotoContainerView ()

@property (nonatomic, strong) NSArray *imageViewsArray;

@end

@implementation VETPhotoContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.backgroundColor = [UIColor grayColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imageViewsArray = [temp copy];
}


- (void)setPicPathStringsArray:(NSArray *)picPathStringsArray
{
    _picPathStringsArray = picPathStringsArray;
    
    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_picPathStringsArray.count == 0) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 0, 0);
        return;
    }
    
    CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringsArray];
    CGFloat itemH = 0;
    if (_picPathStringsArray.count == 1) {
           itemH = itemW;
    } else {
        itemH = itemW;
    }
    long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];
    CGFloat margin = 5;
    
    [_picPathStringsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
        imageView.hidden = NO;

        NSURL * url = [NSURL URLWithString:_picPathStringsArray[idx]];
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolderImg"] options:SDWebImageRetryFailed];
        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
    }];
    
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;

    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, w, h);
}

#pragma mark - private actions

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *fromView = nil;
    NSMutableArray * items = [NSMutableArray array];
    for (int i = 0; i < _picPathStringsArray.count; i++) {
        UIView * imgView = _imageViewsArray[i];
        VETPhotoGroupItem * item = [VETPhotoGroupItem new];
        item.thumbView = imgView;
        item.largeImageURL = [NSURL URLWithString:_picPathStringsArray[i]];
        [items addObject:item];
        if (i == tap.view.tag) {
            fromView = imgView;
        }
    }
    
    VETPhotoGroupView *v = [[VETPhotoGroupView alloc] initWithGroupItems:items];
    v.superView = self.superView;
    [v presentFromImageView:fromView toContainer:self.window animated:YES completion:nil];
}

#define PhotoContainerOnePicWidth 162
#define PhotoContainerItemWidth 90

- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    if (array.count == 1) {
        return PhotoContainerOnePicWidth;
    } else {
        if (_customImgWidth != 0) {
            return _customImgWidth;
        }else{
            //CGFloat w = SCREENWIDTH > 320 ? 90 : 70;
            return PhotoContainerItemWidth;
        }
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count < 4) {
        return array.count;
    } else if (array.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}

+ (CGSize)getContainerSizeWithPicPathStringsArray:(NSArray *)picPathStringsArray
{
    CGFloat itemW = picPathStringsArray.count == 1 ? PhotoContainerOnePicWidth : PhotoContainerItemWidth;
    CGFloat itemH = 0;
    if (picPathStringsArray.count == 1) {
        itemH = itemW;
    } else {
        itemH = itemW;
    }
    long perRowItemCount;
    if (picPathStringsArray.count < 4) {
        perRowItemCount = picPathStringsArray.count;
    } else if (picPathStringsArray.count == 4) {
        perRowItemCount = 2;
    } else {
        perRowItemCount = 3;
    }
    CGFloat margin = 5;
    
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(picPathStringsArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    
    return CGSizeMake(w, h);
}

@end
