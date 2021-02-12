//
//  ZMAXBaseNavigationController.m
//  Zmax
//
//  Created by 杨杰 on 2021/2/8.
//

#import "ZMAXBaseNavigationController.h"

@interface ZMAXBaseNavigationController ()  <UIGestureRecognizerDelegate>

@end

@implementation ZMAXBaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    UIPanGestureRecognizer * fullScreenGes = [[UIPanGestureRecognizer alloc]initWithTarget:target action:handler];
    fullScreenGes.delegate = self;
    [targetView addGestureRecognizer:fullScreenGes];
    [self.interactivePopGestureRecognizer setEnabled:NO];
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    return self.childViewControllers.count != 1;
}

@end
