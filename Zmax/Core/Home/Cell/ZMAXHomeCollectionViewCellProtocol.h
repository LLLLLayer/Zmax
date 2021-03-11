//
//  ZMAXHomeCollectionViewCellProtocol.h
//  Zmax
//
//  Created by 杨杰 on 2021/3/10.
//

#import <Foundation/Foundation.h>

@class ZMAXCycleScrollCollectionViewCell;
@class ZMAXMultifunctionCollectionViewCell;
@class ZMAXMapCollectionViewCell;
@class ZMAXCustomerServiceCell;

NS_ASSUME_NONNULL_BEGIN

@protocol ZMAXHomeCollectionViewCellProtocol <NSObject>

@optional
- (void)scrollCollectionViewCellDidtapWithCell:(ZMAXCycleScrollCollectionViewCell *)cell index:(NSInteger)index;
- (void)multifunctionCollectionViewCellDidTapLocationRecommendItemWithCell:(ZMAXMultifunctionCollectionViewCell *)cell;
- (void)multifunctionCollectionViewCellDidTapRecommendationPeportItemWithCell:(ZMAXMultifunctionCollectionViewCell *)cell;
- (void)multifunctionCollectionViewCellDidTapLocationRecordItemWithCell:(ZMAXMultifunctionCollectionViewCell *)cell;
- (void)multifunctionCollectionViewCellDidTapRecommendedBusinessItemWithCell:(ZMAXMultifunctionCollectionViewCell *)cell;
- (void)multifunctionCollectionViewCellDidTapCompetitiveProductItemWithCell:(ZMAXMultifunctionCollectionViewCell *)cell;
- (void)mapCollectionViewCellDidTapWithCell:(ZMAXMapCollectionViewCell *)cell;
- (void)customerServiceCellDidTapWithCell:(ZMAXCustomerServiceCell *)cell;

@end

NS_ASSUME_NONNULL_END
