//
//  ZMAXMapCollectionViewCell.h
//  Zmax
//
//  Created by 杨杰 on 2021/2/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMAXMapCollectionViewCell : UICollectionViewCell

+ (NSString *)identifier;

- (void)changeStyleToNight:(BOOL)night;

@end

NS_ASSUME_NONNULL_END
