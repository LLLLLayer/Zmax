//
//  ZMAXTabBarImageIconView.h
//  Zmax
//
//  Created by 杨杰 on 2021/1/1.
//

#import <UIKit/UIKit.h>
#import "ZMAXTabBarBaseIconView.h"

@interface ZMAXTabBarImageIconView : ZMAXTabBarBaseIconView

- (instancetype)initWithNormalImage:(UIImage *)normalImage
                      selectedImage:(UIImage *)selectedImage;

@end
