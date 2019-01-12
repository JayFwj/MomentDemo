//
//  VETNearPeopleTableCell.m
//  
//
//  Created by JAY on 2019/1/9.
//  Copyright © 2019 . All rights reserved.
//

#import "VETNearPeopleTableCell.h"

@interface VETNearPeopleTableCell()
@property (nonatomic,strong) UIImageView *avatarImgView;
@property (nonatomic,strong) UIImageView *sexIconView;
@property (nonatomic,strong) UILabel *nickLbl;
@property (nonatomic,strong) UILabel *distanceLbl;
@property (nonatomic,strong) UIView *signatureBgView;
@property (nonatomic,strong) UILabel *signatureLbl;

@end
@implementation VETNearPeopleTableCell

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.avatarImgView];
    [self.contentView addSubview:self.nickLbl];
    [self.contentView addSubview:self.sexIconView];
    [self.contentView addSubview:self.distanceLbl];
    [self.contentView addSubview:self.signatureBgView];
    
    self.avatarImgView.image = [UIImage imageNamed:@"14183410"];
    self.nickLbl.text = @"Molle";
    self.sexIconView.image = [UIImage imageNamed:@"friend_nearly_ico_female"];
    self.distanceLbl.text = [[@"NearPeople.Distance" localized] stringByReplacingOccurrencesOfString:@"DISTANCE" withString:@"300"];
    self.signatureLbl.text = @"天道酬勤，勤能补拙";
//    "NearPeople.Visible" = "是否运行自己被别人查看";
    /*friend_nearly_ico_female@3x.png
     friend_nearly_ico_male@3x.png
     friend_nearly_ico_more@2x.png**/
    
}
- (void)setupLayout{
    [self.avatarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(40));
        make.leading.mas_equalTo(self.contentView).offset(14);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.nickLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImgView.mas_trailing).offset(13);
        make.top.mas_equalTo(self.contentView).offset(8);
    }];
    [self.distanceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nickLbl.mas_leading);
        make.top.mas_equalTo(self.nickLbl.mas_bottom).offset(3);
    }];
    [self.sexIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(11));
        make.height.equalTo(@(13));
        make.leading.mas_equalTo(self.nickLbl.mas_trailing).offset(10);
        make.centerY.mas_equalTo(self.nickLbl.mas_centerY);
    }];
    [self.signatureBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).offset(-14);
        make.height.equalTo(@(40));
        make.width.equalTo(@(130));
        make.centerY.mas_equalTo(self.contentView);
    }];
}

- (UIImageView *)avatarImgView{
    if(!_avatarImgView){
        _avatarImgView = [[UIImageView alloc]init];
        [_avatarImgView addConer:20 withBorderWidth:0 withBorderColor:nil];
    }
    return _avatarImgView;
}

- (UIImageView *)sexIconView{
    if(!_sexIconView){
        _sexIconView = [[UIImageView alloc]init];
        [_sexIconView addConer:20 withBorderWidth:0 withBorderColor:nil];
    }
    return _sexIconView;
}

- (UILabel *)nickLbl{
    if(!_nickLbl){
        _nickLbl = [[UILabel alloc]init];
        _nickLbl.textColor = [UIColor colorWithHexString:@"#333333"];
        _nickLbl.font = [UIFont systemFontOfSize:16];
    }
    return _nickLbl;
}

- (UILabel *)distanceLbl{
    if(!_distanceLbl){
        _distanceLbl = [[UILabel alloc]init];
        _distanceLbl.textColor = [UIColor colorWithHexString:@"#C1C1C4"];
        _distanceLbl.font = [UIFont systemFontOfSize:13];
    }
    return _distanceLbl;
}

- (UILabel *)signatureLbl{
    if(!_signatureLbl){
        _signatureLbl = [[UILabel alloc]init];
        _signatureLbl.textColor = [UIColor colorWithHexString:@"#333333"];
        _signatureLbl.font = [UIFont systemFontOfSize:14];
        _signatureLbl.numberOfLines = 2;
    }
    return _signatureLbl;
}


- (UIView *)signatureBgView{
    if(!_signatureBgView){
        _signatureBgView = [[UIView alloc]init];
        _signatureBgView.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
        [_signatureBgView addConer:3 withBorderWidth:0 withBorderColor:nil];
        [_signatureBgView addSubview:self.signatureLbl];
        [self.signatureLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(_signatureBgView.mas_leading).offset(10);
            make.trailing.mas_equalTo(_signatureBgView.mas_trailing).offset(-10);
            make.top.mas_equalTo(_signatureBgView.mas_top).offset(0);
            make.bottom.mas_equalTo(_signatureBgView.mas_bottom).offset(0);
        }];
    }
    return _signatureBgView;
}



@end
