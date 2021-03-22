//
//  ZMAXLocationRecommendViewController.m
//  Zmax
//
//  Created by 杨杰 on 2021/3/15.
//

#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "MBProgressHUD.h"

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"
#import "ZMAXUserDefaults.h"
#import "ZMAXNetwork.h"
#import "NSDictionary+ZMAXAdditions.h"
#import "ZMAXLocationRecommendAnalysisModel.h"

#import "ZMAXLocationRecommendViewController.h"
#import "ZMAXNavigationBarView.h"
#import "ZMAXSelectDisplayView.h"
#import "ZMAXRecommendationPeportDetailViewController.h"

#import "ZMAXSelectorModel.h"
#import "ZMAXSelectorViewController.h"

static const CGFloat kZMAXRecommendViewCardHeight = 180;

@interface ZMAXLocationRecommendViewController ()

@property (nonatomic, strong) ZMAXNavigationBarView *navigationBarView;
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *industryLabel;
@property (nonatomic, strong) ZMAXSelectDisplayView *cityDisplayView;
@property (nonatomic, strong) ZMAXSelectDisplayView *industryDisplayView;
@property (nonatomic, strong) UIButton *recommendButton;

@property (nonatomic, strong) NSArray *citysArray;
@property (nonatomic, strong) NSArray *industryArray;

@end

@implementation ZMAXLocationRecommendViewController

+ (NSString *)functionDescription
{
    return @"选址推荐";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self __setupUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.25 animations:^{
            self.cardView.frame = CGRectMake(GENREAL_PADDING, SCREEN_HEIGHT - SAFE_BOTTOM - GENREAL_PADDING / 2.0 - kZMAXRecommendViewCardHeight, SCREEN_WIDTH - 2 * GENREAL_PADDING, kZMAXRecommendViewCardHeight);
    }];
}

- (void)__setupUI
{
    [self.view addSubview:self.navigationBarView];
    [self.view addSubview:self.mapView];
    self.mapView.frame =  CGRectMake(0.0, CGRectGetMaxY(self.navigationBarView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.navigationBarView.frame));
    
    [self.view addSubview:self.cardView];
    self.cardView.frame = CGRectMake(GENREAL_PADDING, SCREEN_HEIGHT, SCREEN_WIDTH - 2 * GENREAL_PADDING, kZMAXRecommendViewCardHeight);
    
    CGFloat displayViewX = self.cardView.frame.size.width - GENREAL_PADDING - 250;
    
    [self.cardView addSubview:self.cityLabel];
    self.cityLabel.frame = CGRectMake(0.0, GENREAL_PADDING, displayViewX, 30);
    [self.cardView addSubview:self.cityDisplayView];
    [self.cityDisplayView setTitleWithText:@"请选择"];
    self.cityDisplayView.frame = CGRectMake(displayViewX, GENREAL_PADDING, 250, 30);
    
    [self.cardView addSubview:self.industryLabel];
    self.industryLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.cityDisplayView.frame) + GENREAL_PADDING, displayViewX, 30);
    [self.cardView addSubview:self.industryDisplayView];
    [self.industryDisplayView setTitleWithText:@"请选择"];
    self.industryDisplayView.frame = CGRectMake(displayViewX, CGRectGetMaxY(self.cityDisplayView.frame) + GENREAL_PADDING, 250, 30);
    
    [self.cardView addSubview:self.recommendButton];
    self.recommendButton.frame = CGRectMake(GENREAL_PADDING, self.cardView.frame.size.height - GENREAL_PADDING - 44, self.cardView.frame.size.width - 2 * GENREAL_PADDING, 44);
}

#pragma mark - Setter/Getter

- (ZMAXNavigationBarView *)navigationBarView
{
    if (!_navigationBarView) {
        _navigationBarView = [[ZMAXNavigationBarView alloc] initWithStyle:ZMAXNavigationBarStyleDefault];
        [_navigationBarView addTitle:[self.class functionDescription] action:nil];
    }
    return _navigationBarView;
}

