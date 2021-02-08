//
//  ZMAXUserDefaults.h
//  Zmax
//
//  Created by 杨杰 on 2021/2/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMAXUserDefaults : NSObject

+ (void)setIsCurrentUserInterfaceStyleDarkModel:(BOOL)isCurrentUserInterfaceStyleDarkModel;

+ (BOOL)isCurrentUserInterfaceStyleDarkModel;

+ (void)setIsCurrentUserInterfaceStyleWithSystem:(BOOL)isCurrentUserInterfaceStyleWithSystem;

+ (BOOL)isCurrentUserInterfaceStyleWithSystem;

@end

NS_ASSUME_NONNULL_END
