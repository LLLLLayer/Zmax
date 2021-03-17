//
//  ZMAXSelectDisplayView.m
//  Zmax
//
//  Created by 杨杰 on 2021/3/16.
//

#import <Masonry/Masonry.h>
#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXSelectDisplayView.h"

@interface ZMAXSelectDisplayView ()

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *selectView;

@end

@implementation ZMAXSelectDisplayView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __setupUI];
    }
    return self;
}

- (void)__setupUI
{
    [self addSubview:self.baseView];
    [self.baseView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [self.baseView addSubview:self.selectView];
    [self.selectView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseView.mas_right).with.offset(- GENREAL_PADDING);
        make.centerY.equalTo(self.baseView);
        make.width.height.equalTo(@(25));
    }];
    
    [self.baseView addSubview:self.lineView];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.baseView);
        make.left.equalTo(self.baseView.mas_left).with.offset(GENREAL_PADDING);
        make.width.equalTo(@(3.0));
        make.height.equalTo(@(15.0));
    }];
    
    [self.baseView addSubview:self.titleLabel];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView.mas_right).with.offset(GENREAL_PADDING);
        make.top.bottom.equalTo(self.baseView);
        make.right.equalTo(self.selectView.mas_left);
    }];
}

- (UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handelTapBaseView:)];
        [_baseView addGestureRecognizer:gesture];
    }
    return _baseView;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorNamed:ZMAXUIColorBrandBlueColor];
        _lineView.layer.cornerRadius = 2;
    }
    return _lineView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16.0 weight:0.1];
        _titleLabel.alpha = 0.5;
    }
    return _titleLabel;
}

- (UIImageView *)selectView
{
    if (!_selectView) {
        _selectView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.compact.down"]];
        _selectView.tintColor = [UIColor colorNamed:ZMAXUIColorBrandBlueColor];
    }
    return _selectView;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    _baseView.layer.borderColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground].CGColor;
}

- (void)setTitleWithText:(NSString *)text
{
    self.titleLabel.text = text;
}

- (NSString *)getTitle
{
    return self.titleLabel.text;
}

- (void)__handelTapBaseView:(UITapGestureRecognizer *)gesture
{
    BLOCK(self.actionBlock);
}

@end
