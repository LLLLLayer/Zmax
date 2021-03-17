//
//  ZMAXNavigationBarView.m
//  Zmax
//
//  Created by 杨杰 on 2021/1/2.
//


#import <YYKit/YYLabel.h>

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXNavigationBarView.h"

static const CGFloat ZMAXNavigationBarGeneralPadding = 16.0;
static const CGFloat ZMAXNavigationBarIconWidth = 20.0;
static const CGFloat ZMAXNavigationBarGeneralInterval = 8.0;
static const CGFloat ZMAXNavigationBarTopPadding = 17.0;
static const CGFloat ZMAXNavigationBarIconDefaultPadding = 4.0;

@interface ZMAXNavigationBarView ()

@property (nonatomic, assign) ZMAXNavigationBarStyle style;
@property (nonatomic, assign) BOOL ignoreSafeTop;

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) ZMAXNavigationBarLabelAction titleAction;

@property (nonatomic, strong) UIView *leftBaseView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) ZMAXNavigationBarImageViewAction leftIconAction;

@property (nonatomic, strong) UIView *leftSecondBaseView;
@property (nonatomic, strong) UIImageView *leftSecondImageView;
@property (nonatomic, strong) ZMAXNavigationBarImageViewAction leftSecondIconAction;

@property (nonatomic, strong) UIView *rightBaseView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) ZMAXNavigationBarImageViewAction rightIconAction;

@property (nonatomic, strong) UIView *rightSecondBaseView;
@property (nonatomic, strong) UIImageView *rightSecondImageView;
@property (nonatomic, strong) ZMAXNavigationBarImageViewAction rightSecondIconAction;

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) ZMAXNavigationBarLabelAction leftLabelAction;

@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) ZMAXNavigationBarLabelAction rightLabelAction;

@end

@implementation ZMAXNavigationBarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.style = ZMAXNavigationBarStyleDefault;
        [self __setupUI];
    }
    return self;
}

- (instancetype)initWithStyle:(ZMAXNavigationBarStyle)style
{
    self = [super init];
    if (self) {
        self.style = style;
        [self __setupUI];
    }
    return self;
}

- (instancetype)initWithStyle:(ZMAXNavigationBarStyle)style ignoreSafeTop:(BOOL)ignore
{
    self = [super init];
    if (self) {
        self.style = style;
        self.ignoreSafeTop = ignore;
        [self __setupUI];
    }
    return self;
}

- (CGFloat)__safeTop
{
    return self.ignoreSafeTop ? 0.0 : SAFE_TOP;
}

- (void)__setupUI
{
    self.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT + [self __safeTop]);
    
    [self addSubview:self.baseView];
    self.baseView.frame = self.bounds;
    
    [self addSubview:self.lineView];
    self.lineView.frame = CGRectMake(0.0, self.bounds.size.height - 0.5, SCREEN_WIDTH, 0.5);
    
    switch (self.style) {
        case ZMAXNavigationBarStyleClear:
        {
            self.baseView.backgroundColor = [UIColor clearColor];
            self.lineView.backgroundColor = [UIColor clearColor];
            break;
        }
        default:
        {
            self.baseView.backgroundColor = [UIColor colorNamed:ZMAXUIColorBarBackground];
            self.lineView.backgroundColor = [UIColor colorNamed:ZMAXUIColorSeparateLineBackground];
            break;
        }
    }
}

#pragma mark - Setter/Getter

- (UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor colorNamed:ZMAXUIColorBarBackground];
    }
    return _baseView;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorNamed:ZMAXUIColorSeparateLineBackground];
    }
    return _lineView;
}

- (UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.tag = ZMAXNavigationBarTypeTitle;
        _titleLable.font = [UIFont systemFontOfSize:16.0 weight:2.0];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _titleLable.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleTapGesture:)];
        [_titleLable addGestureRecognizer:gesture];
    }
    return _titleLable;
}

- (UIView *)leftBaseView
{
    if (!_leftBaseView) {
        _leftBaseView = [[UIView alloc] init];
        _leftBaseView.tag = ZMAXNavigationBarTypeLeftIcon;
        _leftBaseView.backgroundColor = [UIColor clearColor];
        _leftBaseView.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleTapGesture:)];
        [_leftBaseView addGestureRecognizer:gesture];
    }
    return _leftBaseView;
}

