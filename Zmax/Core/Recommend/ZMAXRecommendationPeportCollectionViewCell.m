//
//  ZMAXRecommendationPeportCollectionViewCell.m
//  Zmax
//
//  Created by 杨杰 on 2021/3/17.
//

#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXRecommendationPeportCollectionViewCell.h"
#import "ZMAXLocationRecommendAnalysisModel.h"


@interface ZMAXRecommendationPeportCollectionViewCell ()

@property (nonatomic, strong) UIView *deleteView;
@property (nonatomic, strong) UIImageView *deleteImageView;

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *industryLabel;
@property (nonatomic, strong) UILabel *cityContentLabel;
@property (nonatomic, strong) UILabel *industryContentLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *numberContentLabel;

@property (nonatomic, strong) UIImageView *bookMarkImageView;

@end

@implementation ZMAXRecommendationPeportCollectionViewCell

+ (NSString *)identifier
{
    return NSStringFromClass([ZMAXRecommendationPeportCollectionViewCell class]);
}

- (void)configWithModel:(ZMAXLocationRecommendAnalysisModel *)model
{
    self.timeLabel.text = model.time;
    self.cityContentLabel.text = model.city;
    self.industryContentLabel.text = model.industry;
    self.numberContentLabel.text = model.ID;
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
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
    
    [self.contentView addSubview:self.deleteView];
    self.deleteView.frame = CGRectMake(CGRectGetMaxX(self.contentView.bounds) - 78,
                                       0.0,
                                       78,
                                       self.contentView.bounds.size.height);
    
    [self.deleteView addSubview:self.deleteImageView];
    CGFloat deleteImageViewWidth = 30;
    self.deleteImageView.frame = CGRectMake((self.deleteView.bounds.size.width - deleteImageViewWidth) * 0.5,
                                            (self.deleteView.bounds.size.height - deleteImageViewWidth) * 0.5,
                                            deleteImageViewWidth,
                                            deleteImageViewWidth);
    self.deleteView.alpha = 0;
    
    [self.contentView addSubview:self.baseView];
    self.baseView.frame = self.contentView.bounds;
    
    [self.baseView addSubview:self.colorView];
    self.colorView.frame = CGRectMake(0.0, 0.0, GENREAL_PADDING, self.baseView.frame.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.colorView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(GENREAL_RADIUS, GENREAL_RADIUS)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    self.colorView.layer.mask = layer;
    
    [self.baseView addSubview:self.mainImageView];
    CGFloat mainImageViewWidth = self.baseView.frame.size.height - 2 * GENREAL_PADDING;
    CGFloat mainImageViewHeight = mainImageViewWidth / 1.2;
    self.mainImageView.frame = CGRectMake(2 * GENREAL_PADDING,
                                          (self.baseView.frame.size.height - mainImageViewHeight) * 0.5,
                                          mainImageViewWidth,
                                          mainImageViewHeight);
    
    [self.baseView addSubview:self.timeLabel];
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainImageView.mas_right).offset(GENREAL_PADDING);
        make.top.equalTo(self.baseView.mas_top).offset(GENREAL_PADDING);
        make.right.equalTo(self.baseView.mas_right).offset(-GENREAL_PADDING);
        make.height.equalTo(@(30));
    }];
    
    [self.baseView addSubview:self.cityLabel];
    [self.cityLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainImageView.mas_right).offset(GENREAL_PADDING);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(0);
        make.height.equalTo(@(30));
        make.width.equalTo(@(50));
    }];
    
    [self.baseView addSubview:self.industryLabel];
    [self.industryLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainImageView.mas_right).offset(GENREAL_PADDING);
        make.top.equalTo(self.cityLabel.mas_bottom).offset(0);
        make.height.equalTo(@(30));
        make.width.equalTo(@(50));
    }];
    
    [self.baseView addSubview:self.cityContentLabel];
    [self.cityContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cityLabel.mas_right).offset(0);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(0);
        make.height.equalTo(@(30));
        make.width.equalTo(@(80));
    }];
    
    [self.baseView addSubview:self.industryContentLabel];
    [self.industryContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.industryLabel.mas_right).offset(0);
        make.top.equalTo(self.cityContentLabel.mas_bottom).offset(0);
        make.height.equalTo(@(30));
        make.width.equalTo(@(80));
    }];
    
    [self.baseView addSubview:self.numberLabel];
    [self.numberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainImageView.mas_right).offset(GENREAL_PADDING);
        make.top.equalTo(self.industryLabel.mas_bottom).offset(0);
        make.height.equalTo(@(30));
        make.width.equalTo(@(80));
    }];
    
    [self.baseView addSubview:self.numberContentLabel];
    [self.numberContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numberLabel.mas_right).offset(0);
        make.top.equalTo(self.industryContentLabel.mas_bottom).offset(0);
        make.right.equalTo(self.baseView.mas_right).offset(0);
        make.height.equalTo(@(30));
    }];
    
    [self.baseView addSubview:self.bookMarkImageView];
    [self.bookMarkImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseView.mas_right).offset(-GENREAL_PADDING);
        make.top.equalTo(self.baseView.mas_top).offset(GENREAL_PADDING);
        make.width.height.equalTo(@(30));
    }];
}

