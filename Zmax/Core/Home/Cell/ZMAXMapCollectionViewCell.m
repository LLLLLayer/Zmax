//
//  ZMAXMapCollectionViewCell.m
//  Zmax
//
//  Created by 杨杰 on 2021/2/12.
//

#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXMapCollectionViewCell.h"

@interface ZMAXMapCollectionViewCell ()

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) MAMapView *mapView;

@end

@implementation ZMAXMapCollectionViewCell

+ (NSString *)identifier
{
    return NSStringFromClass([ZMAXMapCollectionViewCell class]);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self __setupUI];
    }
    return self;
}

- (void)__setupUI
{
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.contentView.layer.shadowRadius = GENREAL_RADIUS;
    self.contentView.layer.shadowOpacity = 0.05;
    self.contentView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    
    [self.contentView addSubview:self.baseView];
    self.baseView.frame = self.contentView.frame;
    
    [self.baseView addSubview:self.mapView];
    self.mapView.frame = self.baseView.bounds;

}

- (UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor colorNamed:ZMAXUIColorCellBackGroundColor];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.contentView.frame cornerRadius:GENREAL_RADIUS];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        _baseView.layer.mask = layer;
    }
    return _baseView;
}

- (MAMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] init];
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        _mapView.userInteractionEnabled = NO;
    }
    return _mapView;
}

- (void)changeStyleToNight:(BOOL)night
{
    [_mapView setMapType:night ? MAMapTypeStandardNight : MAMapTypeStandard];
}

@end