- (UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.tintColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
    }
    return _leftImageView;
}

- (UIView *)leftSecondBaseView
{
    if (!_leftSecondBaseView) {
        _leftSecondBaseView = [[UIView alloc] init];
        _leftSecondBaseView.tag = ZMAXNavigationBarTypeLeftSecondIcon;
        _leftSecondBaseView.backgroundColor = [UIColor clearColor];
        _leftSecondBaseView.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleTapGesture:)];
        [_leftSecondBaseView addGestureRecognizer:gesture];
    }
    return _leftSecondBaseView;
}

- (UIImageView *)leftSecondImageView
{
    if (!_leftSecondImageView) {
        _leftSecondImageView = [[UIImageView alloc] init];
        _leftSecondImageView.tintColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
    }
    return _leftSecondImageView;
}

- (UIView *)rightBaseView
{
    if (!_rightBaseView) {
        _rightBaseView = [[UIView alloc] init];
        _rightBaseView.tag = ZMAXNavigationBarTypeRightIcon;
        _rightBaseView.backgroundColor = [UIColor clearColor];
        _rightBaseView.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleTapGesture:)];
        [_rightBaseView addGestureRecognizer:gesture];
    }
    return _rightBaseView;
}

- (UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.tintColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
    }
    return _rightImageView;
}

- (UIView *)rightSecondBaseView
{
    if (!_rightSecondBaseView) {
        _rightSecondBaseView = [[UIView alloc] init];
        _rightSecondBaseView.tag = ZMAXNavigationBarTypeRightSecondIcon;
        _rightSecondBaseView.backgroundColor = [UIColor clearColor];
        _rightSecondBaseView.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleTapGesture:)];
        [_rightSecondBaseView addGestureRecognizer:gesture];
    }
    return _rightSecondBaseView;
}

- (UIImageView *)rightSecondImageView
{
    if (!_rightSecondImageView) {
        _rightSecondImageView = [[UIImageView alloc] init];
        _rightSecondImageView.tintColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
    }
    return _rightSecondImageView;
}

- (UILabel *)leftLabel
{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.tag = ZMAXNavigationBarTypeLeftLable;
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _leftLabel.font = [UIFont systemFontOfSize:15.0];
        _leftLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleTapGesture:)];
        [_leftLabel addGestureRecognizer:gesture];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.tag = ZMAXNavigationBarTypeRightLable;
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _rightLabel.font = [UIFont systemFontOfSize:15.0];
        _rightLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleTapGesture:)];
        [_rightLabel addGestureRecognizer:gesture];
    }
    return _rightLabel;
}

#pragma mark - Action

- (void)__handleTapGesture:(UITapGestureRecognizer *)gesture
{
    switch (gesture.view.tag) {
        case ZMAXNavigationBarTypeTitle:
        {
            BLOCK(self.titleAction, self.titleLable);
            return;
        }
        case ZMAXNavigationBarTypeLeftIcon:
        {
            BLOCK(self.leftIconAction, self.leftImageView);
            return;
        }
        case ZMAXNavigationBarTypeLeftSecondIcon:
        {
            BLOCK(self.leftSecondIconAction, self.leftSecondImageView);
            return;
        }
        case ZMAXNavigationBarTypeRightIcon:
        {
            BLOCK(self.rightIconAction, self.rightImageView);
            return;
        }
        case ZMAXNavigationBarTypeRightSecondIcon:
        {
            BLOCK(self.rightSecondIconAction, self.rightSecondImageView);
            return;
        }
        case ZMAXNavigationBarTypeLeftLable:
        {
            BLOCK(self.leftLabelAction, self.leftLabel);
            return;
        }
        case ZMAXNavigationBarTypeRightLable:
        {
            BLOCK(self.rightLabelAction, self.rightLabel);
            return;
        }
        default:
            return;
    }
}

#pragma mark - Function

