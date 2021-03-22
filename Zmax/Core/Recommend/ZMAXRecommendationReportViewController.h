//
//  ZMAXRecommendationPeportViewController.h
//  Zmax
//
//  Created by 杨杰 on 2021/3/15.
//

#import <UIKit/UIKit.h>
#import "ZMAXRecommendViewControllerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZMAXRecommendationReportViewController : UIViewController

+ (NSString *)functionDescription;

@property (nonatomic, strong) id<ZMAXRecommendViewControllerDelegate> delegate;

- (void)fetchData;

@end

NS_ASSUME_NONNULL_END
