//
//  ZMAXPromptPopupViewController.m
//  Zmax
//
//  Created by 杨杰 on 2021/1/17.
//

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"

#import "ZMAXPromptPopupViewController.h"

static const CGFloat ZMAXPromptPopupGeneralPadding = 16.0;
static const CGFloat ZMAXPromptPopupCloseIconWidth = 20.0;

@implementation ZMAXPromptPopupModel

@end

@interface ZMAXPromptPopupViewController ()

@property (nonatomic, strong) ZMAXPromptPopupModel *model;

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIView *popupView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *subTitleLable;
@property (nonatomic, strong) UIButton *defaultButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation ZMAXPromptPopupViewController

+ (void)showPromptPopupWithModel:(ZMAXPromptPopupModel *)model
{
    if (!model) {
        return;
    }
    ZMAXPromptPopupViewController *vc = [[ZMAXPromptPopupViewController alloc] initWithModel:model];
    [[ZMAXBaseLib getTopController] presentViewController:vc animated:NO completion:nil];
}

- (instancetype)initWithModel:(ZMAXPromptPopupModel *)model
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.model = model;
        [self __setupUI];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        self.baseView.backgroundColor = [UIColor colorNamed:ZMAXUIColorGeneralMaskBackground];
        self.popupView.frame = CGRectMake(0.0,
                                          SCREEN_HEIGHT - self.popupView.frame.size.height,
                                          self.popupView.frame.size.width,
                                          self.popupView.frame.size.height);
        self.baseView.alpha = 1.0;
    }];
}

- (void)__setupUI
{
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.baseView];
    self.baseView.frame = self.view.bounds;
    
    [self.baseView addSubview:self.popupView];
    
    // 关闭按钮
    
    CGFloat currentY = ZMAXPromptPopupGeneralPadding;
    
    if (self.model.showCloseButton) {
        [self.popupView addSubview:self.closeButton];
        self.closeButton.frame = CGRectMake(SCREEN_WIDTH - ZMAXPromptPopupGeneralPadding - ZMAXPromptPopupCloseIconWidth,
                                            currentY,
                                            ZMAXPromptPopupCloseIconWidth,
                                            ZMAXPromptPopupCloseIconWidth);
        currentY += ZMAXPromptPopupCloseIconWidth;
    }
    currentY += ZMAXPromptPopupGeneralPadding;
    
    // 图片
    if (self.model.image) {
        [self.popupView addSubview:self.imageView];
        self.imageView.image = self.model.image;
        CGFloat width = SCREEN_WIDTH - ZMAXPromptPopupGeneralPadding * 8.0;
        CGFloat height = width * 0.87;
        self.imageView.frame = CGRectMake(ZMAXPromptPopupGeneralPadding * 4.0, currentY, width, height);
        currentY += height + ZMAXPromptPopupGeneralPadding;
    }
    
    // 标题
    if (self.model.title.length) {
        [self.popupView addSubview:self.titleLable];
        self.titleLable.text = self.model.title;
        self.titleLable.frame = CGRectMake(0.0, currentY, SCREEN_WIDTH, 30);
        currentY += 25 + ZMAXPromptPopupGeneralPadding;
    }
    
    // 副标题
    if (self.model.subTitle.length) {
        [self.popupView addSubview:self.subTitleLable];
        self.subTitleLable.text = self.model.subTitle;
        CGSize maxSize = CGSizeMake(SCREEN_WIDTH - ZMAXPromptPopupGeneralPadding * 4.0, MAXFLOAT);
        CGSize size = [self.model.subTitle boundingRectWithSize:maxSize
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17.0]}
                                                        context:nil].size;
        self.subTitleLable.frame = CGRectMake(ZMAXPromptPopupGeneralPadding * 2.0, currentY, maxSize.width, size.height);
        currentY += size.height + ZMAXPromptPopupGeneralPadding;
    }
    
    // 按键
    if (self.model.buttonText.length || self.model.rightButtonText.length) {
        currentY += ZMAXPromptPopupGeneralPadding;
    }
    if (self.model.buttonText.length) {
        [self.popupView addSubview:self.defaultButton];
        [self.defaultButton setTitle:self.model.buttonText forState:UIControlStateNormal];
        self.defaultButton.frame = CGRectMake(ZMAXPromptPopupGeneralPadding,
                                              currentY,
                                              SCREEN_WIDTH - ZMAXPromptPopupGeneralPadding * 2.0,
                                              44);
    }
    
    if (self.model.rightButtonText.length) {
        self.defaultButton.frame = CGRectMake(ZMAXPromptPopupGeneralPadding,
                                              currentY,
                                              SCREEN_WIDTH / 2.0 - ZMAXPromptPopupGeneralPadding * 1.5,
                                              44);
        self.defaultButton.backgroundColor = [UIColor colorNamed:ZMAXUIColorSeparateLineBackground];
        [self.popupView addSubview:self.rightButton];
        [self.rightButton setTitle:self.model.rightButtonText forState:UIControlStateNormal];
        self.rightButton.frame = CGRectMake(SCREEN_WIDTH / 2.0 + ZMAXPromptPopupGeneralPadding * 0.5,
                                            currentY,
                                            SCREEN_WIDTH / 2.0 - ZMAXPromptPopupGeneralPadding * 1.5,
                                            44);
    }
    
    if (self.model.buttonText.length || self.model.rightButtonText.length) {
        currentY += 44 + ZMAXPromptPopupGeneralPadding;
    }
    
    self.popupView.frame = CGRectMake(0.0, SCREEN_HEIGHT, SCREEN_WIDTH, currentY + SAFE_BOTTOM);
    
    // 绘制圆角
    self.baseView.alpha = 0.0;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.popupView.bounds
                                               byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                     cornerRadii:CGSizeMake(20.0, 20.0)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    _popupView.layer.mask = layer;
}

