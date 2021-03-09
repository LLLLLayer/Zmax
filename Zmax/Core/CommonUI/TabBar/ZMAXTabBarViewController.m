//
//  ZMAXTabBarViewController.m
//  Zmax
//
//  Created by 杨杰 on 2020/12/28.
//

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXTabBarViewController.h"
#import "ZMAXTabBarView.h"

#import "ZMAXHomeViewController.h"
#import "ZMAXFunctionViewController.h"
#import "ZMAXRecommendViewController.h"
#import "ZMAXMessageViewController.h"
#import "ZMAXMineViewController.h"

@interface ZMAXTabBarViewController () <ZMAXTabBarViewDelegate>

@property (nonatomic, strong) ZMAXTabBarView *tabBarView;
@property (nonatomic, strong) ZMAXHomeViewController *homeViewController;
@property (nonatomic, strong) ZMAXFunctionViewController *functionViewController;
@property (nonatomic, strong) ZMAXRecommendViewController *recommendViewController;
@property (nonatomic, strong) ZMAXMessageViewController *messageViewController;
@property (nonatomic, strong) ZMAXMineViewController *mineViewController;

@end

@implementation ZMAXTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewControllers = @[self.homeViewController,
                             self.functionViewController,
                             self.recommendViewController,
                             self.messageViewController,
                             self.mineViewController];
    [self __setupUI];
    
    [self.tabBarView showTipsViewWithType:ZMAXTabBarTypeMessage show:YES];
}

- (void)__setupUI
{
    [self.tabBar setHidden:YES];
    self.view.backgroundColor = [UIColor colorNamed:ZMAXUIColorGeneralBackground];
    
    [self.view addSubview:self.tabBarView];
    self.tabBarView.frame = CGRectMake(0.0,
                                       SCREEN_HEIGHT - TAB_BAR_HEIGHT - SAFE_BOTTOM,
                                       SCREEN_WIDTH,
                                       TAB_BAR_HEIGHT + SAFE_BOTTOM);
}

#pragma mark - Setter/Getter

- (ZMAXTabBarView *)tabBarView
{
    if (!_tabBarView) {
        _tabBarView = [[ZMAXTabBarView alloc] init];
        _tabBarView.delegate = self;
    }
    return _tabBarView;
}

- (ZMAXHomeViewController *)homeViewController
{
    if (!_homeViewController) {
        _homeViewController = [[ZMAXHomeViewController alloc] init];
    }
    return _homeViewController;
}

- (ZMAXFunctionViewController *)functionViewController
{
    if (!_functionViewController) {
        _functionViewController = [[ZMAXFunctionViewController alloc] init];
    }
    return _functionViewController;
}

- (ZMAXRecommendViewController *)recommendViewController
{
    if (!_recommendViewController) {
        _recommendViewController = [[ZMAXRecommendViewController alloc] init];
    }
    return _recommendViewController;
}

- (ZMAXMessageViewController *)messageViewController
{
    if (!_messageViewController) {
        _messageViewController = [[ZMAXMessageViewController alloc] init];
    }
    return _messageViewController;
}

- (ZMAXMineViewController *)mineViewController
{
    if (!_mineViewController) {
        _mineViewController = [[ZMAXMineViewController alloc] init];
    }
    return _mineViewController;
}

#pragma mark - ZMAXTabBarViewDelegate

- (ZMAXTabBarType)getCurrentType
{
    return self.selectedIndex;
}

- (void)changeToType:(ZMAXTabBarType)type
{
    if (self.selectedIndex != type) {
        self.selectedIndex = type;
    }
}

@end
