//
//  ZMAXRecommendationPeportDetailViewController.m
//  Zmax
//
//  Created by 杨杰 on 2021/3/22.
//

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXNavigationBarView.h"
#import "ZMAXRecommendationPeportDetailViewController.h"
#import "ZMAXLocationRecommendAnalysisModel.h"

@interface ZMAXRecommendationPeportDetailViewController ()

@property (nonatomic, strong) ZMAXLocationRecommendAnalysisModel *model;
@property (nonatomic, strong) ZMAXNavigationBarView *navigationBarView;

@end

@implementation ZMAXRecommendationPeportDetailViewController

- (instancetype)initWithModel:(ZMAXLocationRecommendAnalysisModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
        [self __setupUI];
    }
    return self;
}

- (void)__setupUI
{
    self.view.backgroundColor = [UIColor colorNamed:ZMAXUIColorGeneralBackground];
    [self.view addSubview:self.navigationBarView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Setter/Getter

- (ZMAXNavigationBarView *)navigationBarView
{
    if (!_navigationBarView) {
        _navigationBarView = [[ZMAXNavigationBarView alloc] initWithStyle:ZMAXNavigationBarStyleDefault];
        [_navigationBarView addDefultBackIcon];
    }
    return _navigationBarView;
}

@end
