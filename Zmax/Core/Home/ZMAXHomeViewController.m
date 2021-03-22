//
//  ZMAXHomeViewController.m
//  Zmax
//
//  Created by 杨杰 on 2021/1/2.
//

#import <CoreLocation/CoreLocation.h>
#import <MJRefresh.h>

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"
#import "ZMAXNetwork.h"
#import "ZMAXUserDefaults.h"
#import "ZMAXLocationManager.h"
#import "NSDictionary+ZMAXAdditions.h"

#import "ZMAXHomeViewController.h"
#import "ZMAXNavigationBarView.h"
#import "ZMAXHomeHeaderView.h"

#import "ZMAXHomeCollectionViewCellProtocol.h"
#import "ZMAXCycleScrollCollectionViewCell.h"
#import "ZMAXMultifunctionCollectionViewCell.h"
#import "ZMAXMapCollectionViewCell.h"
#import "ZMAXCustomerServiceCell.h"

#import "ZMAXRecommendViewController.h"

static BOOL aminationFlag = NO;

@interface ZMAXHomeViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
ZMAXHomeCollectionViewCellProtocol
>

@property (nonatomic, strong) ZMAXNavigationBarView *navigationBarView;
@property (nonatomic, strong) UILabel *appLable;
@property (nonatomic, strong) UILabel *weatherLable;

@property (nonatomic, strong) NSArray<NSArray *> *items;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZMAXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self __setupUI];
    [self __loadRefresh];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didUpdateLocationsNotificationAction:)
                                                 name:ZMAXDidUpdateLocationsNotification
                                               object:nil];
    
}

- (void)delete:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[ZMAXLocationManager sharedInstance] start];
    [self.collectionView reloadData];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            aminationFlag = YES;
        });
    });
}

- (void)__setupUI
{
    [self.view addSubview:self.navigationBarView];
    
    [self.navigationBarView addSubview:self.appLable];
    self.appLable.frame = CGRectMake(32.0, SAFE_TOP, self.appLable.frame.size.width, NAVIGATION_BAR_HEIGHT);
    
    [self.navigationBarView addSubview:self.weatherLable];
    self.weatherLable.frame = CGRectMake(self.appLable.frame.origin.x + self.appLable.frame.size.width + 16.0,
                                     SAFE_TOP * 1.05,
                                     SCREEN_WIDTH,
                                     NAVIGATION_BAR_HEIGHT);
    
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(0.0, NAVIGATION_BAR_HEIGHT + SAFE_TOP,
                                           SCREEN_WIDTH,
                                           SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT - SAFE_TOP - SAFE_BOTTOM);
    

}

- (void)didUpdateLocationsNotificationAction:(NSNotification *)notification
{
    if (![[notification object] isKindOfClass:NSArray.class]) {
        return;
    }
    NSArray *locations = [notification object];
    if (locations.count == 0 || ![locations[0] isKindOfClass:CLLocation.class]) {
        return;
    }
    CLLocation *location = (CLLocation *)locations[0];
    NSString *poi = [NSString stringWithFormat:@"%f:%f",location.coordinate.latitude, location.coordinate.longitude];
    [ZMAXNetwork getWeatherWithParams:@{@"location" : poi} complation:^(BOOL success, NSDictionary *response) {
        if (!success) {
            return;
        }
        NSArray *resArray = [response zmax_arrayValueForKey:@"results"];
        if (!resArray || resArray.count == 0) {
            return;
        }
        NSDictionary *location = [(NSDictionary *)resArray[0] zmax_dictionaryValueForKey:@"location"];
        NSDictionary *now = [(NSDictionary *)resArray[0] zmax_dictionaryValueForKey:@"now"];
        
        NSString *text = [NSString stringWithFormat:@"%@  %@  %@℃",
                          [location zmax_stringValueForKey:@"name"],
                          [now zmax_stringValueForKey:@"text"],
                          [now zmax_stringValueForKey:@"temperature"]];
        self.weatherLable.text = text;
    }];
}

#pragma mark - Setter/Getter

- (ZMAXNavigationBarView *)navigationBarView
{
    if (!_navigationBarView) {
        _navigationBarView = [[ZMAXNavigationBarView alloc] initWithStyle:ZMAXNavigationBarStyleDefault];
    }
    return _navigationBarView;
}

