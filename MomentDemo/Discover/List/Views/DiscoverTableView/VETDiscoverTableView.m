//
//  VETDiscoverTableView.m
//  
//
//  Created by JAY on 2019/1/9.
//  Copyright © 2019 . All rights reserved.
//

#import "VETDiscoverTableView.h"
#import "VETDiscoverHeaderView.h"
#import "VETDiscoverTableViewCell.h"
#import "MJRefreshAutoNormalFooter.h"
#import "NewDynamicsLayout.h"
#import "DynamicsModel.h"

@interface VETDiscoverTableView()<UITableViewDelegate,UITableViewDataSource, NewDynamicsCellDelegate, UITextFieldDelegate>

@property(nonatomic,strong)VETDiscoverHeaderView * discoverHeaderView;

@end

@implementation VETDiscoverTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.tableHeaderView = self.discoverHeaderView;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[VETDiscoverTableViewCell class] forCellReuseIdentifier:@"VETDiscoverTableViewCell"];
        if ([[[UIDevice currentDevice] systemVersion] compare:@"11.0" options:NSNumericSearch] != NSOrderedAscending) {
            self.estimatedRowHeight = 0;
        }
        
        UITapGestureRecognizer * tableViewGesture = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            [_commentInputTF resignFirstResponder];
        }];
        
        tableViewGesture.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tableViewGesture];
        
        [self setupData];
        [self dragUpToLoadMoreData];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setViewController:(UIViewController *)viewController{
    _viewController = viewController;
    [_viewController.view addSubview:self.commentInputTF];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupData{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"moment0" ofType:@"plist"];
    NSArray * dataArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    [self.layoutsArr removeAllObjects];
    for (id dict in dataArray) {
        DynamicsModel * model = [DynamicsModel modelWithDictionary:dict];
        model.pagetype = 0;
        NewDynamicsLayout * layout = [[NewDynamicsLayout alloc] initWithModel:model];
        [self.layoutsArr addObject:layout];
    }
    [self reloadData]; 
}

#pragma -mark Keyboard
- (void)keyboardWillHide:(NSNotification *)notification{
    CGRect frame = _commentInputTF.frame;
    frame.origin.y = self.viewController.view.frame.size.height;
    _commentInputTF.frame = frame;
}

- (void)keyboardFrameWillChange:(NSNotification *)notification{
    CGRect keyBoardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect frame = _commentInputTF.frame;
    frame.origin.y = keyBoardFrame.origin.y - 45;
    _commentInputTF.frame = frame;
}

#pragma mark - 上拉加载更多数据
- (void)dragUpToLoadMoreData{
    // 下拉刷新
    self.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [self.mj_header endRefreshing];
        });
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.mj_header.automaticallyChangeAlpha = YES;
    // 上拉刷新
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadMoreData];
            // 结束刷新
            [self.mj_footer endRefreshing];
        });
    }];
}
- (void)loadMoreData{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"moment1" ofType:@"plist"];
    NSArray * dataArray = [NSArray arrayWithContentsOfFile:plistPath];
    for (id dict in dataArray) {
        DynamicsModel * model = [DynamicsModel modelWithDictionary:dict];
        model.pagetype = 0;
        NewDynamicsLayout * layout = [[NewDynamicsLayout alloc] initWithModel:model];
        [self.layoutsArr addObject:layout];
    }
    [self reloadData];
}

- (VETDiscoverHeaderView *)discoverHeaderView{
    if(!_discoverHeaderView){
        _discoverHeaderView = [[VETDiscoverHeaderView alloc]init];
        _discoverHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    }
    return _discoverHeaderView;
}

-(NSMutableArray *)layoutsArr{
    if (!_layoutsArr) {
        _layoutsArr = [NSMutableArray array];
    }
    return _layoutsArr;
}
-(UITextField *)commentInputTF{
    if (!_commentInputTF) {
        _commentInputTF = [[UITextField alloc] initWithFrame:CGRectMake(0, _viewController.view.frame.size.height, _viewController.view.frame.size.width, 45)];
        _commentInputTF.backgroundColor = [UIColor whiteColor];
        _commentInputTF.delegate = self;
        _commentInputTF.textColor = [UIColor lightGrayColor];
    }
    return _commentInputTF;
}