- (void)addTitle:(NSString *)title action:(ZMAXNavigationBarLabelAction)action
{
    [self.baseView addSubview:self.titleLable];
    CGFloat frameX = ZMAXNavigationBarGeneralPadding + ZMAXNavigationBarIconWidth * 2.0 + ZMAXNavigationBarGeneralInterval * 2.0;
    self.titleLable.frame = CGRectMake(frameX,
                                       [self __safeTop] + ZMAXNavigationBarTopPadding,
                                       self.baseView.frame.size.width - frameX * 2.0,
                                       self.baseView.frame.size.height - [self __safeTop] - ZMAXNavigationBarTopPadding * 2.0);
    
    self.titleLable.text = title;
    self.titleAction = action;
}

- (void)changeTitle:(NSString *)title
{
    self.titleLable.text = title;
}

- (void)changeTitleWithAction:(ZMAXNavigationBarLabelAction)action
{
    self.titleAction = action;
}

- (void)changeTitle:(NSString *)title action:(ZMAXNavigationBarLabelAction)action
{
    self.titleLable.text = title;
    self.titleAction = action;
}

- (void)addIconWithType:(ZMAXNavigationBarType)type icon:(UIImage *)icon action:(ZMAXNavigationBarImageViewAction)action
{
    switch (type) {
        case ZMAXNavigationBarTypeLeftIcon:
        {
            return [self __addLeftIcon:icon action:action];
        }
        case ZMAXNavigationBarTypeLeftSecondIcon:
        {
            return [self __addLeftSecondIcon:icon action:action];
        }
        case ZMAXNavigationBarTypeRightIcon:
        {
            return [self __addRightIcon:icon action:action];
        }
        case ZMAXNavigationBarTypeRightSecondIcon:
        {
            return [self _addRightSecondIcon:icon action:action];
        }
        default:
        {
            return;
        }
    }
}

- (void)changeIconWithType:(ZMAXNavigationBarType)type icon:(UIImage *)icon
{
    switch (type) {
        case ZMAXNavigationBarTypeLeftIcon:
        {
            self.leftImageView.image = icon;
            return;
        }
        case ZMAXNavigationBarTypeLeftSecondIcon:
        {
            self.leftSecondImageView.image = icon;
            return;
        }
        case ZMAXNavigationBarTypeRightIcon:
        {
            self.rightImageView.image = icon;
            return;
        }
        case ZMAXNavigationBarTypeRightSecondIcon:
        {
            self.rightSecondImageView.image = icon;
            return;
        }
        default:
        {
            return;
        }
    }
}

- (void)changeIconWithType:(ZMAXNavigationBarType)type action:(ZMAXNavigationBarImageViewAction)action
{
    switch (type) {
        case ZMAXNavigationBarTypeLeftIcon:
        {
            self.leftIconAction = action;
            return;
        }
        case ZMAXNavigationBarTypeLeftSecondIcon:
        {
            self.leftSecondIconAction = action;
            return;
        }
        case ZMAXNavigationBarTypeRightIcon:
        {
            self.rightIconAction = action;
            return;
        }
        case ZMAXNavigationBarTypeRightSecondIcon:
        {
            self.rightSecondIconAction = action;
            return;
        }
        default:
        {
            return;
        }
    }
}

- (void)changeIconWithType:(ZMAXNavigationBarType)type icon:(UIImage *)icon action:(ZMAXNavigationBarImageViewAction)action
{
    switch (type) {
        case ZMAXNavigationBarTypeLeftIcon:
        {
            self.leftImageView.image = icon;
            self.leftIconAction = action;
            return;
        }
        case ZMAXNavigationBarTypeLeftSecondIcon:
        {
            self.leftSecondImageView.image = icon;
            self.leftSecondIconAction = action;
            return;
        }
        case ZMAXNavigationBarTypeRightIcon:
        {
            self.rightImageView.image = icon;
            self.rightIconAction = action;
            return;
        }
        case ZMAXNavigationBarTypeRightSecondIcon:
        {
            self.rightSecondImageView.image = icon;
            self.rightSecondIconAction = action;
            return;
        }
        default:
        {
            return;
        }
    }
}

