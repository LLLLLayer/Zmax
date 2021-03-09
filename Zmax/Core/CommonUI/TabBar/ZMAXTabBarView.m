//
//  ZMAXTabBarView.m
//  Zmax
//
//  Created by 杨杰 on 2020/12/31.
//

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXTabBarView.h"
#import "ZMAXTabBarGeneralIconView.h"
#import "ZMAXTabBarImageIconView.h"

@interface ZMAXTabBarView ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) ZMAXTabBarGeneralIconView *homeView;
@property (nonatomic, strong) ZMAXTabBarGeneralIconView *functionView;
@property (nonatomic, strong) ZMAXTabBarImageIconView *recommendView;
@property (nonatomic, strong) ZMAXTabBarGeneralIconView *messageView;
@property (nonatomic, strong) ZMAXTabBarGeneralIconView *mineView;

@end

@implementation ZMAXTabBarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __setupUI];
        [[self __getViewWithType:ZMAXTabBarTypeHome] changeToSeleted:YES animation:NO];
    }
    return self;
}

- (void)__setupUI
{

    self.backgroundColor = [UIColor colorNamed:ZMAXUIColorBarBackground];
    
    [self addSubview:self.lineView];
    self.lineView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    
    CGFloat currentX = 0;
    CGFloat tempWidth = SCREEN_WIDTH / 5.0;
    
    [self addSubview:self.homeView];
    self.homeView.frame = CGRectMake(currentX, 0, tempWidth, TAB_BAR_HEIGHT);
    currentX += tempWidth;
    
    [self addSubview:self.functionView];
    self.functionView.frame = CGRectMake(currentX, 0, tempWidth, TAB_BAR_HEIGHT);
    currentX += tempWidth;
    
    [self addSubview:self.recommendView];
    self.recommendView.frame = CGRectMake(currentX, 0, tempWidth, TAB_BAR_HEIGHT);
    currentX += tempWidth;
    
    [self addSubview:self.messageView];
    self.messageView.frame = CGRectMake(currentX, 0, tempWidth, TAB_BAR_HEIGHT);
    currentX += tempWidth;
    
    [self addSubview:self.mineView];
    self.mineView.frame = CGRectMake(currentX, 0, tempWidth, TAB_BAR_HEIGHT);
    currentX += tempWidth;
}

#pragma mark - Setter/Getter

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorNamed:ZMAXUIColorSeparateLineBackground];
    }
    return _lineView;
}

- (ZMAXTabBarGeneralIconView *)homeView
{
    if (!_homeView) {
        _homeView = [[ZMAXTabBarGeneralIconView alloc] initWithNormalImage:[UIImage systemImageNamed:@"house"]
                                                             selectedImage:[UIImage systemImageNamed:@"house.fill"]
                                                                     title:@"首页"];
        weakify(self);
        _homeView.block = ^{
            strongify(weakSelf);
            [strongSelf changeToType:ZMAXTabBarTypeHome];
        };
    }
    return _homeView;
}

- (ZMAXTabBarGeneralIconView *)functionView
{
    if (!_functionView) {
        _functionView = [[ZMAXTabBarGeneralIconView alloc] initWithNormalImage:[UIImage systemImageNamed:@"paperplane"]
                                                                 selectedImage:[UIImage systemImageNamed:@"paperplane.fill"]
                                                                         title:@"资讯"];
        weakify(self);
        _functionView.block = ^{
            strongify(weakSelf);
            [strongSelf changeToType:ZMAXTabBarTypeFunction];
        };
    }
    return _functionView;
}

- (ZMAXTabBarImageIconView *)recommendView
{
    if (!_recommendView) {
        _recommendView = [[ZMAXTabBarImageIconView alloc] initWithNormalImage:[UIImage imageNamed:@"ZmaxIconDefault"]
                                                                selectedImage:[UIImage imageNamed:@"ZmaxIcon"]];
        weakify(self);
        _recommendView.block = ^{
            strongify(weakSelf);
            [strongSelf changeToType:ZMAXTabBarTypeRecommend];
        };

    }
    return _recommendView;
}

- (ZMAXTabBarGeneralIconView *)messageView
{
    if (!_messageView) {
        _messageView = [[ZMAXTabBarGeneralIconView alloc] initWithNormalImage:[UIImage systemImageNamed:@"message"]
                                                                selectedImage:[UIImage systemImageNamed:@"message.fill"]
                                                                        title:@"消息"];
        weakify(self);
        _messageView.block = ^{
            strongify(weakSelf);
            [strongSelf changeToType:ZMAXTabBarTypeMessage];
        };
    }
    return _messageView;
}

- (ZMAXTabBarGeneralIconView *)mineView
{
    if (!_mineView) {
        _mineView = [[ZMAXTabBarGeneralIconView alloc] initWithNormalImage:[UIImage systemImageNamed:@"person"]
                                                             selectedImage:[UIImage systemImageNamed:@"person.fill"]
                                                                     title:@"我的"];
        weakify(self);
        _mineView.block = ^{
            strongify(weakSelf);
            [strongSelf changeToType:ZMAXTabBarTypeMine];
        };
    }
    return _mineView;
}

#pragma mark - Function

- (ZMAXTabBarBaseIconView *)__getViewWithType:(ZMAXTabBarType)type
{
    switch (type) {
        case ZMAXTabBarTypeHome:
            return self.homeView;
        case ZMAXTabBarTypeFunction:
            return self.functionView;
        case ZMAXTabBarTypeRecommend:
            return self.recommendView;
        case ZMAXTabBarTypeMessage:
            return self.messageView;;
        case ZMAXTabBarTypeMine:
            return self.mineView;
        default:
            return self.homeView;
    }
}

- (void)changeToType:(ZMAXTabBarType)type
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(getCurrentType)]) {
        ZMAXTabBarType currentType = [self.delegate getCurrentType];
        if (currentType != type) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(changeToType:)]) {
                [self.delegate changeToType:type];
            }
            [[self __getViewWithType:currentType] changeToSeleted:NO animation:NO];
        }
        [[self __getViewWithType:type] changeToSeleted:YES animation:YES];
    }
}

- (void)showTipsViewWithType:(ZMAXTabBarType)type show:(BOOL)show
{
    [[self __getViewWithType:type] showTipsView:show];
}

@end


