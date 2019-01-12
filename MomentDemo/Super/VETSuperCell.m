//
//  VETSuperCell.m
//  
//
//  Created by JAY on 2019/1/9.
//  Copyright © 2019 . All rights reserved.
//

#import "VETSuperCell.h"

@implementation VETSuperCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setupUI];
        [self setupLayout];
    }
    return self;
}

- (void)setupUI{}

- (void)setupLayout{}

@end