#pragma mark - Getter/Setter

- (UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor colorNamed:ZMAXUIColorCellBackGroundColor];
        _baseView.layer.cornerRadius = GENREAL_RADIUS;
        _baseView.layer.shadowColor = [UIColor blackColor].CGColor;
        _baseView.layer.shadowRadius = GENREAL_RADIUS;
        _baseView.layer.shadowOpacity = 0.05;
        _baseView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleTapBaseView:)];
        [_baseView addGestureRecognizer:gesture];
    }
    return _baseView;
}

- (UIView *)colorView
{
    if (!_colorView) {
        _colorView = [[UIView alloc] init];
        _colorView.backgroundColor = [UIColor colorNamed:ZMAXUIColorBrandBlueColor];
    }
    return _colorView;
}

- (UIView *)deleteView
{
    if (!_deleteView) {
        _deleteView = [[UIView alloc] init];
        _deleteView.backgroundColor = [UIColor colorNamed:ZMAXUIColorTabBarIconTipsBackground];
        _deleteView.layer.cornerRadius = GENREAL_RADIUS;
        _deleteView.layer.shadowColor = [UIColor blackColor].CGColor;
        _deleteView.layer.shadowRadius = GENREAL_RADIUS;
        _deleteView.layer.shadowOpacity = 0.05;
        _deleteView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleTapDeleteView:)];
        [_deleteView addGestureRecognizer:gesture];
    }
    return _deleteView;
}

- (UIImageView *)deleteImageView
{
    if (!_deleteImageView) {
        _deleteImageView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"trash"]];
        _deleteImageView.tintColor = [UIColor colorNamed:ZMAXUIColorConstWhiteColor];
    }
    return _deleteImageView;
}

- (UIImageView *)mainImageView
{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] init];
        _mainImageView.backgroundColor = [UIColor colorNamed:ZMAXUIColorBarBackground];
    }
    return _mainImageView;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = [UIFont systemFontOfSize:16 weight:0.3];
    }
    return _timeLabel;
}

- (UILabel *)cityLabel
{
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _cityLabel.textAlignment = NSTextAlignmentLeft;
        _cityLabel.font = [UIFont systemFontOfSize:16 weight:0.1];
        _cityLabel.text = @"城市:";
        _cityLabel.alpha = 0.8;
    }
    return _cityLabel;
}

- (UILabel *)industryLabel
{
    if (!_industryLabel) {
        _industryLabel = [[UILabel alloc] init];
        _industryLabel.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _industryLabel.textAlignment = NSTextAlignmentLeft;
        _industryLabel.font = [UIFont systemFontOfSize:16 weight:0.1];
        _industryLabel.text = @"行业:";
        _industryLabel.alpha = 0.8;
    }
    return _industryLabel;
}

