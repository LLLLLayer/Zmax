//
//  NSDictionary+ZMAXAdditions.h
//  Zmax
//
//  Created by 杨杰 on 2021/2/9.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ZMAXAdditions)

- (id)zmax_objectForKey:(NSString *)key;
- (id)zmax_objectForKey:(id)aKey ofClass:(Class)aClass;
- (int)zmax_intValueForKey:(NSString *)key;
- (NSInteger)zmax_integerValueForKey:(NSString *)key;
- (NSUInteger)zmax_unsignedIntegerValueForKey:(NSString *)key;
- (float)zmax_floatValueForKey:(NSString *)key;
- (double)zmax_doubleValueForKey:(NSString *)key;
- (long)zmax_longValueForKey:(NSString *)key;
- (long long)zmax_longlongValueForKey:(NSString *)key;
- (BOOL)zmax_boolValueForKey:(NSString *)key;
- (NSString *)zmax_stringValueForKey:(NSString *)key;
- (NSNumber *)zmax_numberValueForKey:(NSString *)key;
- (NSArray *)zmax_arrayValueForKey:(NSString *)key;
- (NSDictionary *)zmax_dictionaryValueForKey:(NSString *)key;

- (NSString*)zmax_dictionaryToJson;

@end
