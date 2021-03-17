//
//  ZMAXSelectorCollectionHeaderView.m
//  Zmax
//
//  Created by 杨杰 on 2021/3/17.
//

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXSelectorCollectionHeaderView.h"

@interface ZMAXSelectorCollectionHeaderView ()

@property (nonatomic, strong) UILabel *titleLable;

@end

@implementation ZMAXSelectorCollectionHeaderView

+ (NSString *)identifier
{
    return NSStringFromClass([ZMAXSelectorCollectionHeaderView class]);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLable];
        self.titleLable.frame = CGRectMake(GENREAL_PADDING, 0.0, SCREEN_WIDTH - 2 * GENREAL_PADDING, frame.size.height);
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    self.titleLable.text = title;
}

- (UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.textColor = [UIColor colorNamed:ZMAXUIColorTextGeneralBackground];
        _titleLable.font = [UIFont systemFontOfSize:15.0 weight:0.2];
    }
    return _titleLable;
}


@end