- (UILabel *)cityContentLabel
{
    if (!_cityContentLabel) {
        _cityContentLabel = [[UILabel alloc] init];
        _cityContentLabel.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _cityContentLabel.textAlignment = NSTextAlignmentLeft;
        _cityContentLabel.font = [UIFont systemFontOfSize:16 weight:0.1];
        _cityContentLabel.text = @"深圳";
    }
    return _cityContentLabel;
}

- (UILabel *)industryContentLabel
{
    if (!_industryContentLabel) {
        _industryContentLabel = [[UILabel alloc] init];
        _industryContentLabel.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _industryContentLabel.textAlignment = NSTextAlignmentLeft;
        _industryContentLabel.font = [UIFont systemFontOfSize:16 weight:0.1];
        _industryContentLabel.text = @"奶茶";
    }
    return _industryContentLabel;
}

- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        _numberLabel.font = [UIFont systemFontOfSize:15 weight:0.05];
        _numberLabel.text = @"报告编号:";
        _numberLabel.alpha = 0.5;
    }
    return _numberLabel;
}

- (UILabel *)numberContentLabel
{
    if (!_numberContentLabel) {
        _numberContentLabel = [[UILabel alloc] init];
        _numberContentLabel.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _numberContentLabel.textAlignment = NSTextAlignmentLeft;
        _numberContentLabel.font = [UIFont systemFontOfSize:15 weight:0.05];
        _numberContentLabel.alpha = 0.5;
    }
    return _numberContentLabel;
}

- (UIImageView *)bookMarkImageView
{
    if (!_bookMarkImageView) {
        _bookMarkImageView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"bookmark.fill"]];
        _bookMarkImageView.tintColor = [UIColor colorNamed:ZMAXUIColorBrandRedColor];
    }
    return _bookMarkImageView;
}

#pragma mark - Action

- (void)handlePanWithGesture:(UIPanGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(cellShowDeleteView:)]) {
                [self.delegate cellShowDeleteView:self];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint trans = [gesture translationInView:self.baseView];
            [gesture setTranslation:CGPointZero inView:self.baseView];
            CGRect frame = self.baseView.frame;
            frame.origin.x += trans.x;
            frame.origin.x = MAX(frame.origin.x, - 80);
            frame.origin.x = MIN(frame.origin.x, 0);
            self.baseView.frame = frame;
            self.deleteView.alpha = frame.origin.x / -80;
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            CGPoint vel = [gesture velocityInView:self.baseView];
            if (self.baseView.frame.origin.x < - 40 || vel.x < -200) {
                [self showDelete];
            } else if (self.baseView.frame.origin.x > - 40 || vel.x > 200) {
                [self hideDelete];
            }
            break;
        }
        default:
            break;
    }
}

- (void)showDelete
{
    [UIView animateWithDuration:0.15 animations:^{
        CGRect frame = self.contentView.bounds;
        frame.origin.x -= 80;
        self.baseView.frame = frame;
        self.deleteView.alpha = 1;
    }];
}

- (void)hideDelete
{
    [UIView animateWithDuration:0.15 animations:^{
        self.baseView.frame = self.contentView.bounds;
        self.deleteView.alpha = 0;
    }];
}

- (void)__handleTapDeleteView:(UITapGestureRecognizer *)gesture
{
    CGRect baseViewFrame = self.baseView.frame;
    [UIView animateWithDuration:0.2 animations:^{
        self.baseView.frame = CGRectMake(-baseViewFrame.size.width,
                                         baseViewFrame.origin.y,
                                         baseViewFrame.size.width,
                                         baseViewFrame.size.height);
        self.deleteView.frame = self.contentView.frame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.deleteView.frame;
            frame.size.height = 0.0;
            self.deleteView.frame = frame;
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self __setupUI];
            });
        }];
        if (self.delegate && [self.delegate respondsToSelector:@selector(cellTapDeleteView:)]) {
            [self.delegate cellTapDeleteView:self];
        }
    }];
}

- (void)__handleTapBaseView:(UITapGestureRecognizer *)gesture
{
    [self hideDelete];
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapCell:)]) {
        [self.delegate tapCell:self];
    }
}

@end
