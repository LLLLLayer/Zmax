//
//  ZMAXFunctionViewController.m
//  Zmax
//
//  Created by 杨杰 on 2021/1/2.
//

#import "ZMAXNavigationBarView.h"
#import "ZMAXFunctionViewController.h"

@interface ZMAXFunctionViewController ()

@property (nonatomic, strong) ZMAXNavigationBarView *navigationBarView;

@end

@implementation ZMAXFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self __setupUI];
}

- (void)__setupUI
{
    [self.view addSubview:self.navigationBarView];
}

- (ZMAXNavigationBarView *)navigationBarView
{
    if (!_navigationBarView) {
        _navigationBarView = [[ZMAXNavigationBarView alloc] initWithStyle:ZMAXNavigationBarStyleDefault];
        [_navigationBarView addTitle:@"资讯" action:nil];
    }
    return _navigationBarView;
}

@end
