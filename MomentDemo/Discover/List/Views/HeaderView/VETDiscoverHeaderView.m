
//
//  VETDiscoverHeaderView.m
//  
//
//  Created by JAY on 2019/1/8.
//  Copyright © 2019 . All rights reserved.
//

#import "VETDiscoverHeaderView.h"

@interface VETDiscoverHeaderView()
@property (nonatomic,strong) UIImageView *avatarView;
@property (nonatomic,strong) UILabel *commentLbl;
@property (nonatomic,strong) UIView *containerView;
@end

@implementation VETDiscoverHeaderView

- (void)setupUI{
    [self addSubview:self.containerView];
}
- (void)setupLayout{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(30));
        make.center.mas_equalTo(self);
    }];
}

- (UIImageView *)avatarView{
    if(!_avatarView){
        _avatarView = [[UIImageView alloc]init];
        _avatarView.image = [UIImage imageNamed:@"14126650"];
        [_avatarView addConer:12.5 withBorderWidth:0 withBorderColor:nil];
    }
    return _avatarView;
}
- (UIView *)containerView{
    if(!_containerView){
        _containerView = [[UIView alloc]init];
        _containerView.backgroundColor = [UIColor colorWithHexString:@"#CED2D2"];
        [_containerView addConer:15 withBorderWidth:0 withBorderColor:nil];
        [_containerView addSubview:self.avatarView];
        [_containerView addSubview:self.commentLbl];
        
        [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(_containerView.mas_leading).offset(2.5);
            make.width.height.equalTo(@(25));
            make.centerY.mas_equalTo(_containerView);
        }];
        [self.commentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.avatarView.mas_trailing).offset(3);
            make.centerY.mas_equalTo(_containerView);
            make.trailing.mas_equalTo(_containerView.mas_trailing).offset(-5);
        }];
    }
    return _containerView;
}

- (UILabel *)commentLbl{
    if(!_commentLbl){
        _commentLbl = [[UILabel alloc]init];
        _commentLbl.textColor = [UIColor colorWithHexString:@"#333333"];
        _commentLbl.font = [UIFont systemFontOfSize:14];
        _commentLbl.textAlignment = NSTextAlignmentCenter;
        _commentLbl.text = @"Amy评论了你";
    }
    return _commentLbl;
}


@end
