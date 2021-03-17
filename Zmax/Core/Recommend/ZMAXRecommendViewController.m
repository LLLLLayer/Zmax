//
//  ZMAXRecommendViewController.m
//  Zmax
//
//  Created by 杨杰 on 2021/1/2.
//

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXRecommendViewController.h"
#import "ZMAXLocationRecommendViewController.h"
#import "ZMAXLocationRecordViewController.h"
#import "ZMAXEecommendationPeportViewController.h"
#import "ZMAXEecommendedBusinessViewController.h"
#import "ZMAXCompetitiveProductViewController.h"
#import "ZMAXScrollHeaderView.h"

@interface ZMAXRecommendViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *pagesArray;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ZMAXScrollHeaderView *headerView;

@property (nonatomic, strong) UIView *closeView;

@property (nonatomic, strong) ZMAXLocationRecommendViewController *locationRecommendVC;
@property (nonatomic, strong) ZMAXLocationRecordViewController *locationRecordVC;
@property (nonatomic, strong) ZMAXEecommendationPeportViewController *recommendationPeportVC;
@property (nonatomic, strong) ZMAXEecommendedBusinessViewController *recommendedBusinessVC;
@property (nonatomic, strong) ZMAXCompetitiveProductViewController *competitiveProductVC;

@end

@implementation ZMAXRecommendViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.25 animations:^{
        self.headerView.transform = CGAffineTransformIdentity;
    }];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __setupUI];
    }
    return self;
}

- (instancetype)initWithType:(ZMAXRecommendType)type
{
    self = [super init];
    if (self) {
        [self __setupUI];
        self.scrollView.contentOffset = [self __getContentOffsetWithType:type];
    }
    return self;
}

- (void)__setupUI
{
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.view.backgroundColor = [UIColor colorNamed:ZMAXUIColorGeneralBackground];
    
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [self.view addSubview:self.headerView];
    self.headerView.frame = CGRectMake(GENREAL_PADDING, SAFE_TOP + NAVIGATION_BAR_HEIGHT + 3.0, SCREEN_WIDTH - GENREAL_PADDING * 2.0, 40.0);
    [self configscrollView];
    
    self.headerView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    [self.view addSubview:self.closeView];
    self.closeView.frame = CGRectMake(0.0 , SAFE_TOP, 20 + 2 * GENREAL_PADDING, 20 + 2 * GENREAL_PADDING);
}

- (void)configscrollView
{
    [self addChildViewController:self.locationRecommendVC];
    weakify(self);
    [self.headerView addHeaderWithText:[[self.locationRecommendVC class] functionDescription]
                                 index:ZMAXRecommendTypeLOcationRecommend
                                action:^{
        strongify(weakSelf);
        strongSelf.scrollView.contentOffset = [strongSelf __getContentOffsetWithType:ZMAXRecommendTypeLOcationRecommend];
    }];
    
    [self addChildViewController:self.locationRecordVC];
    [self.headerView addHeaderWithText:[[self.locationRecordVC class] functionDescription]
                                 index:ZMAXRecommendTypeRecommendationPeport
                                action:^{
        strongify(weakSelf);
        strongSelf.scrollView.contentOffset = [strongSelf __getContentOffsetWithType:ZMAXRecommendTypeRecommendationPeport];
    }];
    
    [self addChildViewController:self.recommendationPeportVC];
    [self.headerView addHeaderWithText:[[self.recommendationPeportVC class] functionDescription]
                                 index:ZMAXRecommendTypeLocationRecord
                                action:^{
        strongify(weakSelf);
        strongSelf.scrollView.contentOffset = [strongSelf __getContentOffsetWithType:ZMAXRecommendTypeLocationRecord];
    }];
    
    [self addChildViewController:self.recommendedBusinessVC];
    [self.headerView addHeaderWithText:[[self.recommendedBusinessVC class] functionDescription]
                                 index:ZMAXRecommendTypeRecommendedBusiness
                                action:^{
        strongify(weakSelf);
        strongSelf.scrollView.contentOffset = [strongSelf __getContentOffsetWithType:ZMAXRecommendTypeRecommendedBusiness];
    }];
    
    [self addChildViewController:self.competitiveProductVC];
    [self.headerView addHeaderWithText:[[self.competitiveProductVC class] functionDescription]
                                 index:ZMAXRecommendTypeCompetitiveProduct
                                action:^{
        strongify(weakSelf);
        strongSelf.scrollView.contentOffset = [strongSelf __getContentOffsetWithType:ZMAXRecommendTypeCompetitiveProduct];
    }];
    
    [self scrollViewDidScroll:self.scrollView];
}

