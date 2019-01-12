//
//  ViewController.m
//  MomentDemo
//
//  Created by JAY on 2019/1/12.
//  Copyright © 2019 JAY. All rights reserved.
//

#import "ViewController.h"
#import "VETDiscoverViewController.h"
#import "VETNavigationController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)toMomentAction:(id)sender {
    VETDiscoverViewController *vc = [[VETDiscoverViewController alloc]init];
    VETNavigationController *nav = [[VETNavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
