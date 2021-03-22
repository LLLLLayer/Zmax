//
//  ZMAXRecommendationPeportViewController.m
//  Zmax
//
//  Created by 杨杰 on 2021/3/15.
//

#import <MJRefresh.h>

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"
#import "ZMAXUserDefaults.h"

#import "ZMAXNavigationBarView.h"
#import "ZMAXRecommendationReportViewController.h"
#import "ZMAXRecommendationPeportCollectionViewCell.h"
#import "ZMAXLocationRecommendAnalysisModel.h"
#import "ZMAXRecommendationPeportDetailViewController.h"

@interface ZMAXRecommendationReportViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ZMAXRecommendationPeportCollectionViewCellDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray<ZMAXLocationRecommendAnalysisModel *> *model;

@property (nonatomic, strong) ZMAXNavigationBarView *navigationBarView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic,   weak) ZMAXRecommendationPeportCollectionViewCell *showDeleteViewCell;

@end

@implementation ZMAXRecommendationReportViewController

+ (NSString *)functionDescription
{
    return @"推荐报告";
}

- (void)__setupUI
{
    self.view.backgroundColor = [UIColor colorNamed:ZMAXUIColorGeneralBackground];
    [self.view addSubview:self.navigationBarView];
    [self.view addSubview:self.collectionView];
    CGFloat topY = NAVIGATION_BAR_HEIGHT + SAFE_TOP + 46;
    if (self.delegate && [self.delegate respondsToSelector:@selector(topY)]) {
        topY = [self.delegate topY];
    }
    self.collectionView.frame = CGRectMake(0.0,
                                           topY,
                                           SCREEN_WIDTH,
                                           SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - SAFE_TOP);
    [self __loadRefresh];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self __setupUI];
    [self fetchData];
}

- (void)fetchData
{
    self.model = [[ZMAXUserDefaults getAllAlysisModel] mutableCopy];
    [self.collectionView reloadData];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorNamed:ZMAXUIColorGeneralBackground];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(__handelPanCollectionViewWithGesture:)];
        gesture.delegate = self;
        [_collectionView addGestureRecognizer:gesture];
        
        [_collectionView registerClass:[ZMAXRecommendationPeportCollectionViewCell class] forCellWithReuseIdentifier:[ZMAXRecommendationPeportCollectionViewCell identifier]];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource/UICollectionViewDelegateFlowLayout


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0, GENREAL_PADDING, GENREAL_PADDING, GENREAL_PADDING);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH - GENREAL_PADDING * 2, 150);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZMAXRecommendationPeportCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZMAXRecommendationPeportCollectionViewCell identifier] forIndexPath:indexPath];
    cell.delegate = self;
    [cell configWithModel:self.model[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - MJRefresh

- (void)__loadRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                     refreshingAction:@selector(__fetchData)];
    self.collectionView.mj_header = header;
}

- (void)__fetchData
{
    [self fetchData];
    [self.collectionView.mj_header endRefreshing];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *ges = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [ges locationInView:self.collectionView];
        if (point.x >= SCREEN_WIDTH - 2 * GENREAL_PADDING || point.x <= 2 * GENREAL_PADDING) {
            return false;
        }
        CGPoint vel = [ges velocityInView:ges.view];
        if (fabs(vel.x) > fabs(vel.y)) {
            return true;
        }
    }
    return false;
}

- (void)__handelPanCollectionViewWithGesture:(UIPanGestureRecognizer *)gesture
{
    static UICollectionViewCell *cell;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint point = [gesture locationInView:self.collectionView];
            NSIndexPath *path = [self.collectionView indexPathForItemAtPoint:point];
             cell = [self.collectionView cellForItemAtIndexPath:path];
        }
        default:
            break;
    }
    if ([cell isKindOfClass:ZMAXRecommendationPeportCollectionViewCell.class]) {
        ZMAXRecommendationPeportCollectionViewCell *c = (ZMAXRecommendationPeportCollectionViewCell *)cell;
        [c handlePanWithGesture:gesture];
    }
}

#pragma mark - ScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.showDeleteViewCell) {
        [self.showDeleteViewCell hideDelete];
    }
}

#pragma mark - ZMAXRecommendationPeportCollectionViewCellDelegate <NSObject>

- (void)tapCell:(ZMAXRecommendationPeportCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    ZMAXRecommendationPeportDetailViewController *vc = [[ZMAXRecommendationPeportDetailViewController alloc] initWithModel:self.model[indexPath.row]];
    [self.presentingViewController.navigationController pushViewController:vc animated:YES];
}

- (void)cellShowDeleteView:(ZMAXRecommendationPeportCollectionViewCell *)cell
{
    if (self.showDeleteViewCell && self.showDeleteViewCell != cell) {
        [self.showDeleteViewCell hideDelete];
    }
    self.showDeleteViewCell = cell;
}

- (void)cellTapDeleteView:(ZMAXRecommendationPeportCollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    [ZMAXUserDefaults deleteAlysisModelWithID:self.model[indexPath.row].ID];
    [self.model removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

@end
