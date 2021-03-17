//
//  ZMAXSelectorModel.m
//  Zmax
//
//  Created by 杨杰 on 2021/3/16.
//

#import "ZMAXSelectorModel.h"

@interface ZMAXSelectorModel ()

@property (nonatomic, strong) NSArray<NSString *> *sectionArray;

@end

@implementation ZMAXSelectorModel

- (void)setItemsArray:(NSArray *)itemsArray
{
    _itemsArray = [itemsArray copy];
    
    NSMutableArray<NSString *> *tempSectionArray = [[NSMutableArray alloc] initWithArray:@[@"推荐"]];
    NSMutableDictionary<NSString *, NSMutableArray<NSString *> *> *tempSectionItems = [[NSMutableDictionary alloc] init];
    [_itemsArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.length) {
            if (!tempSectionItems[@"推荐"]) {
                tempSectionItems[@"推荐"] = [[NSMutableArray alloc] init];
            }
            [tempSectionItems[@"推荐"] addObject:obj];
            
            NSMutableString *ms = [[NSMutableString alloc] initWithString:obj];
            CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO);
            CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO);
            NSString *initials = [[ms substringWithRange:NSMakeRange(0, 1)] uppercaseString]; // 首字母
            [tempSectionArray addObject:initials];
            if (!tempSectionItems[initials]) {
                tempSectionItems[initials] = [[NSMutableArray alloc] init];
            }
            [tempSectionItems[initials] addObject:obj];
        }
    }];
    [tempSectionArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 isEqualToString:@"推荐"]) {
            return NO;
        }
        NSString *str1=(NSString *)obj1;
        NSString *str2=(NSString *)obj2;
        return [str1 compare:str2];
    }];
    _sectionArray = [tempSectionArray copy];
    _sectionItems = [tempSectionItems copy];
}

@end