- (void)addLabelWithType:(ZMAXNavigationBarType)type text:(NSString *)text action:(ZMAXNavigationBarLabelAction)action
{
    switch (type) {
        case ZMAXNavigationBarTypeLeftLable:
        {
            return [self __addLeftLabel:text action:action];
        }
        case ZMAXNavigationBarTypeRightLable:
        {
            return [self __addRightLabel:text action:action];
        }
        default:
        {
            return;
        }
    }
}

- (void)changeLabelWithType:(ZMAXNavigationBarType)type text:(NSString *)text
{
    switch (type) {
        case ZMAXNavigationBarTypeLeftLable:
        {
            self.leftLabel.text = text;
            return;
        }
        case ZMAXNavigationBarTypeRightLable:
        {
            self.rightLabel.text = text;
            return;
        }
        default:
        {
            return;
        }
    }
}
- (void)changeLabelWithType:(ZMAXNavigationBarType)type action:(ZMAXNavigationBarLabelAction)action
{
    switch (type) {
        case ZMAXNavigationBarTypeLeftLable:
        {
            self.leftLabelAction = action;
            return;
        }
        case ZMAXNavigationBarTypeRightLable:
        {
            self.rightLabelAction = action;
            return;
        }
        default:
        {
            return;
        }
    }
}
- (void)changeLabelWithType:(ZMAXNavigationBarType)type text:(NSString *)text action:(ZMAXNavigationBarLabelAction)action
{
    switch (type) {
        case ZMAXNavigationBarTypeLeftLable:
        {
            self.leftLabel.text = text;
            self.leftLabelAction = action;
            return;
        }
        case ZMAXNavigationBarTypeRightLable:
        {
            self.rightLabel.text = text;
            self.rightLabelAction = action;
            return;
        }
        default:
        {
            return;
        }
    }
}

- (void)__addLeftIcon:(UIImage *)icon action:(ZMAXNavigationBarImageViewAction)action
{
    [self.baseView addSubview:self.leftBaseView];
    self.leftBaseView.frame = CGRectMake(ZMAXNavigationBarGeneralPadding - ZMAXNavigationBarIconDefaultPadding,
                                        [self __safeTop] + ZMAXNavigationBarTopPadding - ZMAXNavigationBarIconDefaultPadding,
                                        ZMAXNavigationBarIconWidth + ZMAXNavigationBarIconDefaultPadding * 2.0,
                                        ZMAXNavigationBarIconWidth + ZMAXNavigationBarIconDefaultPadding * 2.0);
    
    [self.leftBaseView addSubview:self.leftImageView];
    self.leftImageView.frame = CGRectMake(ZMAXNavigationBarIconDefaultPadding,
                                          ZMAXNavigationBarIconDefaultPadding,
                                          ZMAXNavigationBarIconWidth,
                                          ZMAXNavigationBarIconWidth);
    
    self.leftImageView.image = icon;
    self.leftIconAction = action;
}

- (void)__addLeftSecondIcon:(UIImage *)icon action:(ZMAXNavigationBarImageViewAction)action
{
    [self.baseView addSubview:self.leftSecondBaseView];
    self.leftSecondBaseView.frame = CGRectMake(ZMAXNavigationBarGeneralPadding + ZMAXNavigationBarIconWidth + ZMAXNavigationBarGeneralInterval - ZMAXNavigationBarIconDefaultPadding,
                                               [self __safeTop] + ZMAXNavigationBarTopPadding - ZMAXNavigationBarIconDefaultPadding,
                                               ZMAXNavigationBarIconWidth + ZMAXNavigationBarIconDefaultPadding * 2.0,
                                               ZMAXNavigationBarIconWidth + ZMAXNavigationBarIconDefaultPadding * 2.0);
    
    [self.leftSecondBaseView addSubview:self.leftSecondImageView];
    self.leftSecondImageView.frame = CGRectMake(ZMAXNavigationBarIconDefaultPadding,
                                                ZMAXNavigationBarIconDefaultPadding,
                                                ZMAXNavigationBarIconWidth,
                                                ZMAXNavigationBarIconWidth);
    
    self.leftSecondImageView.image = icon;
    self.leftSecondIconAction = action;
}