#pragma mark - Setter/Getter

- (UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__dismiss)];
        [_baseView addGestureRecognizer:tapGesture];
    }
    return _baseView;
}

- (UIView *)popupView
{
    if (!_popupView) {
        _popupView = [[UIView alloc] init];
        _popupView.backgroundColor = [UIColor colorNamed:ZMAXUIColorConstWhiteColor];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(__handelPanPopupViewGesture:)];
        [_popupView addGestureRecognizer:panGesture];
    }
    return _popupView;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage systemImageNamed:@"xmark"] forState:UIControlStateNormal];
        _closeButton.imageView.tintColor = [UIColor blackColor];
        [_closeButton addTarget:self action:@selector(__dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor colorNamed:ZMAXUIColorConstBlackColor];
        _titleLable.font = [UIFont systemFontOfSize:18.0 weight:0.5];
    }
    return _titleLable;
}

- (UILabel *)subTitleLable
{
    if (!_subTitleLable) {
        _subTitleLable = [[UILabel alloc] init];
        _subTitleLable.numberOfLines = 0;
        _subTitleLable.textAlignment = NSTextAlignmentCenter;
        _subTitleLable.textColor = [UIColor colorNamed:ZMAXUIColorConstBlackColor];
        _subTitleLable.font = [UIFont systemFontOfSize:17.0];
    }
    return _subTitleLable;
}

- (UIButton *)defaultButton
{
    if (!_defaultButton) {
        _defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _defaultButton.backgroundColor = [UIColor colorNamed:ZMAXUIColorBrandRedColor];
        _defaultButton.layer.cornerRadius = 4.0;
        [_defaultButton setTitleColor:[UIColor colorNamed:ZMAXUIColorConstWhiteColor] forState:UIControlStateNormal];
        _defaultButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [_defaultButton addTarget:self action:@selector(__defaultButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _defaultButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.backgroundColor = [UIColor colorNamed:ZMAXUIColorBrandRedColor];
        _rightButton.layer.cornerRadius = 4.0;
        [_rightButton setTitleColor:[UIColor colorNamed:ZMAXUIColorConstWhiteColor] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [_rightButton addTarget:self action:@selector(__rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

#pragma mark - Action

- (void)__dismiss
{
    [self __dismissWithDuration:0.3];
}

- (void)__dismissWithDuration:(CGFloat)time
{
    [UIView animateWithDuration:time animations:^{
        self.baseView.backgroundColor = [UIColor clearColor];
        self.popupView.frame = CGRectMake(0.0, SCREEN_HEIGHT, SCREEN_WIDTH, self.popupView.frame.size.height);
        self.baseView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)__handelPanPopupViewGesture:(UIPanGestureRecognizer *)gesture
{
    UIView *view = gesture.view;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            CGPoint change = [gesture translationInView:self.view];
            [gesture setTranslation:CGPointZero inView:self.view];
            CGFloat y = MAX(SCREEN_HEIGHT - view.frame.size.height, view.frame.origin.y + change.y);
            view.frame = CGRectMake(0.0, y, view.frame.size.width, view.frame.size.height);
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if ([gesture velocityInView:self.view].y > 180.0 ||
                view.frame.origin.y > SCREEN_HEIGHT - view.frame.size.height / 2.0) {
                [self __dismissWithDuration:0.2];
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                    view.frame = CGRectMake(0.0, SCREEN_HEIGHT - view.frame.size.height, view.frame.size.width, view.frame.size.height);
                }];
            }
            break;
        }
        default:
        {
            break;
        }
    }
}

- (void)__defaultButtonAction:(UIButton *)sender
{
    BLOCK(self.model.buttonBlock);
    [self __dismiss];
}

- (void)__rightButtonAction:(UIButton *)sender
{
    BLOCK(self.model.rightButtonBlock);
    [self __dismiss];
}

@end
