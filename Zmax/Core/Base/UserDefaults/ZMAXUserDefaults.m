//
//  ZMAXUserDefaults.m
//  Zmax
//
//  Created by 杨杰 on 2021/2/8.
//

#import "ZMAXUserDefaults.h"
#import "ZMAXBaseLib.h"

#import "ZMAXLocationRecommendAnalysisModel.h"

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

+ (void)addAnalysisModel:(ZMAXLocationRecommendAnalysisModel *)model
{
    NSMutableArray *allAnalysisArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"allAnalysisArray"] mutableCopy];
    if (!allAnalysisArray) {
        allAnalysisArray = [[NSMutableArray alloc] init];
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model requiringSecureCoding:YES error:nil];
    [allAnalysisArray addObject:data];
    [[NSUserDefaults standardUserDefaults] setObject:[allAnalysisArray copy] forKey:@"allAnalysisArray"];
}

+ (ZMAXLocationRecommendAnalysisModel *)getAlysisModelWithID:(NSString *)ID
{
    NSArray<ZMAXLocationRecommendAnalysisModel *> *allAnalysisArray = [ZMAXUserDefaults getAllAlysisModel];
    for (NSInteger index = allAnalysisArray.count - 1; index >= 0; index--) {
        if ([allAnalysisArray[index].ID isEqualToString:ID]) {
            return allAnalysisArray[index];
        }
    }
    return nil;
}

+ (void)deleteAlysisModelWithID:(NSString *)ID
{
    NSMutableArray<ZMAXLocationRecommendAnalysisModel *> *allAnalysisArray = [[ZMAXUserDefaults getAllAlysisModel] mutableCopy];
    for (NSInteger index = allAnalysisArray.count - 1; index >= 0; index--) {
        if ([allAnalysisArray[index].ID isEqualToString:ID]) {
            [allAnalysisArray removeObjectAtIndex:index];
            break;
        }
    }
    NSMutableArray *newAllAnalysisArray = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index < allAnalysisArray.count; index++) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:allAnalysisArray[index] requiringSecureCoding:YES error:nil];
        if (data) {
            [newAllAnalysisArray addObject:data];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:[newAllAnalysisArray copy] forKey:@"allAnalysisArray"];
}

+ (NSArray<ZMAXLocationRecommendAnalysisModel *> *)getAllAlysisModel
{
    NSMutableArray *allAnalysisArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"allAnalysisArray"] mutableCopy];
    NSMutableArray *res = [[NSMutableArray alloc] init];
    for (int index = 0; index < allAnalysisArray.count; index++) {
        NSDate *data = allAnalysisArray[index];
        if (data) {
            NSError *error;
            ZMAXLocationRecommendAnalysisModel *model = [NSKeyedUnarchiver unarchivedObjectOfClass:[ZMAXLocationRecommendAnalysisModel class] fromData:data error:&error];
            if (!error) {
                [res addObject:model];
            }
        }
    }
    return [res copy];
}

@end
