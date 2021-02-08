//
//  ZMAXTabBarView.h
//  Zmax
//
//  Created by 杨杰 on 2020/12/31.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZMAXTabBarType) {
    ZMAXTabBarTypeHome = 0,
    ZMAXTabBarTypeFunction,
    ZMAXTabBarTypeRecommend,
    ZMAXTabBarTypeMessage,
    ZMAXTabBarTypeMine,
};

@protocol ZMAXTabBarViewDelegate <NSObject>

- (ZMAXTabBarType)getCurrentType;
- (void)changeToType:(ZMAXTabBarType)type;

@end

@interface ZMAXTabBarView : UIView

@property (nonatomic, weak) id<ZMAXTabBarViewDelegate> delegate;

- (void)changeToType:(ZMAXTabBarType)type;

- (void)showTipsViewWithType:(ZMAXTabBarType)type show:(BOOL)show;

@end
