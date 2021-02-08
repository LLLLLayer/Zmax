//
//  ZMAXMineViewController.m
//  Zmax
//
//  Created by 杨杰 on 2021/1/2.
//


#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"
#import "ZMAXUserDefaults.h"

#import "ZMAXNavigationBarView.h"
#import "ZMAXMineViewController.h"
#import "ZMAXSettingViewController.h"
#import "ZMAXPromptPopupViewController.h"

@interface ZMAXMineViewController ()

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) ZMAXNavigationBarView *navigationBarView;


@end

@implementation ZMAXMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self __setupUI];
}

- (void)__setupUI
{
    [self.view addSubview:self.baseView];
    self.baseView.frame = self.view.bounds;
    
    [self.view addSubview:self.navigationBarView];
    
}

#pragma mark - Setter/Getter

- (UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor colorNamed:ZMAXUIColorGeneralBackground];
    }
    return _baseView;
}

- (ZMAXNavigationBarView *)navigationBarView
{
    if (!_navigationBarView) {
        _navigationBarView = [[ZMAXNavigationBarView alloc] initWithStyle:ZMAXNavigationBarStyleClear];
        
        UIUserInterfaceStyle currentStyle = UITraitCollection.currentTraitCollection.userInterfaceStyle;
        UIImage *image = [UIImage systemImageNamed:currentStyle == UIUserInterfaceStyleLight ? @"moon.fill" : @"sun.max.fill"];

        weakify(self);
        [_navigationBarView addIconWithType:ZMAXNavigationBarTypeRightIcon icon:[UIImage systemImageNamed:@"gearshape.fill"] action:^(UIImageView *imageView) {
            strongify(weakSelf);
            ZMAXSettingViewController *settingViewController = [[ZMAXSettingViewController alloc] init];
            [strongSelf.navigationController pushViewController:settingViewController animated:YES];
        }];
        
        [_navigationBarView addIconWithType:ZMAXNavigationBarTypeRightSecondIcon icon:image action:^(UIImageView *imageView) {
            if ([ZMAXUserDefaults isCurrentUserInterfaceStyleWithSystem]) {
                ZMAXPromptPopupModel *model = [[ZMAXPromptPopupModel alloc] init];
                model.image = [UIImage imageNamed:@"EquipmentAbnormal"];
                model.title = @"外观切换失败";
                model.subTitle = @"当前外观设置为“外观跟随系统设置”，无法进行外观切换。若需要进行外观切换，请在右上角“设置”中调整。";
                model.buttonText = @"我知道了";
                [ZMAXPromptPopupViewController showPromptPopupWithModel:model];
            } else {
                [ZMAXUserDefaults setIsCurrentUserInterfaceStyleDarkModel:![ZMAXUserDefaults isCurrentUserInterfaceStyleDarkModel]];
            }
            
            // 震动反馈
            UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
            [generator prepare];
            [generator impactOccurred];
            
            // 缩放动画
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.keyTimes = @[@0.0, @0.5, @1.0];
            animation.values = @[@1.0, @0.8, @1.0];
            animation.duration = 0.25;
            [imageView.layer addAnimation:animation forKey:@"iconShrink"];
        }];
    }
    return _navigationBarView;
}


- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    // 确保通过系统途径切换外观 Icon 显示正常
    UIUserInterfaceStyle currentStyle = UITraitCollection.currentTraitCollection.userInterfaceStyle;
    UIImage *image = [UIImage systemImageNamed:currentStyle == UIUserInterfaceStyleLight ? @"moon.fill" : @"sun.max.fill"];
    [self.navigationBarView changeIconWithType:ZMAXNavigationBarTypeRightSecondIcon icon:image];
}

@end
