//
//  ZMAXMultifunctionCollectionViewCell.h
//  Zmax
//
//  Created by 杨杰 on 2021/2/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultifunctionItem : UIView

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLable;

@end

@interface ZMAXMultifunctionCollectionViewCell : UICollectionViewCell

+ (NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