- (MAMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] init];
        _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x - GENREAL_PADDING, 50);
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        
        BOOL currentIsNight = UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
        [_mapView setMapType:currentIsNight ? MAMapTypeStandardNight : MAMapTypeStandard];
    }
    return _mapView;
}

- (UIView *)cardView
{
    if (!_cardView) {
        _cardView = [[UIView alloc] init];
        _cardView.backgroundColor = [UIColor colorNamed:ZMAXUIColorCellBackGroundColor];
        _cardView.layer.cornerRadius = GENREAL_RADIUS;
        _cardView.layer.shadowColor = [UIColor blackColor].CGColor;
        _cardView.layer.shadowOpacity = 0.05;
        _cardView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
        
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(__handelCardViewPanGesture:)];
        [_cardView addGestureRecognizer:gesture];
    }
    return _cardView;
}

- (UILabel *)cityLabel
{
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _cityLabel.textAlignment = NSTextAlignmentCenter;
        _cityLabel.font = [UIFont systemFontOfSize:17 weight:0.3];
        _cityLabel.text = @"城市";
    }
    return _cityLabel;
}

- (ZMAXSelectDisplayView *)cityDisplayView
{
    if (!_cityDisplayView) {
        _cityDisplayView = [[ZMAXSelectDisplayView alloc] init];
        weakify(self);
        _cityDisplayView.actionBlock = ^{
            strongify(weakSelf);
            ZMAXSelectorModel *model = [[ZMAXSelectorModel alloc] init];
            model.title = @"城市";
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:strongSelf.view animated:YES];
            hud.mode = MBProgressHUDModeIndeterminate;
            [ZMAXNetwork getLocationRecommendCityWithComplation:^(BOOL success, NSDictionary *response) {
                strongify(weakSelf);
                [hud hideAnimated:YES];
                if (success) {
                    model.itemsArray = [response zmax_arrayValueForKey:@"citys"];
                    model.action = ^(NSString * _Nonnull selected) {
                        strongify(weakSelf);
                        if (selected && selected.length) {
                            [strongSelf.cityDisplayView setTitleWithText:selected];
                        }
                    };
                    ZMAXSelectorViewController *vc = [[ZMAXSelectorViewController alloc] initWithSelectorModel:model];
                    [strongSelf presentViewController:vc animated:NO completion:nil];
                } else {
                    [ZMAXBaseLib toastDefaultError];
                }
            }];
        };
    }
    return _cityDisplayView;
}

- (UILabel *)industryLabel
{
    if (!_industryLabel) {
        _industryLabel = [[UILabel alloc] init];
        _industryLabel.text = @"行业";
        _industryLabel.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _industryLabel.textAlignment = NSTextAlignmentCenter;
        _industryLabel.font = [UIFont systemFontOfSize:17 weight:0.3];
    }
    return _industryLabel;
}

- (ZMAXSelectDisplayView *)industryDisplayView
{
    if (!_industryDisplayView) {
        _industryDisplayView = [[ZMAXSelectDisplayView alloc] init];
        weakify(self);
        _industryDisplayView.actionBlock = ^{
            strongify(weakSelf);
            ZMAXSelectorModel *model = [[ZMAXSelectorModel alloc] init];
            model.title = @"行业";
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:strongSelf.view animated:YES];
            hud.mode = MBProgressHUDModeIndeterminate;
            [ZMAXNetwork getLocationRecommendIndustryLabelWithComplation:^(BOOL success, NSDictionary *response) {
                strongify(weakSelf);
                [hud hideAnimated:YES];
                if (success) {
                    model.itemsArray = [response zmax_arrayValueForKey:@"industrys"];
                    model.action = ^(NSString * _Nonnull selected) {
                        strongify(weakSelf);
                        if (selected && selected.length) {
                            [strongSelf.industryDisplayView setTitleWithText:selected];
                        }
                    };
                    ZMAXSelectorViewController *vc = [[ZMAXSelectorViewController alloc] initWithSelectorModel:model];
                    [strongSelf presentViewController:vc animated:NO completion:nil];
                } else {
                    [ZMAXBaseLib toastDefaultError];
                }
            }];
        };
    }
    return _industryDisplayView;
}