- (UILabel *)appLable
{
    if (!_appLable) {
        _appLable = [[UILabel alloc] init];
        _appLable.textAlignment = NSTextAlignmentLeft;
        _appLable.font = [UIFont systemFontOfSize:16.0 weight:2.0];
        _appLable.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _appLable.text = @"择木";
        [_appLable sizeToFit];
    }
    return _appLable;
}

- (UILabel *)weatherLable
{
    if (!_weatherLable) {
        _weatherLable = [[UILabel alloc] init];
        _weatherLable.textAlignment = NSTextAlignmentLeft;
        _weatherLable.font = [UIFont systemFontOfSize:12.0 weight:0.2];
        _weatherLable.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
    }
    return _weatherLable;
}


- (NSArray<NSArray *> *)items
{
    if (!_items) {
        _items = @[
        @[@(ZMAXHomeFunctionTypeCycleScroll)],
        @[@(ZMAXHomeFunctionTypeMultifunction)],
        @[@(ZMAXHomeFunctionTypeMapView)],
        @[@(ZMAXHomeFunctionTypeCustomerService)]
        ];
    }
    return _items;
}


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 1.0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorNamed:ZMAXUIColorGeneralBackground];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        // cell
        [_collectionView registerClass:[ZMAXCycleScrollCollectionViewCell class]
            forCellWithReuseIdentifier:[ZMAXCycleScrollCollectionViewCell identifier]];
        
        [_collectionView registerClass:[ZMAXMultifunctionCollectionViewCell class]
            forCellWithReuseIdentifier:[ZMAXMultifunctionCollectionViewCell identifier]];
        
        [_collectionView registerClass:[ZMAXMapCollectionViewCell class]
            forCellWithReuseIdentifier:[ZMAXMapCollectionViewCell identifier]];
        
        [_collectionView registerClass:[ZMAXCustomerServiceCell class]
            forCellWithReuseIdentifier:[ZMAXCustomerServiceCell identifier]];
        
        [_collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        
        // header
        [_collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        
        [_collectionView registerClass:[ZMAXHomeHeaderView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:[ZMAXHomeHeaderView identifier]];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.items.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items[section].count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == ZMAXHomeFunctionTypeMapView || section == ZMAXHomeFunctionTypeCustomerService) {
        return CGSizeMake(SCREEN_WIDTH, kZMAXHomeHeaderViewHeight);
    }
    // default
    return CGSizeMake(SCREEN_WIDTH, GENREAL_PADDING);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == ZMAXHomeFunctionTypeMapView) {
        ZMAXHomeHeaderView *view = [collectionView
                                          dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                             withReuseIdentifier:[ZMAXHomeHeaderView identifier]
                                                                    forIndexPath:indexPath];
        [view configWithTitle:@"城市调研 & 人群观察" subTitle:@"走到哪里 查到哪里"];
        return view;
    }
    
    if (indexPath.section == ZMAXHomeFunctionTypeCustomerService) {
        ZMAXHomeHeaderView *view = [collectionView
                                          dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                             withReuseIdentifier:[ZMAXHomeHeaderView identifier]
                                                                    forIndexPath:indexPath];
        [view configWithTitle:@"疑问解答 & 在线咨询" subTitle:@"快速沟通 解决困惑"];
        return view;
    }
    // default
    UICollectionReusableView *view = [collectionView
                                      dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                         withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])
                                                                forIndexPath:indexPath];
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == ZMAXHomeFunctionTypeCycleScroll && indexPath.row == 0) {
        CGFloat width = SCREEN_WIDTH - GENREAL_PADDING * 2.0;
        return CGSizeMake(width, width / 2.0);
    } else if (indexPath.section == ZMAXHomeFunctionTypeMultifunction && indexPath.row == 0) {
        CGFloat width = SCREEN_WIDTH - GENREAL_PADDING;
        return CGSizeMake(width, width / 2.0);
    } else if (indexPath.section == ZMAXHomeFunctionTypeMapView && indexPath.row == 0) {
        CGFloat width = SCREEN_WIDTH - GENREAL_PADDING * 2.0;
        return CGSizeMake(width, width / 2.0);
    } else if (indexPath.section == ZMAXHomeFunctionTypeCustomerService && indexPath.row == 0) {
        CGFloat width = SCREEN_WIDTH - GENREAL_PADDING * 2.0;
        return CGSizeMake(width, width / 2.0 + GENREAL_PADDING);
    }
    return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH / 2.0);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == ZMAXHomeFunctionTypeCycleScroll && indexPath.row == 0) {
        ZMAXCycleScrollCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZMAXCycleScrollCollectionViewCell identifier] forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == ZMAXHomeFunctionTypeMultifunction && indexPath.row == 0) {
        ZMAXCycleScrollCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZMAXMultifunctionCollectionViewCell identifier] forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
    
    if (indexPath.section == ZMAXHomeFunctionTypeMapView && indexPath.row == 0) {
        ZMAXMapCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZMAXMapCollectionViewCell identifier] forIndexPath:indexPath];
        [cell changeStyleToNight:UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark];
        cell.delegate = self;
        return cell;
    }
    
    if (indexPath.section == ZMAXHomeFunctionTypeCustomerService && indexPath.row == 0) {
        ZMAXCustomerServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZMAXCustomerServiceCell identifier] forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])
                                                                           forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!aminationFlag) {
        CGFloat translationX = (indexPath.section % 2 ? -1 : 1) * -1 * SCREEN_WIDTH;
        cell.contentView.transform = CGAffineTransformMakeTranslation(translationX, 0.0);
        [UIView animateWithDuration:0.5 animations:^{
            cell.contentView.transform = CGAffineTransformIdentity;
        }];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if (!aminationFlag) {
        CGFloat translationX = (indexPath.section % 2 ? -1 : 1) * -1 * SCREEN_WIDTH;
        view.transform = CGAffineTransformMakeTranslation(translationX, 0.0);
        [UIView animateWithDuration:0.5 animations:^{
            view.transform = CGAffineTransformIdentity;
        }];
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:ZMAXHomeFunctionTypeMapView]]];
}

