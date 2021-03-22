//
//  ZMAXSelectorViewController.m
//  Zmax
//
//  Created by 杨杰 on 2021/3/16.
//

#import "ZMAXSelectorViewController.h"
#import "ZMAXSelectorCollectionViewCell.h"
#import "ZMAXSelectorCollectionHeaderView.h"

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXNavigationBarView.h"
#import "ZMAXSelectorModel.h"

@interface ZMAXSelectorViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) ZMAXSelectorModel *model;

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) ZMAXNavigationBarView *navigationBarView;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZMAXSelectorViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __setupUI];
    }
    return self;
}

- (instancetype)initWithSelectorModel:(ZMAXSelectorModel *)model
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
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.maskView];
    self.maskView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [self.view addSubview:self.baseView];
    self.baseView.frame = CGRectMake(0.0,
                                     SCREEN_HEIGHT,
                                     SCREEN_WIDTH,
                                     SCREEN_HEIGHT - 120.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.baseView.bounds
                                               byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                     cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    self.baseView.layer.mask = layer;
    
    [self.baseView addSubview:self.navigationBarView];
    [self.navigationBarView addTitle:self.model.title action:nil];
    
    [self.baseView addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(0.0,
                                           CGRectGetMaxY(self.navigationBarView.frame),
                                           SCREEN_WIDTH,
                                           self.baseView.bounds.size.height - CGRectGetMaxY(self.navigationBarView.frame));
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.alpha = 1;
        self.baseView.frame = CGRectMake(0.0,
                                         NAVIGATION_BAR_HEIGHT * 2 + SAFE_TOP,
                                         SCREEN_WIDTH,
                                         SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT * 2 - SAFE_TOP);
    }];
}

#pragma mark - Setter/Getter

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor colorNamed:ZMAXUIColorGeneralMaskBackground];
    }
    return _maskView;
}

- (UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor colorNamed:ZMAXUIColorGeneralBackground];
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(__handelPanBaseViewGesture:)];
        [_baseView addGestureRecognizer:gesture];
    }
    return _baseView;
}

- (ZMAXNavigationBarView *)navigationBarView
{
    if (!_navigationBarView) {
        _navigationBarView = [[ZMAXNavigationBarView alloc]initWithStyle:ZMAXNavigationBarStyleDefault ignoreSafeTop:YES];
        weakify(self);
        [_navigationBarView addIconWithType:ZMAXNavigationBarTypeLeftIcon icon:[UIImage systemImageNamed:@"xmark"] action:^(UIImageView *imageView) {
            strongify(weakSelf);
            [strongSelf __dismiss];
        }];
    }
    return _navigationBarView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor colorNamed:ZMAXUIColorGeneralBackground];
        
        [_collectionView registerClass:[ZMAXSelectorCollectionViewCell class] forCellWithReuseIdentifier:[ZMAXSelectorCollectionViewCell identifier]];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        
        [_collectionView registerClass:[ZMAXSelectorCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[ZMAXSelectorCollectionHeaderView identifier]];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate

 - (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.model.sectionArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.sectionItems[self.model.sectionArray[section]].count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 40);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0, GENREAL_PADDING, 0.0, GENREAL_PADDING);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 30.0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 5.0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZMAXSelectorCollectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[ZMAXSelectorCollectionHeaderView identifier] forIndexPath:indexPath];
        [header setTitle:self.model.sectionArray[indexPath.section]];
        return header;
    }
    UICollectionReusableView *view = [collectionView
                                      dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                         withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])
                                                                forIndexPath:indexPath];
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BLOCK(self.model.action, self.model.sectionItems[self.model.sectionArray[indexPath.section]][indexPath.item]);
    [self __dismiss];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZMAXSelectorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZMAXSelectorCollectionViewCell identifier] forIndexPath:indexPath];
    cell.titleLabel.text = self.model.sectionItems[self.model.sectionArray[indexPath.section]][indexPath.item];
    return cell;
}

#pragma mark - Action

- (void)__handelPanBaseViewGesture:(UIPanGestureRecognizer *)gesture
{
    UIView *view = gesture.view;
    static BOOL horizontal = NO;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            if ([gesture translationInView:self.view].x > [gesture translationInView:self.view].y
                || [gesture velocityInView:self.view].x > [gesture velocityInView:self.view].y) {
                horizontal = YES;
            }
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint change = [gesture translationInView:self.view];
            [gesture setTranslation:CGPointZero inView:self.view];
            if (horizontal) {
                CGFloat x = MAX(0, view.frame.origin.x + change.x);
                view.frame = CGRectMake(x, SCREEN_HEIGHT - view.frame.size.height, view.frame.size.width, view.frame.size.height);
                CGFloat percent = x / SCREEN_WIDTH;
                self.maskView.alpha = 1 - percent;
            } else {
                CGFloat y = MAX(SCREEN_HEIGHT - view.frame.size.height, view.frame.origin.y + change.y);
                view.frame = CGRectMake(0.0, y, view.frame.size.width, view.frame.size.height);
                CGFloat percent = y / SCREEN_HEIGHT;
                self.maskView.alpha = 1 - percent;
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (horizontal) {
                if ([gesture velocityInView:self.view].x > 180.0 ||
                    view.frame.origin.x > SCREEN_WIDTH - view.frame.size.width / 3.0) {
                    [self __dismissWithDuration:0.2 horizontal:YES];
                } else {
                    [UIView animateWithDuration:0.2 animations:^{
                        self.maskView.alpha = 1;
                        view.frame = CGRectMake(0.0, SCREEN_HEIGHT - view.frame.size.height, view.frame.size.width, view.frame.size.height);
                    }];
                }
            } else {
                if ([gesture velocityInView:self.view].y > 180.0 ||
                    view.frame.origin.y > SCREEN_HEIGHT - view.frame.size.height / 2.0) {
                    [self __dismissWithDuration:0.2 horizontal:NO];
                } else {
                    [UIView animateWithDuration:0.2 animations:^{
                        self.maskView.alpha = 1;
                        view.frame = CGRectMake(0.0, SCREEN_HEIGHT - view.frame.size.height, view.frame.size.width, view.frame.size.height);
                    }];
                }
            }
            horizontal = NO;
            break;
        }
        default:
        {
            break;
        }
    }
}

- (void)__dismiss
{
    [self __dismissWithDuration:0.3 horizontal:NO];
}

- (void)__dismissHorizontal:(BOOL)horizontal
{
    [self __dismissWithDuration:0.3 horizontal:horizontal];
}

- (void)__dismissWithDuration:(CGFloat)time horizontal:(BOOL)horizontal
{
    [UIView animateWithDuration:time animations:^{
        self.maskView.alpha = 0;
        if (horizontal) {
            self.baseView.frame = CGRectMake(SCREEN_WIDTH, self.baseView.frame.origin.y, SCREEN_WIDTH, self.baseView.frame.size.height);
        } else {
            self.baseView.frame = CGRectMake(0.0, SCREEN_HEIGHT, SCREEN_WIDTH, self.baseView.frame.size.height);
        }
        self.baseView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

@end
