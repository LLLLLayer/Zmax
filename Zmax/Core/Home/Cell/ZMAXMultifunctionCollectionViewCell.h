//
//  ZMAXMultifunctionCollectionViewCell.h
//  Zmax
//
//  Created by 杨杰 on 2021/2/11.
//

#import <UIKit/UIKit.h>
#import "ZMAXHomeCollectionViewCellProtocol.h"

typedef void(^ZMAXMultifunctionItemBlock)(void);

@interface MultifunctionItem : UIView

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) ZMAXMultifunctionItemBlock tapAction;

@end

@interface ZMAXMultifunctionCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id <ZMAXHomeCollectionViewCellProtocol> delegate;

+ (NSString *)identifier;

@end

