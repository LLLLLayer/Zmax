//
//  ZMAXEecommendedBusinessViewController.m
//  Zmax
//
//  Created by 杨杰 on 2021/3/15.
//

#import "ZMAXEecommendedBusinessViewController.h"
#import "ZMAXNavigationBarView.h"

@interface ZMAXEecommendedBusinessViewController ()

@property (nonatomic, strong) ZMAXNavigationBarView *navigationBarView;

@end

@implementation ZMAXEecommendedBusinessViewController

+ (NSString *)functionDescription
{
    return @"商机推荐";
}

- (void)__setupUI
{
    [self.view addSubview:self.navigationBarView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self __setupUI];
}

- (ZMAXNavigationBarView *)navigationBarView
{
    if (!_navigationBarView) {
        _navigationBarView = [[ZMAXNavigationBarView alloc] initWithStyle:ZMAXNavigationBarStyleDefault];
        [_navigationBarView addTitle:[self.class functionDescription] action:nil];
    }
    return _navigationBarView;
}

@end
