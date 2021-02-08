//
//  ZMAXAppInitialization.m
//  Zmax
//
//  Created by 杨杰 on 2021/2/8.
//

#import "ZMAXAppInitialization.h"
#import "ZMAXUserDefaults.h"

@implementation ZMAXAppInitialization

+ (void)appItialization
{
    [ZMAXAppInitialization __itializationUserInterfaceStyle];
}

+ (void)__itializationUserInterfaceStyle
{
    [ZMAXUserDefaults setIsCurrentUserInterfaceStyleWithSystem:[ZMAXUserDefaults isCurrentUserInterfaceStyleWithSystem]];
    [ZMAXUserDefaults setIsCurrentUserInterfaceStyleDarkModel:[ZMAXUserDefaults isCurrentUserInterfaceStyleDarkModel]];
}

@end