#pragma mark - MJRefresh

- (void)__loadRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                     refreshingAction:@selector(__fetchData)];
    self.collectionView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                             refreshingAction:@selector(__loadMore)];
    self.collectionView.mj_footer = footer;
}

- (void)__fetchData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView.mj_header endRefreshing];
    });
}

- (void)__loadMore
{
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
}

#pragma mark - ZMAXHomeCollectionViewCellProtocol

- (void)scrollCollectionViewCellDidtapWithCell:(ZMAXCycleScrollCollectionViewCell *)cell index:(NSInteger)index
{
    NSLog(@"[YJ] %@", @"0");
}

- (void)multifunctionCollectionViewCellDidTapLocationRecommendItemWithCell:(ZMAXMultifunctionCollectionViewCell *)cell
{
    ZMAXRecommendViewController *vc = [[ZMAXRecommendViewController alloc] initWithType:ZMAXRecommendTypeLOcationRecommend];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)multifunctionCollectionViewCellDidTapRecommendationPeportItemWithCell:(ZMAXMultifunctionCollectionViewCell *)cell
{
    ZMAXRecommendViewController *vc = [[ZMAXRecommendViewController alloc] initWithType:ZMAXRecommendTypeRecommendationPeport];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)multifunctionCollectionViewCellDidTapLocationRecordItemWithCell:(ZMAXMultifunctionCollectionViewCell *)cell
{
    ZMAXRecommendViewController *vc = [[ZMAXRecommendViewController alloc] initWithType:ZMAXRecommendTypeLocationRecord];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)multifunctionCollectionViewCellDidTapRecommendedBusinessItemWithCell:(ZMAXMultifunctionCollectionViewCell *)cell
{
    ZMAXRecommendViewController *vc = [[ZMAXRecommendViewController alloc] initWithType:ZMAXRecommendTypeRecommendedBusiness];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)multifunctionCollectionViewCellDidTapCompetitiveProductItemWithCell:(ZMAXMultifunctionCollectionViewCell *)cell
{
    ZMAXRecommendViewController *vc = [[ZMAXRecommendViewController alloc] initWithType:ZMAXRecommendTypeCompetitiveProduct];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)mapCollectionViewCellDidTapWithCell:(ZMAXMapCollectionViewCell *)cell
{
    NSLog(@"[YJ] %@", @"6");
}

- (void)customerServiceCellDidTapWithCell:(ZMAXCustomerServiceCell *)cell
{
    NSLog(@"[YJ] %@", @"7");
}

@end
