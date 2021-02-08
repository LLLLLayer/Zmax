//
//  ZMAXUserDefaults.m
//  Zmax
//
//  Created by 杨杰 on 2021/2/8.
//

#import "ZMAXUserDefaults.h"
#import "ZMAXBaseLib.h"

@implementation ZMAXUserDefaults

+ (void)setIsCurrentUserInterfaceStyleDarkModel:(BOOL)isCurrentUserInterfaceStyleDarkModel
{
    if (isCurrentUserInterfaceStyleDarkModel) {
        [ZMAXBaseLib getKeyWindow].overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    } else {
        [ZMAXBaseLib getKeyWindow].overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
    [[NSUserDefaults standardUserDefaults] setBool:isCurrentUserInterfaceStyleDarkModel
                                            forKey:@"isCurrentUserInterfaceStyleDarkModel"];
}

+ (BOOL)isCurrentUserInterfaceStyleDarkModel
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isCurrentUserInterfaceStyleDarkModel"];
}

+ (void)setIsCurrentUserInterfaceStyleWithSystem:(BOOL)isCurrentUserInterfaceStyleWithSystem
{
    if (isCurrentUserInterfaceStyleWithSystem) {
        [ZMAXBaseLib getKeyWindow].overrideUserInterfaceStyle = UIUserInterfaceStyleUnspecified;
    } else {
        [ZMAXBaseLib getKeyWindow].overrideUserInterfaceStyle = UITraitCollection.currentTraitCollection.userInterfaceStyle;
    }
    [[NSUserDefaults standardUserDefaults] setBool:isCurrentUserInterfaceStyleWithSystem
                                            forKey:@"isCurrentUserInterfaceStyleWithSystem"];
}

+ (BOOL)isCurrentUserInterfaceStyleWithSystem
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isCurrentUserInterfaceStyleWithSystem"];
}

@end
