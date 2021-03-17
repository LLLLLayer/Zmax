//
//  ZMAXSelectorCollectionHeaderView.h
//  Zmax
//
//  Created by 杨杰 on 2021/3/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMAXSelectorCollectionHeaderView : UICollectionReusableView

+ (NSString *)identifier;
- (void)setTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