- (CGPoint)__getContentOffsetWithType:(ZMAXRecommendType)type
{
    return CGPointMake(SCREEN_WIDTH * type, 0.0);
}

#pragma mark - Setter/Getter

- (NSArray *)pagesArray
{
    if (!_pagesArray) {
        _pagesArray = @[@(ZMAXRecommendTypeLOcationRecommend),
                        @(ZMAXRecommendTypeRecommendationPeport),
                        @(ZMAXRecommendTypeLocationRecord),
                        @(ZMAXRecommendTypeRecommendedBusiness),
                        @(ZMAXRecommendTypeCompetitiveProduct)];
    }
    return _pagesArray;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.pagesArray.count, SCREEN_HEIGHT);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (ZMAXScrollHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[ZMAXScrollHeaderView alloc] init];
        _headerView.backgroundColor = [UIColor colorNamed:ZMAXUIColorBarBackground];
        _headerView.layer.cornerRadius = GENREAL_RADIUS;
        _headerView.layer.shadowColor = [UIColor blackColor].CGColor;
        _headerView.layer.shadowOpacity = 0.05;
        _headerView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    }
    return _headerView;
}

- (UIView *)closeView
{
    if (!_closeView) {
        _closeView = [[UIView alloc] init];
        UIImageView *closeImageView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"xmark"]];
        closeImageView.frame = CGRectMake(GENREAL_PADDING, GENREAL_PADDING, 20.0, 20.0);
        [_closeView addSubview:closeImageView];
        closeImageView.tintColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleTapCloseViewWithGesture:)];
        [_closeView addGestureRecognizer:gesture];
        _closeView.backgroundColor = [UIColor colorNamed:ZMAXUIColorBarBackground];
    }
    return _closeView;
}

- (ZMAXLocationRecommendViewController *)locationRecommendVC
{
    if (!_locationRecommendVC) {
        _locationRecommendVC = [[ZMAXLocationRecommendViewController alloc] init];
    }
    return _locationRecommendVC;
}

- (ZMAXLocationRecordViewController *)locationRecordVC
{
    if (!_locationRecordVC) {
        _locationRecordVC = [[ZMAXLocationRecordViewController alloc] init];
    }
    return _locationRecordVC;
}

- (ZMAXEecommendationPeportViewController *)recommendationPeportVC
{
    if (!_recommendationPeportVC) {
        _recommendationPeportVC = [[ZMAXEecommendationPeportViewController alloc] init];
    }
    return _recommendationPeportVC;
}

- (ZMAXEecommendedBusinessViewController *)recommendedBusinessVC
{
    if (!_recommendedBusinessVC) {
        _recommendedBusinessVC = [[ZMAXEecommendedBusinessViewController alloc] init];
    }
    return _recommendedBusinessVC;
}

- (ZMAXCompetitiveProductViewController *)competitiveProductVC
{
    if (!_competitiveProductVC) {
        _competitiveProductVC = [[ZMAXCompetitiveProductViewController alloc] init];
    }
    return _competitiveProductVC;
}

#pragma mark - Action

- (void)__handleTapCloseViewWithGesture:(UITapGestureRecognizer *)gesture
{
    [self dissmiss];
}

- (void)dissmiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.scrollView]) {
        NSInteger page = (scrollView.contentOffset.x + SCREEN_WIDTH * 0.5) / SCREEN_WIDTH; // 当前页数
        [self.headerView changeToIndex:page];
        // 预加载下一页
        for (NSInteger index = page; index <= page + 1 && self.childViewControllers.count > index; ++index) {
            UIViewController *vc = self.childViewControllers[index];
            if (![vc isViewLoaded]) {
                [self.scrollView addSubview:vc.view];
                vc.view.frame = CGRectMake(index * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            }
        }
    }
}

@end
