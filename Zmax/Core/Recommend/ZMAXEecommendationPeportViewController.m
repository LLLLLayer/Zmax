//
//  ZMAXEecommendationPeportViewController.m
//  Zmax
//
//  Created by 杨杰 on 2021/3/15.
//

#import "ZMAXEecommendationPeportViewController.h"
#import "ZMAXNavigationBarView.h"

@interface ZMAXEecommendationPeportViewController ()

@property (nonatomic, strong) ZMAXNavigationBarView *navigationBarView;

@end

@implementation ZMAXEecommendationPeportViewController

+ (NSString *)functionDescription
{
    return @"考察记录";
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
