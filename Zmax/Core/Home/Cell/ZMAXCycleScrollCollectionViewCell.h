//
//  ZMAXCycleScrollCollectionViewCell.h
//  Zmax
//
//  Created by 杨杰 on 2021/2/9.
//

#import <UIKit/UIKit.h>
#import "ZMAXHomeCollectionViewCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZMAXCycleScrollCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id <ZMAXHomeCollectionViewCellProtocol> delegate;

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
