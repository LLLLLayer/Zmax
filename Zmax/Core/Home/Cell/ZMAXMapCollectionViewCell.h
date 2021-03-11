//
//  ZMAXMapCollectionViewCell.h
//  Zmax
//
//  Created by 杨杰 on 2021/2/12.
//

#import <UIKit/UIKit.h>
#import "ZMAXHomeCollectionViewCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZMAXMapCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id <ZMAXHomeCollectionViewCellProtocol> delegate;

+ (NSString *)identifier;

- (void)changeStyleToNight:(BOOL)night;

@end

NS_ASSUME_NONNULL_END
