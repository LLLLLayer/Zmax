//
//  ZMAXSelectorCollectionViewCell.m
//  Zmax
//
//  Created by 杨杰 on 2021/3/16.
//

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXSelectorCollectionViewCell.h"

@interface ZMAXSelectorCollectionViewCell ()

@property (nonatomic, strong) UIView *baseView;

@end

@implementation ZMAXSelectorCollectionViewCell

+ (NSString *)identifier
{
    return NSStringFromClass([ZMAXSelectorCollectionViewCell class]);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.baseView];
        self.baseView.frame = self.contentView.bounds;
        [self.baseView addSubview:self.titleLabel];
        self.titleLabel.frame = self.contentView.bounds;
    }
    return self;
}

- (UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor colorNamed:ZMAXUIColorCellBackGroundColor];
        _baseView.layer.cornerRadius = GENREAL_RADIUS;
        _baseView.layer.shadowColor = [UIColor blackColor].CGColor;
        _baseView.layer.shadowOpacity = 0.1;
        _baseView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    }
    return _baseView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16.0 weight:0.2];
    }
    return _titleLabel;
}


@end