#pragma mark - TableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewDynamicsLayout * layout = self.layoutsArr[indexPath.row];
    return layout.height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.layoutsArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VETDiscoverTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VETDiscoverTableViewCell"];
    cell.layout = self.layoutsArr[indexPath.row];
    cell.delegate = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - ScollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.commentInputTF resignFirstResponder];
}
#pragma mark - NewDynamiceCellDelegate
-(void)DynamicsCell:(VETDiscoverTableViewCell *)cell didClickUser:(NSString *)userId
{
    NSLog(@"点击了用户");
}
-(void)DidClickMoreLessInDynamicsCell:(VETDiscoverTableViewCell *)cell
{
    NSIndexPath * indexPath = [self indexPathForCell:cell];
    NewDynamicsLayout * layout = self.layoutsArr[indexPath.row];
    layout.model.isOpening = !layout.model.isOpening;
    [layout resetLayout];
    CGRect cellRect = [self rectForRowAtIndexPath:indexPath];
    
    [self reloadData];
    
    if (cellRect.origin.y < self.contentOffset.y + 64) {
        [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}
-(void)DidClickGrayViewInDynamicsCell:(VETDiscoverTableViewCell *)cell
{
    NSLog(@"点击了灰色区域");
}
-(void)DidClickThunmbInDynamicsCell:(VETDiscoverTableViewCell *)cell
{
    NSIndexPath * indexPath = [self indexPathForCell:cell];
    NewDynamicsLayout * layout = self.layoutsArr[indexPath.row];
    DynamicsModel * model = layout.model;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"12345678910",@"userid",@"Jay",@"nick", nil];
    NSMutableArray * newThumbArr = [NSMutableArray arrayWithArray:model.optthumb];
    [newThumbArr addObject:dic];
    model.optthumb = [newThumbArr copy];
    [layout resetLayout];
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)DidClickCancelThunmbInDynamicsCell:(VETDiscoverTableViewCell *)cell
{
    NSIndexPath * indexPath = [self indexPathForCell:cell];
    NewDynamicsLayout * layout = self.layoutsArr[indexPath.row];
    DynamicsModel * model = layout.model;
    
    NSMutableArray * newThumbArr = [NSMutableArray arrayWithArray:model.optthumb];
    WS(weakSelf);
    [newThumbArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary * thumbDic = obj;
        if ([thumbDic[@"userid"] isEqualToString:@"12345678910"]) {
            [newThumbArr removeObject:obj];
            model.optthumb = [newThumbArr copy];
            [layout resetLayout];
            [weakSelf reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            *stop = YES;
        }
    }];
}
-(void)DidClickCommentInDynamicsCell:(VETDiscoverTableViewCell *)cell
{
    NSIndexPath * indexPath = [self indexPathForCell:cell];
    self.commentIndexPath = indexPath;
    
    self.commentInputTF.placeholder = @"输入评论...";
    [self.commentInputTF becomeFirstResponder];
    self.commentInputTF.hidden = NO;
}
-(void)DidClickSpreadInDynamicsCell:(VETDiscoverTableViewCell *)cell
{
    NSLog(@"点击了推广");
}
- (void)DidClickDeleteInDynamicsCell:(VETDiscoverTableViewCell *)cell
{
    WS(weakSelf);
    [UIAlertView bk_showAlertViewWithTitle:nil message:@"是否确定删除朋友圈" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            NSIndexPath * indexPath = [self indexPathForCell:cell];
            [weakSelf beginUpdates];
            [weakSelf.layoutsArr removeObjectAtIndex:indexPath.row];
            [weakSelf deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [weakSelf endUpdates];
        }
    }];
}
-(void)DynamicsCell:(VETDiscoverTableViewCell *)cell didClickUrl:(NSString *)url PhoneNum:(NSString *)phoneNum
{
    if (url) {
        if ([url rangeOfString:@"wemall"].length != 0 || [url rangeOfString:@"t.cn"].length != 0) {
            if (![url hasPrefix:@"http://"]) {
                url = [NSString stringWithFormat:@"http://%@",url];
            }
            NSLog(@"点击了链接:%@",url);
        }else{
            
        }
    }
    if (phoneNum) {
        NSLog(@"点击了电话:%@",phoneNum);
    }
}
#pragma mark - UITextfield Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger commentRow = self.commentIndexPath.row;
    NewDynamicsLayout * layout = [self.layoutsArr objectAtIndex:commentRow];
    DynamicsModel * model = layout.model;
    if (![self.commentInputTF.text isEqualToString:@""]) {
        
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"12345678910",@"userid",@"Jay",@"nick",textField.text,@"message",nil,@"touser",nil,@"tonick", nil];//toUserID可能为nil,需放在最后
        NSMutableArray * newCommentArr = [NSMutableArray arrayWithArray:model.optcomment];
        [newCommentArr addObject:dic];
        model.optcomment = [newCommentArr copy];
        [layout resetLayout];
        [self reloadRowsAtIndexPaths:@[self.commentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        self.commentInputTF.text = nil;
        [self.commentInputTF resignFirstResponder];
    }
    return YES;
}


@end
