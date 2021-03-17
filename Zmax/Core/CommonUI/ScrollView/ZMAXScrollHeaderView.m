//
//  ZMAXScrollHeaderView.m
//  Zmax
//
//  Created by 杨杰 on 2021/3/15.
//

#import "ZMAXBaseLib.h"
#import "ZMAXUIColor.h"
#import "NSDictionary+ZMAXAdditions.h"

#import "ZMAXScrollHeaderView.h"

@interface ZMAXScrollHeaderView ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, dispatch_block_t> *actionDic;
@property (nonatomic, strong) NSMutableDictionary<NSString *, UIButton *> *buttonDic;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat lastX;

@end

@implementation ZMAXScrollHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.actionDic = [[NSMutableDictionary alloc] init];
        self.buttonDic = [[NSMutableDictionary alloc] init];
        [self addSubview:self.scrollView];
        self.lastX = GENREAL_PADDING;
    }
    return self;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (void)addHeaderWithText:(NSString *)text index:(NSInteger)index action:(dispatch_block_t)action
{
    self.scrollView.frame = self.bounds;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorNamed:ZMAXUIColorTextGeneralBackground] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorNamed:ZMAXUIColorBrandBlueColor] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0 weight:0.1];
    btn.tag = index;
    [btn addTarget:self action:@selector(actionWithButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.actionDic setValue:action forKey:[NSString stringWithFormat:@"%ld", index]];
    [self.buttonDic setValue:btn forKey:[NSString stringWithFormat:@"%ld", index]];
    
    [btn sizeToFit];
    
    [self.scrollView addSubview:btn];
    btn.frame = CGRectMake(self.lastX, 0.0, btn.frame.size.width, self.frame.size.height);
    self.lastX += btn.frame.size.width + GENREAL_PADDING;
    
    self.scrollView.contentSize = CGSizeMake(MAX(self.lastX, self.frame.size.width), self.frame.size.height);
}

- (void)actionWithButton:(UIButton *)sender
{
    dispatch_block_t block = [self.actionDic zmax_objectForKey:[NSString stringWithFormat:@"%ld", sender.tag]];
    block();
    [self setCurrentIndex:sender.tag];
}

- (void)changeToIndex:(NSInteger)index
{
    [self setCurrentIndex:index];
}

- (void)setCurrentIndex:(NSInteger)index
{
    NSString *currentKey = [NSString stringWithFormat:@"%ld", index];
    [self.buttonDic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, UIButton * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([currentKey isEqualToString:key]) {
            obj.selected = YES;
        } else {
            obj.selected = NO;
        }
    }];
}

@end
