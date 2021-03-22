//
//  ZMAXLocationRecommendAnalysisModel.h
//  Zmax
//
//  Created by 杨杰 on 2021/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMAXLocationRecommendAnalysisModel : NSObject <NSCoding, NSSecureCoding>

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *industry;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSArray *analysisArray;

@end

NS_ASSUME_NONNULL_END
