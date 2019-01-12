//
//  VETNearPeopleTableView.m
//  
//
//  Created by JAY on 2019/1/9.
//  Copyright © 2019 . All rights reserved.
//

#import "VETNearPeopleTableView.h"
#import "VETNearPeopleTableCell.h"

@interface VETNearPeopleTableView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UILabel *headerLbl;
@property (nonatomic,strong) UISwitch *headerSwitch;
@end

@implementation VETNearPeopleTableView
 
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self registerClass:[VETNearPeopleTableCell class] forCellReuseIdentifier:@"VETNearPeopleTableCell"];
        self.delegate       = self;
        self.dataSource     = self;
        self.tableHeaderView = self.headerView;
    }
    return self;
}

#pragma -mark TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VETNearPeopleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VETNearPeopleTableCell" forIndexPath:indexPath];
    cell.separatorInset = UIEdgeInsetsMake(0, 67, 0, 0);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma Views
- (UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _headerView.backgroundColor = [UIColor whiteColor];
        [_headerView addSubview:self.headerLbl];
        [_headerView addSubview:self.headerSwitch];
        [_headerView addLine:[UIColor colorWithHexString:@"#CDCCD0"] withUp:NO marginLeft:0 marginRight:0];
        [self.headerLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(_headerView).offset(12);
            make.centerY.mas_equalTo(_headerView);
        }];
        [self.headerSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(_headerView).offset(-14);
            make.centerY.mas_equalTo(_headerView);
            make.width.equalTo(@(49));
            make.height.equalTo(@(28));
        }];
    }
    return _headerView;
}

- (UILabel *)headerLbl{
    if(!_headerLbl){
        _headerLbl = [[UILabel alloc]init];
        _headerLbl.font = [UIFont systemFontOfSize:16];
        _headerLbl.textColor = [UIColor colorWithHexString:@"#333333"];
        _headerLbl.text = [@"NearPeople.Visible" localized];
    }
    return _headerLbl;
}

- (UISwitch *)headerSwitch{
    if(!_headerSwitch){
        _headerSwitch = [[UISwitch alloc]init];
    }
    return _headerSwitch;
}

@end
