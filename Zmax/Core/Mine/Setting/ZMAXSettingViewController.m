//
//  ZMAXSettingViewController.m
//  Zmax
//
//  Created by 杨杰 on 2021/1/4.
//

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"
#import "ZMAXUserDefaults.h"

#import "ZMAXSettingViewController.h"
#import "ZMAXNavigationBarView.h"
#import "ZMAXSettingCollectionViewCell.h"

const static CGFloat ZMAXSettingcollectionViewSectionHeaderHeight = 16.0;

@interface ZMAXSettingViewController ()
<
UIGestureRecognizerDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
ZMAXSettingCollectionViewCellDelegate
>

@property (nonatomic, strong) NSArray<NSArray <ZMAXSettingCollectionViewCellModel *> *> *settingItems;

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) ZMAXNavigationBarView *navigationBarView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZMAXSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self __setupUI];
}

- (void)__setupUI
{
    [self.view addSubview:self.baseView];
    self.baseView.frame = self.view.bounds;
    [self.baseView addSubview:self.navigationBarView];
    [self.baseView addSubview:self.collectionView];
}

#pragma mark - Setter/Getter

- (NSArray *)settingItems
{
    if (!_settingItems) {
        NSMutableArray *userInterfaceStyle = [[NSMutableArray alloc] init];
        
        // ZMAXSettingItemUserInterfaceStyle
        {
            ZMAXSettingCollectionViewCellModel *model = [[ZMAXSettingCollectionViewCellModel alloc] init];
            model.type = ZMAXSettingItemUserInterfaceStyle;
            model.titleText = @"深色模式";
            model.isSwitch = YES;
            model.isIcon = NO;
            model.currentSwitch = UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
            model.canSwitchChange = ![ZMAXUserDefaults isCurrentUserInterfaceStyleWithSystem];
            
            [userInterfaceStyle addObject:model];
        }
        // ZMAXSettingItemUserInterfaceStyleWithSystem
        {
            ZMAXSettingCollectionViewCellModel *model = [[ZMAXSettingCollectionViewCellModel alloc] init];
            model.type = ZMAXSettingItemUserInterfaceStyleWithSystem;
            model.titleText = @"外观跟随系统设置";
            model.isSwitch = YES;
            model.isIcon = NO;
            model.currentSwitch = [ZMAXUserDefaults isCurrentUserInterfaceStyleWithSystem];
            model.canSwitchChange = YES;
            [userInterfaceStyle addObject:model];
        }
        _settingItems = @[[userInterfaceStyle copy]];
    }
    return _settingItems;
}

- (UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor colorNamed:ZMAXUIColorGeneralBackground];
    }
    return _baseView;
}

- (ZMAXNavigationBarView *)navigationBarView
{
    if (!_navigationBarView) {
        _navigationBarView = [[ZMAXNavigationBarView alloc] init];
        [_navigationBarView addDefultBackIcon];
        [_navigationBarView addTitle:@"设置" action:nil];
    }
    return _navigationBarView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH - ZMAXSettingCollectionGeneralPadding * 2.0, ZMAXSettingCollectionViewCellHeight);
        layout.minimumLineSpacing = 1.0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0,
                                                                             self.navigationBarView.frame.origin.x + self.navigationBarView.frame.size.height,
                                                                             SCREEN_WIDTH,
                                                                             SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT)
                                             collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor colorNamed:ZMAXUIColorGeneralBackground];
        [_collectionView registerClass:[ZMAXSettingCollectionViewCell class]
            forCellWithReuseIdentifier:[ZMAXSettingCollectionViewCell identifier]];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.settingItems[indexPath.section].count > 1) {
        if (indexPath.row == 0) {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0,
                                                                                    0.0,
                                                                                    SCREEN_WIDTH - ZMAXSettingCollectionGeneralPadding * 2.0,
                                                                                    ZMAXSettingCollectionViewCellHeight)
                                                       byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                             cornerRadii:CGSizeMake(20.0, 20.0)];
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.path = path.CGPath;
            cell.contentView.layer.mask = layer;
        } else if (indexPath.row == self.settingItems[indexPath.section].count - 1) {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0,
                                                                                    0.0,
                                                                                    SCREEN_WIDTH - ZMAXSettingCollectionGeneralPadding * 2.0,
                                                                                    ZMAXSettingCollectionViewCellHeight)
                                                       byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
                                                             cornerRadii:CGSizeMake(20.0, 20.0)];
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.path = path.CGPath;
            cell.contentView.layer.mask = layer;
        }
    } else {
        if (indexPath.row == 0) {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0,
                                                                                    0.0,
                                                                                    SCREEN_WIDTH - ZMAXSettingCollectionGeneralPadding * 2.0,
                                                                                    ZMAXSettingCollectionViewCellHeight)
                                                       byRoundingCorners:UIRectCornerAllCorners
                                                             cornerRadii:CGSizeMake(20.0, 20.0)];
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.path = path.CGPath;
            cell.contentView.layer.mask = layer;
        }
    }

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.settingItems.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.settingItems[section].count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, ZMAXSettingcollectionViewSectionHeaderHeight);
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZMAXSettingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZMAXSettingCollectionViewCell  identifier]
                                                                           forIndexPath:indexPath];
    cell.delegate = self;
    [cell configWithModel:self.settingItems[indexPath.section][indexPath.item]];
    return cell;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.navigationController.viewControllers count] == 1) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - ZMAXSettingCollectionViewCellDelegate

- (void)settingCellBaseViewDidTapWithype:(ZMAXSettingItem)type
{
    switch (type) {
        default:
            break;
    }
}

- (void)settingCellSwitchDidChangeWIthType:(ZMAXSettingItem)type currentFlag:(BOOL)flag
{
    switch (type) {
        case ZMAXSettingItemUserInterfaceStyle:
        {
            [ZMAXUserDefaults setIsCurrentUserInterfaceStyleDarkModel:flag];
            self.settingItems[0][ZMAXSettingItemUserInterfaceStyle].currentSwitch = flag;
            break;
        }
        case ZMAXSettingItemUserInterfaceStyleWithSystem:
        {
            [ZMAXUserDefaults setIsCurrentUserInterfaceStyleWithSystem:flag];
            self.settingItems[0][ZMAXSettingItemUserInterfaceStyle].canSwitchChange = !flag;
            self.settingItems[0][ZMAXSettingItemUserInterfaceStyleWithSystem].currentSwitch = flag;
            [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:ZMAXSettingItemUserInterfaceStyle inSection:0]]];
            break;
        }
        default:
        {
            break;
        }
    }
}

- (void)settingCellIconDidTapWithype:(ZMAXSettingItem)type
{
    switch (type) {
        default:
            break;
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    self.settingItems[0][ZMAXSettingItemUserInterfaceStyle].currentSwitch = previousTraitCollection.userInterfaceStyle != UIUserInterfaceStyleDark;
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:ZMAXSettingItemUserInterfaceStyle inSection:0]]];
}

@end
