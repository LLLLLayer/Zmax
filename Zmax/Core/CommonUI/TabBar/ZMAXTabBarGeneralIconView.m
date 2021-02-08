//
//  ZMAXTabBarGeneralIconView.m
//  Zmax
//
//  Created by 杨杰 on 2021/1/1.
//

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXTabBarGeneralIconView.h"

static const CGFloat ZMAXTabBarGeneralIconIconTopMargin = 7.0;
static const CGFloat ZMAXTabBarGeneralIconIconWidth = 25.0;
static const CGFloat ZMAXTabBarGeneralIconIconHeight = 21.0;
static const CGFloat ZMAXTabBarGeneralIconTitleTopToIcon = 4.0;
static const CGFloat ZMAXTabBarGeneralIconTitleHeight = 15.0;
// BottomMargin = 54.0 - 7.0 - 21.0 - 4.0 - 15.0 = 7.0

@interface ZMAXTabBarGeneralIconView ()

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;

@end

@implementation ZMAXTabBarGeneralIconView

- (instancetype)initWithNormalImage:(UIImage *)normalImage
                      selectedImage:(UIImage *)selectedImage
                              title:(NSString *)title
{
    self = [super init];
    if (self) {
        [self addSubview:self.baseView];
        [self.baseView addSubview:self.icon];
        [self.baseView addSubview:self.title];
        
        self.normalImage = normalImage;
        self.selectedImage = selectedImage;
        [self.icon setImage:self.normalImage];
        [self.title setText:title];
        
        [self.baseView addSubview:self.tipsView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.baseView.frame = self.bounds;
    
    self.icon.frame = CGRectMake(self.bounds.size.width * 0.5 - ZMAXTabBarGeneralIconIconWidth * 0.5,
                                 ZMAXTabBarGeneralIconIconTopMargin,
                                 ZMAXTabBarGeneralIconIconWidth,
                                 ZMAXTabBarGeneralIconIconHeight);
    
    self.title.frame = CGRectMake(0.0,
                                  self.icon.frame.origin.y + self.icon.frame.size.height + ZMAXTabBarGeneralIconTitleTopToIcon,
                                  self.bounds.size.width,
                                  ZMAXTabBarGeneralIconTitleHeight);
    
    self.tipsView.frame = CGRectMake(self.icon.frame.origin.x + self.icon.frame.size.width - ZMAXTabBarTipsWidth / 2.0,
                                     self.icon.frame.origin.y,
                                     ZMAXTabBarTipsWidth,
                                     ZMAXTabBarTipsWidth);
}

#pragma mark - Setter/Getter

- (UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor clearColor];
        _baseView.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handelTapBaseView:)];
        [_baseView addGestureRecognizer:gesture];
    }
    return _baseView;
}

- (UIImageView *)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.tintColor = [UIColor colorNamed:ZMAXUIColorTabBarIconDefaultBackground];
    }
    return _icon;
}

- (UILabel *)title
{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:12.0];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = [UIColor colorNamed:ZMAXUIColorTabBarIconDefaultBackground];
    }
    return _title;
}

#pragma mark - Action

- (void)__handelTapBaseView:(UITapGestureRecognizer *)gesture
{
    BLOCK(self.block);
}

#pragma mark - Function

- (void)changeToSeleted:(BOOL)seleted animation:(BOOL)animation
{
    if (self.isSlected != seleted) {
        self.isSlected = seleted;
        // 图标及颜色
        [self.icon setImage:self.isSlected ? self.selectedImage : self.normalImage];
        self.icon.tintColor = [UIColor colorNamed:self.isSlected ? ZMAXUIColorTabBarIconSelectedBackground :ZMAXUIColorTabBarIconDefaultBackground];
        self.title.textColor = [UIColor colorNamed:self.isSlected ? ZMAXUIColorTabBarIconSelectedBackground :ZMAXUIColorTabBarIconDefaultBackground];
    }
    
    if (animation) {
        // 震动反馈
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        [generator prepare];
        [generator impactOccurred];
        
        // 缩放动画
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.keyTimes = @[@0.0, @0.5, @1.0];
        animation.values = @[@1.0, @0.8, @1.0];
        animation.duration = 0.25;
        [self.baseView.layer addAnimation:animation forKey:@"iconShrink"];
    }
}

@end
