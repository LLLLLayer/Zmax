//
//  ZMAXUserDefaults.h
//  Zmax
//
//  Created by 杨杰 on 2021/2/8.
//

#import <Foundation/Foundation.h>

@class ZMAXLocationRecommendAnalysisModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZMAXUserDefaults : NSObject

+ (void)setIsCurrentUserInterfaceStyleDarkModel:(BOOL)isCurrentUserInterfaceStyleDarkModel;

+ (BOOL)isCurrentUserInterfaceStyleDarkModel;

+ (void)setIsCurrentUserInterfaceStyleWithSystem:(BOOL)isCurrentUserInterfaceStyleWithSystem;

+ (BOOL)isCurrentUserInterfaceStyleWithSystem;

+ (void)addAnalysisModel:(ZMAXLocationRecommendAnalysisModel *)model;
+ (ZMAXLocationRecommendAnalysisModel *)getAlysisModelWithID:(NSString *)ID;
+ (void)deleteAlysisModelWithID:(NSString *)ID;
+ (NSArray<ZMAXLocationRecommendAnalysisModel *> *)getAllAlysisModel;

@end

NS_ASSUME_NONNULL_END
