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

#import "ZMAXCycleScrollCollectionViewCell.h"
#import "ZMAXMultifunctionCollectionViewCell.h"
#import "ZMAXMapCollectionViewCell.h"

@interface ZMAXHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didUpdateLocationsNotificationAction:)
                                                 name:ZMAXDidUpdateLocationsNotification
                                               object:nil];
    
}

- (void)delete:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[ZMAXLocationManager sharedInstance] start];
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
        _items = @[@[@(1)], @[@(2)], @[@(3)], @[@(4)]];
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
    if (section == ZMAXHomeFunctionTypeMapView) {
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
        [view configWithTitle:@"附近调研" subTitle:@"走到哪 查到哪"];
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
    }
    return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH / 2.0);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == ZMAXHomeFunctionTypeCycleScroll && indexPath.row == 0) {
        ZMAXCycleScrollCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZMAXCycleScrollCollectionViewCell identifier] forIndexPath:indexPath];
        return cell;
    }
    if (indexPath.section == ZMAXHomeFunctionTypeMultifunction && indexPath.row == 0) {
        ZMAXCycleScrollCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZMAXMultifunctionCollectionViewCell identifier] forIndexPath:indexPath];
        return cell;
    }
    
    if (indexPath.section == ZMAXHomeFunctionTypeMapView && indexPath.row == 0) {
        ZMAXMapCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZMAXMapCollectionViewCell identifier] forIndexPath:indexPath];
        [cell changeStyleToNight:UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark];
        return cell;
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])
                                                                           forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:ZMAXHomeFunctionTypeMapView]]];
}

@end
