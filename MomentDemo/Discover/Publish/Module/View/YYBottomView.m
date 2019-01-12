//
//  YYBottomView.m
//  
//
//  Created by  on 16/8/5.
//  Copyright © 2016年 . All rights reserved.
//

#import "YYBottomView.h"
#import "UIView+Extension.h"
#import "NSString+UI.h"
@interface YYBottomView ()
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@property (weak, nonatomic) IBOutlet UIImageView *indicatorIconView;
@property (weak, nonatomic) IBOutlet UILabel *locationLbl;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationLblWidthConstraint;

@end

@implementation YYBottomView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.locationLbl addConer:3 withBorderWidth:0 withBorderColor:nil];
    [self.locationBtn setTag:BtnTypeLocation];
    [self.locationBtn setTitle:[@"Discover.ShowLoc" localized] forState:UIControlStateNormal];
}

/*ico_cancel@3x.png
 order_ico_position.png
 verified_ic_upload.png**/

+ (instancetype)bottomView {
    return [[[NSBundle mainBundle]
             loadNibNamed:@"YYBottomView"
             owner:self
             options:nil] lastObject];
}

- (IBAction)bottomViewBtnClick:(UIButton *)sender {
    if (self.block) {
        self.block(sender);
    }
}
 
- (IBAction)deleteAction:(id)sender {
    [self updateVisible:NO];
}

- (void)setSelectedLocation:(NSString *)selectedLocation{
    self.locationLbl.text = selectedLocation;
    _selectedLocation = selectedLocation;
    CGFloat maxWidth = 120;
    CGFloat width = ([selectedLocation getTxtWidth:30 withFont:self.locationLbl.font] + 10);
    self.locationLblWidthConstraint.constant = (width > maxWidth)?maxWidth:width;
    [self updateVisible:YES];
}

- (void)updateVisible:(BOOL)hideIndicator{
    self.indicatorIconView.hidden = hideIndicator;
    self.locationLbl.hidden = !hideIndicator;
    self.deleteBtn.hidden = self.locationLbl.hidden;
}

@end
