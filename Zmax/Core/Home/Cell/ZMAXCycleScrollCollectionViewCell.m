//
//  ZMAXCycleScrollCollectionViewCell.m
//  Zmax
//
//  Created by 杨杰 on 2021/2/9.
//

#import "SDCycleScrollView.h"

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXCycleScrollCollectionViewCell.h"

@interface ZMAXCycleScrollCollectionViewCell () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation ZMAXCycleScrollCollectionViewCell

+ (NSString *)identifier
{
    return NSStringFromClass([ZMAXCycleScrollCollectionViewCell class]);
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
    
    [self.baseView addSubview:self.cycleScrollView];
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

- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.contentView.frame
                                                       imageNamesGroup:@[[UIImage imageNamed:@"NoNews"],
                                                                         [UIImage imageNamed:@"NoNews"],
                                                                         [UIImage imageNamed:@"NoNews"],
                                                                         [UIImage imageNamed:@"NoNews"]
                                                       ]];
        _cycleScrollView.backgroundColor = [UIColor clearColor];
        _cycleScrollView.delegate = self;
    }
    return _cycleScrollView;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.keyTimes = @[@0.0, @0.5, @1.0];
    animation.values = @[@1.0, @0.9, @1.0];
    animation.duration = 0.25;
    [self.baseView.layer addAnimation:animation forKey:@"iconShrink"];
}

@end
