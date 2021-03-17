//
//  ZMAXNavigationBarView.h
//  Zmax
//
//  Created by 杨杰 on 2021/1/2.
//

#import <UIKit/UIKit.h>

typedef void(^ZMAXNavigationBarLabelAction) (UILabel *label);
typedef void(^ZMAXNavigationBarImageViewAction) (UIImageView *imageView);

typedef NS_ENUM(NSInteger, ZMAXNavigationBarStyle) {
    ZMAXNavigationBarStyleDefault = 0,
    ZMAXNavigationBarStyleClear,
};

typedef NS_ENUM(NSInteger, ZMAXNavigationBarType) {
    ZMAXNavigationBarTypeTitle = 0,
    ZMAXNavigationBarTypeLeftIcon,
    ZMAXNavigationBarTypeLeftSecondIcon,
    ZMAXNavigationBarTypeRightIcon,
    ZMAXNavigationBarTypeRightSecondIcon,
    ZMAXNavigationBarTypeLeftLable,
    ZMAXNavigationBarTypeRightLable,
};

@interface ZMAXNavigationBarView : UIView

- (instancetype)initWithStyle:(ZMAXNavigationBarStyle)style;
- (instancetype)initWithStyle:(ZMAXNavigationBarStyle)style ignoreSafeTop:(BOOL)ignore;

- (void)addTitle:(NSString *)title action:(ZMAXNavigationBarLabelAction)action;
- (void)changeTitle:(NSString *)title;
- (void)changeTitleWithAction:(ZMAXNavigationBarLabelAction)action;
- (void)changeTitle:(NSString *)title action:(ZMAXNavigationBarLabelAction)action;

- (void)addIconWithType:(ZMAXNavigationBarType)type icon:(UIImage *)icon action:(ZMAXNavigationBarImageViewAction)action;
- (void)changeIconWithType:(ZMAXNavigationBarType)type icon:(UIImage *)icon;
- (void)changeIconWithType:(ZMAXNavigationBarType)type action:(ZMAXNavigationBarImageViewAction)action;
- (void)changeIconWithType:(ZMAXNavigationBarType)type icon:(UIImage *)icon action:(ZMAXNavigationBarImageViewAction)action;

- (void)addLabelWithType:(ZMAXNavigationBarType)type text:(NSString *)text action:(ZMAXNavigationBarLabelAction)action;
- (void)changeLabelWithType:(ZMAXNavigationBarType)type text:(NSString *)text;
- (void)changeLabelWithType:(ZMAXNavigationBarType)type action:(ZMAXNavigationBarLabelAction)action;
- (void)changeLabelWithType:(ZMAXNavigationBarType)type text:(NSString *)text action:(ZMAXNavigationBarLabelAction)action;

- (void)addDefultBackIcon;

@end

