//
//  ZMAXHomeHeaderView.h
//  Zmax
//
//  Created by 杨杰 on 2021/2/12.
//

#import <UIKit/UIKit.h>

extern const CGFloat kZMAXHomeHeaderViewHeight;

NS_ASSUME_NONNULL_BEGIN

@interface ZMAXHomeHeaderView : UICollectionReusableView

+ (NSString *)identifier;

- (void) configWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

@end

NS_ASSUME_NONNULL_END
