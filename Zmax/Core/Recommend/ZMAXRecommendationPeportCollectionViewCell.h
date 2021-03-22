//
//  ZMAXRecommendationPeportCollectionViewCell.h
//  Zmax
//
//  Created by 杨杰 on 2021/3/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZMAXLocationRecommendAnalysisModel;
@class ZMAXRecommendationPeportCollectionViewCell;

@protocol ZMAXRecommendationPeportCollectionViewCellDelegate <NSObject>

- (void)tapCell:(ZMAXRecommendationPeportCollectionViewCell *)cell;
- (void)cellShowDeleteView:(ZMAXRecommendationPeportCollectionViewCell *)cell;
- (void)cellTapDeleteView:(ZMAXRecommendationPeportCollectionViewCell *)cell;

@end

@interface ZMAXRecommendationPeportCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak)id<ZMAXRecommendationPeportCollectionViewCellDelegate> delegate;
+ (NSString *)identifier;
- (void)configWithModel:(ZMAXLocationRecommendAnalysisModel *)model;
- (void)handlePanWithGesture:(UIPanGestureRecognizer *)gesture;
- (void)showDelete;
- (void)hideDelete;

@end

NS_ASSUME_NONNULL_END
