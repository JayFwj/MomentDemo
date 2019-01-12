//
//  NewDynamicsLayout.h
//  
//
//  Created by  on 2017/9/27.
//  Copyright © 2017年  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DynamicsModel.h"

#define kDynamicsNormalPadding 5
#define kDynamicsNamePaddingTop 13
#define kDynamicsPortraitLeftPadding 14
#define kDynamicsPortraitWidthAndHeight 40
#define kDynamicsPortraitNamePadding 13
#define kDynamicsNameDetailPadding 8
#define kDynamicsNameHeight 17
#define kDynamicsMoreLessButtonHeight 12
#define kDynamicsSpreadButtonHeight 12
#define kDynamicsGrayBgHeight 51
#define kDynamicsGrayPicHeight 45
#define kDynamicsGrayPicPadding 3
#define kDynamicsThumbTopPadding 14
#define kDynamicsThumbBottomPadding 8

#define kDynamicsSpreadDetailPadding 16
#define kDynamicsTimeSpreadPadding 5
#define kDynamicsBottomPadding 12
#define kDynamicsThumbCommentPadding 8
#define kDynamicsCommentBottomPadding 12
#define kDynamicsCommentRightPadding 15


#define kDynamicsLineSpacing 5

#define kDynamicsHightlightColor [UIColor colorWithHexString:@"#1E7FB7"]
#define kDynamicsNormalColor [UIColor colorWithHexString:@"#333333"]

typedef void(^ClickUserBlock)(NSString * userID);
typedef void(^ClickUrlBlock)(NSString * url);
typedef void(^ClickPhoneNumBlock)(NSString * phoneNum);

@interface NewDynamicsLayout : NSObject

@property(nonatomic,strong)DynamicsModel * model;

@property(nonatomic,strong)YYTextLayout * detailLayout;
@property(nonatomic,assign)CGSize photoContainerSize;
@property(nonatomic,strong)YYTextLayout * dspLayout;
@property(nonatomic,strong)YYTextLayout * thumbLayout;
@property(nonatomic,strong)NSMutableArray * commentLayoutArr;
@property(nonatomic,assign)CGFloat thumbHeight;
@property(nonatomic,assign)CGFloat commentHeight;
@property(nonatomic,assign)CGFloat thumbCommentHeight;
@property(nonatomic,copy)ClickUserBlock clickUserBlock;
@property(nonatomic,copy)ClickUrlBlock clickUrlBlock;
@property(nonatomic,copy)ClickPhoneNumBlock clickPhoneNumBlock;

@property(nonatomic,assign)CGFloat height;

- (instancetype)initWithModel:(DynamicsModel *)model;
- (void)resetLayout;

@end
