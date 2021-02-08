//
//  ZMAXTabBarImageIconView.m
//  Zmax
//
//  Created by 杨杰 on 2021/1/1.
//

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXTabBarImageIconView.h"

static const CGFloat ZMAXTabBarImageIconIconTopMargin = 10.0;
static const CGFloat ZMAXTabBarImageIconIconWidth = 35.0;
static const CGFloat ZMAXTabBarImageIconIconHeight = 30.0;

@interface ZMAXTabBarImageIconView ()

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIImageView *icon;

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;

@end

@implementation ZMAXTabBarImageIconView

- (instancetype)initWithNormalImage:(UIImage *)normalImage
                      selectedImage:(UIImage *)selectedImage
{
    self = [super init];
    if (self) {
        [self addSubview:self.baseView];
        [self.baseView addSubview:self.icon];
        self.normalImage = normalImage;
        self.selectedImage = selectedImage;
        [self.icon setImage:self.normalImage];
        
        [self.baseView addSubview:self.tipsView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.baseView.frame = self.bounds;
    
    self.icon.frame = CGRectMake(self.bounds.size.width * 0.5 - ZMAXTabBarImageIconIconWidth * 0.5,
                                 ZMAXTabBarImageIconIconTopMargin,
                                 ZMAXTabBarImageIconIconWidth,
                                 ZMAXTabBarImageIconIconHeight);
    
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

