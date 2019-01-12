//
//  MySearchController.m
//  uTel
//
//  Created by Jay on 27/10/2017.
//  Copyright © 2017 XIN QIANG TECHNOLOGY TRADE CO., LTD. All rights reserved.
//

#import "MySearchController.h"
#import "UIColor+UI.h"
@interface MySearchController ()

@end

@implementation MySearchController

+ (MySearchController *)instance:(id<UISearchResultsUpdating>)searchResultsUpdaterDelegate withSearchDelegate:(id<UISearchBarDelegate>)searchBarDelegate{
    return [self instance:searchResultsUpdaterDelegate withSearchDelegate:searchBarDelegate withSearchResultController:nil];
}

+ (MySearchController *)instance:(id<UISearchResultsUpdating>)searchResultsUpdaterDelegate withSearchDelegate:(id<UISearchBarDelegate>)searchBarDelegate withSearchResultController:(UIViewController *)resultVC{
    MySearchController *searchController = [[MySearchController alloc] initWithSearchResultsController:resultVC];
    [searchController changeBarTintColor:[UIColor whiteColor] withNormal:YES];
    [searchController changeSearchFieldColor:[UIColor SearchTextFieldBgColor]];
    [searchController.searchBar sizeToFit];
    // 设置结果更新代理
    searchController.searchResultsUpdater = searchResultsUpdaterDelegate;
    // 因为在当前控制器展示结果, 所以不需要这个透明视图
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.searchBar.delegate = searchBarDelegate;
    return searchController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.searchBar sizeToFit];
    self.dimsBackgroundDuringPresentation = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
//    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)changeBarTintColor:(UIColor *)barTintColor withNormal:(BOOL)normal{
    UISearchBar *searchBar = self.searchBar;
    UIImageView *barImageView = [[[searchBar.subviews firstObject] subviews] firstObject];
    barImageView.layer.borderColor = [barTintColor CGColor];
    barImageView.layer.borderWidth = normal ? 1 : 0;
    self.searchBar.barTintColor = barTintColor;
}

- (void)changeSearchCancelButton{
    //找到取消按钮
    UIButton *cancleBtn = [self.searchBar valueForKey:@"cancelButton"];
    //修改标题和标题颜色
    [cancleBtn setTitle:NSLocalizedString(@"Cancle", @"") forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}


- (void)changeSearchFieldColor:(UIColor *)color
{
    NSArray *views = self.searchBar.subviews;
    for (UIView *view in views) {
        NSArray *views2 = view.subviews;
        for (UIView *v2 in views2) {
            if([v2 isKindOfClass:[UITextField class]])
            {
                v2.backgroundColor = color;
                //[ViewUtil setCorner:v2 withCorner:5 withBorder:[ConfigureFile bottomTopLineColor] withBorderWidth:0.5];
                [v2 addConer:8 withBorderWidth:0.5 withBorderColor:[UIColor SearchTextFieldBgColor]];
            }
        }
    }
} 

@end
