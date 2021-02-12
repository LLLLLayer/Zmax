//
//  ZMAXMultifunctionCollectionViewCell.m
//  Zmax
//
//  Created by 杨杰 on 2021/2/11.
//

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXMultifunctionCollectionViewCell.h"

@interface MultifunctionItem ()

@property (nonatomic) UIView *baseView;

@end

@implementation MultifunctionItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowRadius = GENREAL_RADIUS;
        self.layer.shadowOpacity = 0.05;
        self.layer.shadowOffset = CGSizeMake(2.0, 2.0);
        [self addSubview:self.baseView];
        self.baseView.frame = CGRectMake(GENREAL_PADDING / 2.0, GENREAL_PADDING / 2.0, frame.size.width - GENREAL_PADDING, frame.size.height - GENREAL_PADDING);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.baseView.frame.size.width, self.baseView.frame.size.height) cornerRadius:GENREAL_RADIUS];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        self.baseView.layer.mask = layer;
        
        [self.baseView addSubview:self.titleLable];
        self.titleLable.frame = CGRectMake(0.0,
                                           self.baseView.frame.size.height * 0.7,
                                           self.baseView.frame.size.width,
                                           25);
        
        [self.baseView addSubview:self.iconImageView];
        CGFloat width = MIN(self.baseView.frame.size.width - 10.0, self.titleLable.frame.origin.y - 10.0);
        self.iconImageView.frame = CGRectMake((self.baseView.frame.size.width - width) / 2.0,
                                              self.titleLable.frame.origin.y - width - 4.0,
                                              width,
                                              width);
        
    }
    return self;
}

- (UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor colorNamed:ZMAXUIColorStandardColor];
    }
    return _baseView;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor clearColor];
    }
    return _iconImageView;
}

- (UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _titleLable.font = [UIFont systemFontOfSize:13.0 weight:0.05];
        _titleLable.alpha = 0.5;
    }
    return _titleLable;
}


@end

@interface ZMAXMultifunctionCollectionViewCell ()

@property (nonatomic, strong) MultifunctionItem *locationRecommendItem;
@property (nonatomic, strong) MultifunctionItem *locationRecordItem;
@property (nonatomic, strong) MultifunctionItem *recommendationPeportItem;
@property (nonatomic, strong) MultifunctionItem *recommendedBusinessItem;
@property (nonatomic, strong) MultifunctionItem *competitiveProductItem;

@end

@implementation ZMAXMultifunctionCollectionViewCell

+ (NSString *)identifier
{
    return NSStringFromClass([ZMAXMultifunctionCollectionViewCell class]);
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
    [self.contentView addSubview:self.locationRecommendItem];
    [self.contentView addSubview:self.recommendationPeportItem];
    [self.contentView addSubview:self.locationRecordItem];
    [self.contentView addSubview:self.recommendedBusinessItem];
    [self.contentView addSubview:self.competitiveProductItem];
}

- (MultifunctionItem *)locationRecommendItem
{
    if (!_locationRecommendItem) {
        _locationRecommendItem = [[MultifunctionItem alloc] initWithFrame:CGRectMake(0.0,
                                                                                     0.0,
                                                                                     self.contentView.frame.size.width / 4.0,
                                                                                     self.contentView.frame.size.height)];
        _locationRecommendItem.iconImageView.image = [UIImage imageNamed:@"LocationRecommendation"];
        _locationRecommendItem.titleLable.text = @"选址推荐";
    }
    return _locationRecommendItem;
}


- (MultifunctionItem *)recommendationPeportItem
{
    if (!_recommendationPeportItem) {
        _recommendationPeportItem = [[MultifunctionItem alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width / 4.0,
                                                                                        0.0,
                                                                                        self.contentView.frame.size.width / 4.0,
                                                                                        self.contentView.frame.size.height)];
        _recommendationPeportItem.iconImageView.image = [UIImage imageNamed:@"DataAnalysis"];
        _recommendationPeportItem.titleLable.text = @"推荐报告";
    }
    return _recommendationPeportItem;
}

- (MultifunctionItem *)locationRecordItem
{
    if (!_locationRecordItem) {
        _locationRecordItem = [[MultifunctionItem alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width / 2.0,
                                                                                  0.0,
                                                                                  self.contentView.frame.size.width / 4.0,
                                                                                  self.contentView.frame.size.height)];
        
        _locationRecordItem.iconImageView.image = [UIImage imageNamed:@"PathRecord"];
        _locationRecordItem.titleLable.text = @"考察记录";
    }
    return _locationRecordItem;
}

- (MultifunctionItem *)recommendedBusinessItem
{
    if (!_recommendedBusinessItem) {
        _recommendedBusinessItem = [[MultifunctionItem alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width / 4.0 * 3.0,
                                                                                  0.0,
                                                                                  self.contentView.frame.size.width / 4.0,
                                                                                  self.contentView.frame.size.height / 2.0)];
        _recommendedBusinessItem.iconImageView.image = [UIImage imageNamed:@"RecommendedBusinessOpportunities"];
        _recommendedBusinessItem.titleLable.text = @"商机推荐";
    }
    return _recommendedBusinessItem;
}

- (MultifunctionItem *)competitiveProductItem
{
    if (!_competitiveProductItem) {
        _competitiveProductItem = [[MultifunctionItem alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width / 4.0 * 3.0,
                                                                                      self.contentView.frame.size.height / 2.0,
                                                                                  self.contentView.frame.size.width / 4.0,
                                                                                  self.contentView.frame.size.height / 2.0)];
        _competitiveProductItem.iconImageView.image = [UIImage imageNamed:@"CompetitiveProductAnalysis"];
        _competitiveProductItem.titleLable.text = @"竞品分析";
    }
    return _competitiveProductItem;
}

@end
