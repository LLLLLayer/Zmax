//
//  ZMAXSettingCollectionViewCell.h
//  Zmax
//
//  Created by 杨杰 on 2021/1/17.
//

#import <UIKit/UIKit.h>

extern const CGFloat ZMAXSettingCollectionViewCellHeight;
extern const CGFloat ZMAXSettingCollectionGeneralPadding;

typedef NS_ENUM(NSInteger, ZMAXSettingItem) {
    ZMAXSettingItemUserInterfaceStyle = 0,
    ZMAXSettingItemUserInterfaceStyleWithSystem,
};

@interface ZMAXSettingCollectionViewCellModel : NSObject

@property (nonatomic, assign) ZMAXSettingItem type;

@property (nonatomic,   copy) NSString *titleText;

@property (nonatomic, assign) BOOL isSwitch;
@property (nonatomic, assign) BOOL currentSwitch;
@property (nonatomic, assign) BOOL canSwitchChange;

@property (nonatomic, assign) BOOL isIcon;
@property (nonatomic, assign) UIImage *currentIcon;

@end

@protocol ZMAXSettingCollectionViewCellDelegate <NSObject>

- (void)settingCellBaseViewDidTapWithype:(ZMAXSettingItem)type;
- (void)settingCellSwitchDidChangeWIthType:(ZMAXSettingItem)type currentFlag:(BOOL)flag;
- (void)settingCellIconDidTapWithype:(ZMAXSettingItem)type;

@end

@interface ZMAXSettingCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<ZMAXSettingCollectionViewCellDelegate> delegate;

+ (NSString *)identifier;

- (void)configWithModel:(ZMAXSettingCollectionViewCellModel *)model;

@end

