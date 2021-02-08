//
//  ZMAXTabBarBaseIconView.h
//  Zmax
//
//  Created by 杨杰 on 2021/1/2.
//

#import <UIKit/UIKit.h>

extern const CGFloat ZMAXTabBarTipsWidth;

typedef void (^tapIconViewBlock)(void);

@interface ZMAXTabBarBaseIconView : UIView

@property (nonatomic, strong) tapIconViewBlock block;

@property (nonatomic, assign) BOOL isSlected;

@property (nonatomic, strong) UIView *tipsView;

- (void)changeToSeleted:(BOOL)seleted animation:(BOOL)animation;

- (void)showTipsView:(BOOL)show;

@end

