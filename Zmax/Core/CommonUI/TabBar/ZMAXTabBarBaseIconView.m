//
//  ZMAXTabBarBaseIconView.m
//  Zmax
//
//  Created by 杨杰 on 2021/1/2.
//

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXTabBarBaseIconView.h"

const CGFloat ZMAXTabBarTipsWidth = 10.0;
static const CGFloat ZMAXTabBarTipsPadding = 1.0;

@interface ZMAXTabBarBaseIconView ()

@property (nonatomic, assign) BOOL isShowTipsView;

@end

@implementation ZMAXTabBarBaseIconView

- (void)changeToSeleted:(BOOL)seleted animation:(BOOL)animation
{
}

- (UIView *)tipsView
{
    if (!_tipsView) {
        _tipsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZMAXTabBarTipsWidth, ZMAXTabBarTipsWidth)];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(ZMAXTabBarTipsPadding,
                                                                                ZMAXTabBarTipsPadding,
                                                                                ZMAXTabBarTipsWidth - 2.0 * ZMAXTabBarTipsPadding,
                                                                                ZMAXTabBarTipsWidth - 2.0 * ZMAXTabBarTipsPadding)
                                                   byRoundingCorners:UIRectCornerTopLeft |
                                                                     UIRectCornerTopRight |
                                                                     UIRectCornerBottomRight |
                                                                     UIRectCornerBottomLeft
                                                         cornerRadii:CGSizeMake(ZMAXTabBarTipsWidth / 2.0, ZMAXTabBarTipsWidth / 2.0)];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        _tipsView.layer.mask = layer;
        _tipsView.layer.masksToBounds = YES;
        _tipsView.backgroundColor = [UIColor colorNamed:ZMAXUIColorTabBarIconTipsBackground];
        _tipsView.hidden = !self.isShowTipsView;
    }
    return _tipsView;
}

- (void)showTipsView:(BOOL)show
{
    self.isShowTipsView = show;
    self.tipsView.hidden = !self.isShowTipsView;
}

@end
