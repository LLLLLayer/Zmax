//
//  ZMAXScrollHeaderView.h
//  Zmax
//
//  Created by 杨杰 on 2021/3/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMAXScrollHeaderView : UIView

- (void)addHeaderWithText:(NSString *)text index:(NSInteger)index action:(dispatch_block_t)action;
- (void)changeToIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
