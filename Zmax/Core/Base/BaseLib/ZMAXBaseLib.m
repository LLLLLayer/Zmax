//
//  ZMAXBaseLib.m
//  Zmax
//
//  Created by 杨杰 on 2020/12/30.
//

#import "ZMAXBaseLib.h"
#import "MBProgressHUD.h"

@implementation ZMAXBaseLib

+ (UIWindow *)getKeyWindow
{
    for (UIWindowScene *windowScene in [UIApplication sharedApplication].connectedScenes) {
        if (windowScene.activationState == UISceneActivationStateForegroundActive) {
            for (UIWindow *window in windowScene.windows) {
                if (window.isKeyWindow) {
                    return window;
                }
            }
        }
    }
    return [UIApplication sharedApplication].windows.firstObject;
}

+ (UIViewController *)getTopController
{
    UIViewController *viewController = [ZMAXBaseLib getKeyWindow].rootViewController;
    viewController = [ZMAXBaseLib __getTopViewController:viewController];
    while (viewController.presentedViewController) {
        viewController = viewController.presentedViewController;
    }
    return viewController;
}

+ (UIViewController *)__getTopViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        return [ZMAXBaseLib __getTopViewController:[(UINavigationController *)viewController topViewController]];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        return [ZMAXBaseLib __getTopViewController:[(UITabBarController *)viewController selectedViewController]];
    } else {
        return viewController;
    }
    return nil;
}

+ (void)toast:(NSString *)text
{
    if (text && text.length) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[ZMAXBaseLib getTopController].view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = text;
        [hud hideAnimated:YES afterDelay:1.5];
    }
}

+ (void)toastDefaultError
{
    [ZMAXBaseLib toast:@"网络错误，请稍后重试！"];
}

@end
