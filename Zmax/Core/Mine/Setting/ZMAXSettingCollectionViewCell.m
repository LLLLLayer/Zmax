//
//  ZMAXSettingCollectionViewCell.m
//  Zmax
//
//  Created by 杨杰 on 2021/1/17.
//

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXSettingCollectionViewCell.h"

const CGFloat ZMAXSettingCollectionViewCellHeight = 54.0;
const CGFloat ZMAXSettingCollectionGeneralPadding = 16.0;
static const CGFloat ZMAXSettingCollectionIconWidth = 20.0;

@implementation ZMAXSettingCollectionViewCellModel

@end

@interface ZMAXSettingCollectionViewCell ()

@property (nonatomic, strong) ZMAXSettingCollectionViewCellModel *model;

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UISwitch *settingSwitch;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation ZMAXSettingCollectionViewCell

+ (NSString *)identifier
{
    return NSStringFromClass([ZMAXSettingCollectionViewCell class]);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self __setupUI];
    }
    return self;
}

- (void)__setupUI
{
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.baseView];
    self.baseView.frame = CGRectMake(0.0,
                                     0.0,
                                     SCREEN_WIDTH - ZMAXSettingCollectionGeneralPadding * 2.0,
                                     ZMAXSettingCollectionViewCellHeight);
    
    [self.baseView addSubview:self.titleLable];
    _titleLable.frame = CGRectMake(ZMAXSettingCollectionGeneralPadding,
                                   0.0,
                                   SCREEN_WIDTH / 2.0 - ZMAXSettingCollectionGeneralPadding,
                                   ZMAXSettingCollectionViewCellHeight);
    
    [self.baseView addSubview:self.settingSwitch];
    self.settingSwitch.frame = CGRectMake(self.baseView.frame.size.width - ZMAXSettingCollectionGeneralPadding - self.settingSwitch.frame.size.width,
                                          (self.baseView.frame.size.height - self.settingSwitch.frame.size.height) / 2.0,
                                          self.settingSwitch.frame.size.width,
                                          self.settingSwitch.frame.size.height);
    
    [self.baseView addSubview:self.iconImageView];
    self.iconImageView.frame = CGRectMake(self.baseView.frame.size.width - ZMAXSettingCollectionGeneralPadding - ZMAXSettingCollectionIconWidth,
                                          (self.baseView.frame.size.height - ZMAXSettingCollectionIconWidth) / 2.0,
                                          ZMAXSettingCollectionIconWidth,
                                          ZMAXSettingCollectionIconWidth);
}

- (void)configWithModel:(ZMAXSettingCollectionViewCellModel *)model
{
    self.model = model;
    [self.titleLable setText:self.model.titleText];
    self.settingSwitch.hidden = !self.model.isSwitch;
    [self.settingSwitch setOn:self.model.currentSwitch];
    self.settingSwitch.enabled = self.model.canSwitchChange;
    self.iconImageView.hidden = !self.model.isIcon;
    [self.iconImageView setImage:self.model.currentIcon ?: [UIImage systemImageNamed:@"chevron.compact.right" withConfiguration:[UIImageSymbolConfiguration configurationWithWeight:UIImageSymbolWeightThin]]];
}

#pragma mark - Setter/Getter

- (UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor colorNamed:ZMAXUIColorCellBackGroundColor];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__hanldBaseViewDidTapWithGesture:)];
        [_baseView addGestureRecognizer:gesture];
    }
    return _baseView;
}

- (UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _titleLable.font = [UIFont systemFontOfSize:16.0];
    }
    return _titleLable;
}

- (UISwitch *)settingSwitch
{
    if (!_settingSwitch) {
        _settingSwitch = [[UISwitch alloc] init];
        [_settingSwitch addTarget:self action:@selector(__handleSettingSwitchDidChangeWithAciton:) forControlEvents:UIControlEventValueChanged];
    }
    return _settingSwitch;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithWeight:UIImageSymbolWeightThin];
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.compact.right" withConfiguration:config]];
        _iconImageView.tintColor = [UIColor colorNamed:ZMAXUIColorReverseStandardColor];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleIconImageViewDidTapWithGesture:)];
        [_iconImageView addGestureRecognizer:gesture];
    }
    return _iconImageView;
}

#pragma mark - Action

- (void)__hanldBaseViewDidTapWithGesture:(UITapGestureRecognizer *)gesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(settingCellBaseViewDidTapWithype:)]) {
        [self.delegate settingCellBaseViewDidTapWithype:self.model.type];
    }
}

- (void)__handleSettingSwitchDidChangeWithAciton:(UISwitch *)settingSwitch
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(settingCellSwitchDidChangeWIthType:currentFlag:)]) {
        [self.delegate settingCellSwitchDidChangeWIthType:self.model.type currentFlag:settingSwitch.isOn];
    }
}

- (void)__handleIconImageViewDidTapWithGesture:(UITapGestureRecognizer *)gesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(settingCellIconDidTapWithype:)]) {
        [self.delegate settingCellIconDidTapWithype:self.model.type];
    }
}

@end
