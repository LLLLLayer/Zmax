//
//  ZMAXSelectDisplayView.h
//  Zmax
//
//  Created by 杨杰 on 2021/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMAXSelectDisplayView : UIView

@property (nonatomic, strong) dispatch_block_t actionBlock;

- (void)setTitleWithText:(NSString *)text;

- (NSString *)getTitle;

@end

NS_ASSUME_NONNULL_END
