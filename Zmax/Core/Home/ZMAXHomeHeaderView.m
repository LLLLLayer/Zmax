//
//  ZMAXHomeHeaderView.m
//  Zmax
//
//  Created by 杨杰 on 2021/2/12.
//

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXHomeHeaderView.h"

const CGFloat kZMAXHomeHeaderViewHeight = 50.0;

@interface ZMAXHomeHeaderView ()

@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *subTitleLable;

@end

@implementation ZMAXHomeHeaderView

+ (NSString *)identifier
{
    return NSStringFromClass([ZMAXHomeHeaderView class]);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLable];
        [self addSubview:self.subTitleLable];
    }
    return self;
}

- (void) configWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    self.titleLable.text = title;
    [self.titleLable sizeToFit];
    
    self.titleLable.frame = CGRectMake(GENREAL_PADDING,
                                       (self.frame.size.height - self.titleLable.frame.size.height) / 2.0,
                                       self.titleLable.frame.size.width,
                                       self.titleLable.frame.size.height);
    
    
    self.subTitleLable.text = subTitle;
    [self.subTitleLable sizeToFit];
    
    self.subTitleLable.frame = CGRectMake(self.titleLable.frame.origin.x + self.titleLable.frame.size.width + GENREAL_PADDING,
                                        CGRectGetMaxY(self.titleLable.frame) - self.subTitleLable.frame.size.height,
                                          self.subTitleLable.frame.size.width,
                                          self.subTitleLable.frame.size.height);
}

- (UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _titleLable.font = [UIFont systemFontOfSize:17.0 weight:0.3];
    }
    return _titleLable;
}

- (UILabel *)subTitleLable
{
    if (!_subTitleLable) {
        _subTitleLable = [[UILabel alloc] init];
        _subTitleLable.textAlignment = NSTextAlignmentCenter;
        _subTitleLable.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _subTitleLable.font = [UIFont systemFontOfSize:12.0 weight:0.05];
        _subTitleLable.alpha = 0.5;
    }
    return _subTitleLable;
}

@end
