//
//  VETDiscoverViewController.m
//
//
//  Created by  on 2017/9/27.
//  Copyright © 2017年  All rights reserved.
//

#import "VETDiscoverViewController.h"
#import "VETDiscoverTableView.h"
#import "VETContactTitleView.h"
#import "VETNearPeopleTableView.h"
#import "YYEditViewController.h"
#import "VETNavigationController.h"

@interface VETDiscoverViewController ()<VETContactTitleViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) VETContactTitleView *titleView;
@property (nonatomic,strong) UIView *divideLineView;
@property (nonatomic,strong) UIScrollView *containerView;
@property (nonatomic,strong) VETDiscoverTableView *discoverTableView;
@property (nonatomic,strong) VETNearPeopleTableView *nearTableView;
@property (nonatomic,strong) UIBarButtonItem *discoverWriteButton;
@property (nonatomic,strong) UIBarButtonItem *nearMenuButton;

@end

@implementation VETDiscoverViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed  = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.titleView;
    [self setNavWithWhiteBackground];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)setupUI{
    [self.view addSubview:self.containerView];
    [self.view addSubview:self.divideLineView];
    self.discoverTableView.viewController = self;
    self.navigationItem.rightBarButtonItem = self.discoverWriteButton;
}


- (void)setupLayout{
    [self.divideLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
        make.top.equalTo(@(TopNavHeight + 1));
        make.height.equalTo(@(1));
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.divideLineView.mas_bottom);
    }];
}

#pragma mark - getter

- (UIBarButtonItem *)nearMenuButton{
    if(!_nearMenuButton){
        _nearMenuButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"friend_nearly_ico_more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(nearMenuAction)];
    }
    return _nearMenuButton;
}

- (UIBarButtonItem *)discoverWriteButton{
    if(!_discoverWriteButton){
        _discoverWriteButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"friend_ico_post"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(discoverWriteAction)];
//        _discoverWriteButton.tintColor = [UIColor clearColor];
    }
    return _discoverWriteButton;
}

#pragma -mark Action
- (void)nearMenuAction{ 
    UIAlertAction *allAction = [UIAlertAction actionWithTitle:[@"NearPeople.All" localized] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *manAction = [UIAlertAction actionWithTitle:[@"NearPeople.Man" localized] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *famelAction = [UIAlertAction actionWithTitle:[@"NearPeople.Famel" localized] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:[@"Cancle" localized] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:allAction];
    [alertVC addAction:manAction];
    [alertVC addAction:famelAction];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
- (void)discoverWriteAction{

    YYEditViewController *vc = [[YYEditViewController alloc]init];
    vc.photoArray = [[NSMutableArray alloc]init];//WithArray: @[[UIImage imageNamed:@"14183410"]]];
    VETNavigationController *nav = [[VETNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}


- (VETContactTitleView *)titleView{
    if(!_titleView){
        _titleView = [[VETContactTitleView alloc]init:@[[@"Discover" localized],[@"NearPeople" localized]]];
        _titleView.delegate = self;
    }
    return _titleView;
}
- (UIView *)divideLineView{
    if(!_divideLineView){
        _divideLineView = [[UIView alloc]init];
        _divideLineView.backgroundColor = [UIColor colorWithHexString:@"#edeeee"];
    }
    return _divideLineView;
}

- (UIScrollView *)containerView{
    if(!_containerView){
        _containerView = [[UIScrollView alloc]init];
        _containerView.pagingEnabled = YES;
        _containerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT - TabbarHeight - TopNavHeight - 1));
        _containerView.delegate = self;
        _containerView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, (SCREEN_HEIGHT - TabbarHeight - TopNavHeight - 10));
        _containerView.showsHorizontalScrollIndicator = NO;
        [_containerView addSubview:self.discoverTableView];
        [_containerView addSubview:self.nearTableView];
    }
    return _containerView;
}

-(VETDiscoverTableView *)discoverTableView{
    if(!_discoverTableView){
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, self.containerView.frame.size.height);
        _discoverTableView = [[VETDiscoverTableView alloc]initWithFrame:frame];
    } 
    return _discoverTableView;
}

- (VETNearPeopleTableView *)nearTableView{
    if(!_nearTableView){
        CGRect frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.containerView.frame.size.height);
        _nearTableView = [[VETNearPeopleTableView alloc]initWithFrame:frame];
    }
    return _nearTableView;
}

#pragma -mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int offset = ((int)scrollView.contentOffset.x);
    if(offset % ((int)SCREEN_WIDTH) == 0){
        int index = (offset / SCREEN_WIDTH);
        [_titleView setSelectedIndex:index];
        self.navigationItem.rightBarButtonItem = (index == 0) ? self.discoverWriteButton : self.nearMenuButton;
    }
}

#pragma -mark VETContactTitleViewDelegate
- (void)didItemClick:(NSInteger)index{
    self.containerView.contentOffset = CGPointMake(index * SCREEN_WIDTH, 0);
    self.navigationItem.rightBarButtonItem = (index == 0) ? self.discoverWriteButton : self.nearMenuButton;
}

@end
