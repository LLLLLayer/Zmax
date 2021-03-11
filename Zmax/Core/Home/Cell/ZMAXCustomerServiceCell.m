//
//  ZMAXCustomerServiceCell.m
//  Zmax
//
//  Created by 杨杰 on 2021/3/9.
//

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXCustomerServiceCell.h"

@interface ZMAXCustomerServiceCell ()

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIImageView *customerView1;
@property (nonatomic, strong) UIImageView *customerView2;
@property (nonatomic, strong) UIImageView *customerView3;

@end

@implementation ZMAXCustomerServiceCell

+ (NSString *)identifier
{
    return NSStringFromClass([ZMAXCustomerServiceCell class]);
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
    self.baseView.frame = CGRectMake(0.0, 0.0, self.contentView.frame.size.width, self.contentView.frame.size.height - GENREAL_PADDING);

    CGFloat width = self.baseView.bounds.size.height * 0.7;
    [self.baseView addSubview:self.customerView1];
    self.customerView1.frame = CGRectMake(GENREAL_PADDING,
                                          CGRectGetMidY(self.baseView.bounds) - width / 2.0,
                                          width,
                                          width);
    [self.baseView addSubview:self.customerView2];
    self.customerView2.frame = CGRectMake(CGRectGetMaxY(self.customerView1.frame) - width * 0.3,
                                          CGRectGetMidY(self.baseView.bounds)  - width / 2.0,
                                          width,
                                          width);
    
    width = self.baseView.bounds.size.width * 0.8;
    [self.baseView addSubview:self.customerView3];
    self.customerView3.frame = CGRectMake(self.baseView.frame.size.width - width * 0.8,
                                          self.baseView.bounds.size.height * 0.1,
                                          width,
                                          width);
}

- (UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor colorNamed:ZMAXUIColorCellBackGroundColor];
        CGRect rect = CGRectMake(0.0, 0.0, self.contentView.frame.size.width, self.contentView.frame.size.height - GENREAL_PADDING);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:GENREAL_RADIUS];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        _baseView.layer.mask = layer;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handelTapBaseViewWithGesture:)];
        [_baseView addGestureRecognizer:gesture];
    }
    return _baseView;
}

- (UIImageView *)customerView1
{
    if (!_customerView1) {
        _customerView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CustomerServiceMan"]];
        _customerView1.layer.shadowColor = [UIColor blackColor].CGColor;
        _customerView1.layer.shadowOpacity = 0.1;
        _customerView1.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    }
    return _customerView1;
}

- (UIImageView *)customerView2
{
    if (!_customerView2) {
        _customerView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CustomerServiceWoman"]];
        _customerView2.layer.shadowColor = [UIColor blackColor].CGColor;
        _customerView2.layer.shadowOpacity = 0.1;
        _customerView2.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    }
    return _customerView2;
}

- (UIImageView *)customerView3
{
    if (!_customerView3) {
        _customerView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CustomChat"]];
        _customerView3.layer.shadowColor = [UIColor blackColor].CGColor;
        _customerView3.layer.shadowOpacity = 0.1;
        _customerView3.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    }
    return _customerView3;
}

#pragma mark - Gestiure

- (void)__handelTapBaseViewWithGesture:(UITapGestureRecognizer *)gesture
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.25;
    animation.keyTimes = @[@(0.0), @(0.5), @(1.0)];
    animation.values = @[@(1.0), @(0.9), @(1.0)];
    [self.baseView.layer addAnimation:animation forKey:@"iconShrink"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customerServiceCellDidTapWithCell:)]) {
        [self.delegate customerServiceCellDidTapWithCell:self];
    }
}


@end