- (UIButton *)recommendButton
{
    if (!_recommendButton) {
        _recommendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _recommendButton.backgroundColor = [UIColor colorNamed:ZMAXUIColorBrandBlueColor];
        _recommendButton.layer.cornerRadius = GENREAL_RADIUS;
        [_recommendButton setTitleColor:[UIColor colorNamed:ZMAXUIColorConstWhiteColor] forState:UIControlStateNormal];
        [_recommendButton setTitle:@"开始分析" forState:UIControlStateNormal];
        _recommendButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:0.2];
        [_recommendButton addTarget:self action:@selector(__handelTapRecommendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recommendButton;
}

#pragma mark - Action

- (void)__handelCardViewPanGesture:(UIPanGestureRecognizer *)gesture
{
    static CGFloat rank = 1;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            rank = 1;
        }
        case UIGestureRecognizerStateChanged:
        {
            rank += 0.1;
            CGPoint trans = [gesture translationInView:self.view];
            [gesture setTranslation:CGPointZero inView:self.view];
            CGRect frame = self.cardView.frame;
            frame.origin.y += trans.y / rank;
            self.cardView.frame = frame;
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            [UIView animateWithDuration:0.25 animations:^{
                    self.cardView.frame = CGRectMake(GENREAL_PADDING, SCREEN_HEIGHT - SAFE_BOTTOM - GENREAL_PADDING / 2.0 - kZMAXRecommendViewCardHeight, SCREEN_WIDTH - 2 * GENREAL_PADDING, kZMAXRecommendViewCardHeight);
            }];
            break;
        }
        default:
            break;
    }
}

- (void)__handelTapRecommendButtonAction:(UIButton *)sender
{
    NSString *city = [self.cityDisplayView getTitle];
    NSString *industry = [self.industryDisplayView getTitle];
    if (!city || !city.length || !industry || !industry.length || [city isEqualToString:@"请选择"] || [industry isEqualToString:@"请选择"]) {
        [ZMAXBaseLib toast:@"请完成选择！"];
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    NSDictionary *params = @{@"city" : [self.cityDisplayView getTitle] ?: @"",
                             @"industry" : [self.industryDisplayView getTitle] ?: @"",
                             @"minIndex" : @"1",
                             @"maxIndex" : @"1000"};
    weakify(self);
    [ZMAXNetwork getLocationRecommendAnalysisWithParams:params complation:^(BOOL success, NSDictionary *response) {
        strongify(weakSelf);
        [hud hideAnimated:YES];
        if (success) {
            ZMAXLocationRecommendAnalysisModel *model = [[ZMAXLocationRecommendAnalysisModel alloc] init];
            model.ID = [response zmax_stringValueForKey:@"ID"];
            model.time = [response zmax_stringValueForKey:@"currentTime"];
            model.city = [response zmax_stringValueForKey:@"city"];
            model.industry = [response zmax_stringValueForKey:@"industry"];
            model.imageUrl = [response zmax_stringValueForKey:@"imageUrl"];
            model.analysisArray = [response zmax_arrayValueForKey:@"data"];
            [ZMAXUserDefaults addAnalysisModel:model];
            ZMAXRecommendationPeportDetailViewController *vc = [[ZMAXRecommendationPeportDetailViewController alloc] initWithModel:model];
            [strongSelf.presentingViewController.navigationController pushViewController:vc animated:YES];
        } else {
            [ZMAXBaseLib toastDefaultError];
        }
    }];
    
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    BOOL currentIsNight = UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
    [_mapView setMapType:currentIsNight ? MAMapTypeStandardNight : MAMapTypeStandard];
}

@end
