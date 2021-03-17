//
//  ZMAXRecommendViewController.h
//  Zmax
//
//  Created by 杨杰 on 2021/1/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZMAXRecommendType) {
    ZMAXRecommendTypeLOcationRecommend = 0,
    ZMAXRecommendTypeRecommendationPeport,
    ZMAXRecommendTypeLocationRecord,
    ZMAXRecommendTypeRecommendedBusiness,
    ZMAXRecommendTypeCompetitiveProduct,
};

@interface ZMAXRecommendViewController : UIViewController

- (instancetype)initWithType:(ZMAXRecommendType)type;

@end

NS_ASSUME_NONNULL_END
