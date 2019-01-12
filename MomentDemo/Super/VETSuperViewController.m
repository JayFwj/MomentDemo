//
//  VETSuperViewController.m
//  
//
//  Created by JAY on 2018/7/28.
//  Copyright © 2018 . All rights reserved.
//
#import <MessageUI/MessageUI.h>
#import "VETSuperViewController.h"
#import "UIColor+UI.h"
#import "UIImage+LYXExtension.h"
@interface VETSuperViewController ()

@end

@implementation VETSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupLayout];
    [self setupData];
}

- (void)setupUI{
    
}

- (void)setupLayout{
    
}

- (void)setupData{
    
}

- (void)setNavWithWhiteBackground{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#ffffff"] size:CGSizeMake(SCREEN_WIDTH, 1)]];
}
 
@end
