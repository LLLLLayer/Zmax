//
//  ZMAXSelectorCollectionViewCell.h
//  Zmax
//
//  Created by 杨杰 on 2021/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMAXSelectorCollectionViewCell : UICollectionViewCell

+ (NSString *)identifier;

@property (nonatomic, strong) UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
