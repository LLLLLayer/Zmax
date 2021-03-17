//
//  ZMAXSelectorModel.h
//  Zmax
//
//  Created by 杨杰 on 2021/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^selectorBlock)(NSString *selected);

@interface ZMAXSelectorModel : NSObject

@property (nonatomic,   copy) NSString *title;
@property (nonatomic, strong) selectorBlock action;
@property (nonatomic, strong) NSArray *itemsArray;

@property (nonatomic, strong, readonly) NSArray<NSString *> *sectionArray;
@property (nonatomic, strong, readonly) NSDictionary<NSString *, NSArray<NSString *> *> *sectionItems;

@end

NS_ASSUME_NONNULL_END
