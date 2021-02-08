//
//  ZMAXPromptPopupViewController.h
//  Zmax
//
//  Created by 杨杰 on 2021/1/17.
//

#import <UIKit/UIKit.h>

typedef void (^ZMAXPromptPopupBlock)(void);

@interface ZMAXPromptPopupModel : NSObject

@property(nonatomic, assign) BOOL showCloseButton;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *subTitle;
@property(nonatomic, strong) NSString *buttonText;
@property(nonatomic, strong) ZMAXPromptPopupBlock buttonBlock;
@property(nonatomic, strong) NSString *rightButtonText;
@property(nonatomic, strong) ZMAXPromptPopupBlock rightButtonBlock;


@end


@interface ZMAXPromptPopupViewController : UIViewController

+ (void)showPromptPopupWithModel:(ZMAXPromptPopupModel *)model;


@end
