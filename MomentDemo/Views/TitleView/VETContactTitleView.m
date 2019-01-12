
//
//  VETContactTitleView.m
//  
//
//  Created by JAY on 2019/1/5.
//  Copyright © 2019 . All rights reserved.
//

#import "VETContactTitleView.h"
#import "VETTitleItemView.h"

@interface VETContactTitleView()
@property(nonatomic,strong) NSArray *titles;
@property(nonatomic,strong) UIFont *titleFont;
@end

@implementation VETContactTitleView

- (instancetype)init:(NSArray *)titles
{
    self = [super init];
    if (self) {
        self.titleFont = [UIFont systemFontOfSize:14];
        self.titles = titles;
        [self setupUI];
        [self addConer:5 withBorderWidth:1 withBorderColor:[UIColor colorWithHexString:@"#000000"]];

    }
    return self;
}
#define START_INDEX 10
- (void)setupUI{
    self.backgroundColor = [UIColor orangeColor];
    CGFloat margin = 16;
    CGFloat titleWidth = ([self getMaxTitleWidth] + margin);
    CGFloat titleHeight = 30;
    CGFloat width = (titleWidth * self.titles.count);
    CGFloat startX = (SCREEN_WIDTH - width) / 2;
    for (int i=0; i<self.titles.count; i++) {
        NSString *title = self.titles[i];
        CGRect frame = CGRectMake(( i * titleWidth), 0, titleWidth, titleHeight);
        VETTitleItemView *item = [[VETTitleItemView alloc]initWithFrame:frame];
        item.tag = (START_INDEX + i);
        [item addTarget:self action:@selector(didItemClick:) forControlEvents:UIControlEventTouchUpInside];
        item.titleLabel.font = self.titleFont;
        item.backgroundColor = [UIColor lightGrayColor];
        [item setTitle:title forState:UIControlStateNormal];
        [item showSelectedStyle:(i == 0)];
        if(i == 0){
            item.selectedIndex = i;
        }
        [self addSubview:item];
    }
    self.frame = CGRectMake(startX, 0, width, titleHeight);
    
}

- (void)didItemClick:(VETTitleItemView *)sender{
    long index = (sender.tag - START_INDEX);
    [self setSelectedIndex:index];
    if(self.delegate){
        [self.delegate didItemClick:index];
    }
}
- (void)setSelectedIndex:(long)index{
    VETTitleItemView *item = [self viewWithTag:(START_INDEX + index)];
    if(item.selectedIndex != index){
        item.selectedIndex = index;
         [[NSNotificationCenter defaultCenter] postNotificationName:VETTitleItemViewDidSelectedIndexChanged object:nil userInfo:@{@"SelectedIndex":@(index)}];
    }
   
}

- (CGFloat)getMaxTitleWidth{
    CGFloat lastTitleWidth = 0;
    for (int i=0; i<self.titles.count; i++) {
        NSString *title = self.titles[i];
        CGFloat currentWidth = [title getTxtWidth:30 withFont:self.titleFont];
        if(currentWidth > lastTitleWidth){
            lastTitleWidth = currentWidth;
        }
    }
    return lastTitleWidth;
}

@end
