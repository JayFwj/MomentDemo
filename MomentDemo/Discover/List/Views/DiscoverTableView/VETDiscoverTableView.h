//
//  VETDiscoverTableView.h
//  
//  朋友圈列表
//  Created by JAY on 2019/1/9.
//  Copyright © 2019 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
NS_ASSUME_NONNULL_BEGIN

@interface VETDiscoverTableView : UITableView

@property(nonatomic,copy)NSString * dynamicsUserId;
@property(nonatomic,strong)NSMutableArray * layoutsArr;
@property(nonatomic,copy)NSString * toUserName;
@property(nonatomic,assign)NSIndexPath * commentIndexPath;
@property(nonatomic,strong)UITextField * commentInputTF;

@property(nonatomic,strong) UIViewController *viewController;

@end

NS_ASSUME_NONNULL_END
