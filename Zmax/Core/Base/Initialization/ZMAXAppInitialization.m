//
//  ZMAXAppInitialization.m
//  Zmax
//
//  Created by 杨杰 on 2021/2/8.
//

#import "ZMAXAppInitialization.h"
#import "ZMAXUserDefaults.h"

#import "ZMAXNetwork.h"

@implementation ZMAXAppInitialization

+ (void)appItialization
{
    [ZMAXAppInitialization __itializationUserInterfaceStyle];
}

+ (void)__itializationUserInterfaceStyle
{
    BOOL withSystem = [ZMAXUserDefaults isCurrentUserInterfaceStyleWithSystem];
    if (withSystem) {
        [ZMAXUserDefaults setIsCurrentUserInterfaceStyleWithSystem:[ZMAXUserDefaults isCurrentUserInterfaceStyleWithSystem]];
    } else {
        [ZMAXUserDefaults setIsCurrentUserInterfaceStyleDarkModel:[ZMAXUserDefaults isCurrentUserInterfaceStyleDarkModel]];
    }
}

@end
