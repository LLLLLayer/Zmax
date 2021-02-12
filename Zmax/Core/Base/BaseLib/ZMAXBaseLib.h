//
//  ZMAXBaseLib.h
//  Zmax
//
//  Created by 杨杰 on 2020/12/30.
//

#import <UIKit/UIKit.h>

#define weakify(self) __weak typeof(self) weakSelf = self
#define strongify(self) __strong typeof(self) strongSelf = self

#define IS_PHONE [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone
#define IS_PAD [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad

#define SAFE_TOP [ZMAXBaseLib getKeyWindow].safeAreaInsets.top
#define SAFE_BOTTOM [ZMAXBaseLib getKeyWindow].safeAreaInsets.bottom

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define BLOCK(block, ...) !block ?: block(__VA_ARGS__)

#define TAB_BAR_HEIGHT 54.0
#define NAVIGATION_BAR_HEIGHT 54.0

#define GENREAL_PADDING 16.0
#define GENREAL_RADIUS 8.0

@interface ZMAXBaseLib : NSObject

+ (UIWindow *)getKeyWindow;

+ (UIViewController *)getTopController;

@end