- (void)__addRightIcon:(UIImage *)icon action:(ZMAXNavigationBarImageViewAction)action
{
    [self.baseView addSubview:self.rightBaseView];
    self.rightBaseView.frame = CGRectMake(SCREEN_WIDTH - ZMAXNavigationBarGeneralPadding - ZMAXNavigationBarIconWidth - ZMAXNavigationBarIconDefaultPadding,
                                                [self __safeTop] + ZMAXNavigationBarTopPadding - ZMAXNavigationBarIconDefaultPadding,
                                                ZMAXNavigationBarIconWidth + ZMAXNavigationBarIconDefaultPadding * 2.0,
                                                ZMAXNavigationBarIconWidth + ZMAXNavigationBarIconDefaultPadding * 2.0);
    
    [self.rightBaseView addSubview:self.rightImageView];
    self.rightImageView.frame = CGRectMake(ZMAXNavigationBarIconDefaultPadding,
                                           ZMAXNavigationBarIconDefaultPadding,
                                           ZMAXNavigationBarIconWidth,
                                           ZMAXNavigationBarIconWidth);
    
    self.rightImageView.image = icon;
    self.rightIconAction = action;
}

- (void)_addRightSecondIcon:(UIImage *)icon action:(ZMAXNavigationBarImageViewAction)action
{
    [self.baseView addSubview:self.rightSecondBaseView];
    self.rightSecondBaseView.frame = CGRectMake(SCREEN_WIDTH - ZMAXNavigationBarGeneralPadding - ZMAXNavigationBarIconWidth - ZMAXNavigationBarGeneralInterval - ZMAXNavigationBarIconWidth - ZMAXNavigationBarIconDefaultPadding,
                                                [self __safeTop] + ZMAXNavigationBarTopPadding - ZMAXNavigationBarIconDefaultPadding,
                                                ZMAXNavigationBarIconWidth + ZMAXNavigationBarIconDefaultPadding * 2.0,
                                                ZMAXNavigationBarIconWidth + ZMAXNavigationBarIconDefaultPadding * 2.0);
    
    [self.rightSecondBaseView addSubview:self.rightSecondImageView];
    self.rightSecondImageView.frame = CGRectMake(ZMAXNavigationBarIconDefaultPadding,
                                                 ZMAXNavigationBarIconDefaultPadding,
                                                 ZMAXNavigationBarIconWidth,
                                                 ZMAXNavigationBarIconWidth);
    
    self.rightSecondImageView.image = icon;
    self.rightSecondIconAction = action;
}

- (void)__addLeftLabel:(NSString *)text action:(ZMAXNavigationBarLabelAction)action
{
    [self.baseView addSubview:self.leftLabel];
    self.leftLabel.frame = CGRectMake(ZMAXNavigationBarGeneralPadding,
                                      [self __safeTop] + ZMAXNavigationBarTopPadding,
                                      ZMAXNavigationBarIconWidth * 2.0 + ZMAXNavigationBarGeneralInterval,
                                      ZMAXNavigationBarIconWidth);
    
    self.leftLabel.text = text;
    self.leftLabelAction = action;
}

- (void)__addRightLabel:(NSString *)text action:(ZMAXNavigationBarLabelAction)action
{
    [self.baseView addSubview:self.rightLabel];
    self.rightLabel.frame = CGRectMake(SCREEN_WIDTH - ZMAXNavigationBarGeneralPadding - ZMAXNavigationBarIconWidth * 2.0 - ZMAXNavigationBarGeneralInterval,
                                       [self __safeTop] + ZMAXNavigationBarTopPadding,
                                       ZMAXNavigationBarIconWidth * 2.0 + ZMAXNavigationBarGeneralInterval,
                                       ZMAXNavigationBarIconWidth);
    
    self.rightLabel.text = text;
    self.rightLabelAction = action;
}

- (void)addDefultBackIcon
{
    UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithWeight:UIImageSymbolWeightThin];
    [self __addLeftIcon:[UIImage systemImageNamed:@"chevron.compact.left" withConfiguration:config] action:^(UIImageView *imageView) {
        [[ZMAXBaseLib getTopController].navigationController popViewControllerAnimated:YES];
    }];
}

@end
