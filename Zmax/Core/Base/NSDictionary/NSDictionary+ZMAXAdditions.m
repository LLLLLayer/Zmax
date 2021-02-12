//
//  NSDictionary+ZMAXAdditions.m
//  Zmax
//
//  Created by 杨杰 on 2021/2/9.
//

#import "NSDictionary+ZMAXAdditions.h"

@implementation NSDictionary (ZMAXAdditions)

- (id)zmax_objectForKey:(NSString *)key
{
    return [self zmax_objectForKey:key defalutObj:nil];
}

- (id)zmax_objectForKey:(id)aKey ofClass:(Class)aClass
{
    return [self zmax_objectForKey:aKey ofClass:aClass defaultObj:nil];
}

- (int)zmax_intValueForKey:(NSString *)key
{
    return [self zmax_intValueForKey:key defaultValue:0];
}

- (NSInteger)zmax_integerValueForKey:(NSString *)key
{
    return [self zmax_integerValueForKey:key defaultValue:0];
}

- (NSUInteger)zmax_unsignedIntegerValueForKey:(NSString *)key
{
    return [self zmax_unsignedIntegerValueForKey:key defaultValue:0];
}

- (float)zmax_floatValueForKey:(NSString *)key
{
    return [self zmax_floatValueForKey:key defaultValue:0.f];
}

- (double)zmax_doubleValueForKey:(NSString *)key
{
    return [self zmax_doubleValueForKey:key defaultValue:0.];
}

- (long)zmax_longValueForKey:(NSString *)key
{
    return [self zmax_longValueForKey:key defaultValue:0];
}

- (long long)zmax_longlongValueForKey:(NSString *)key
{
    return [self zmax_longlongValueForKey:key defaultValue:0];
}

- (BOOL)zmax_boolValueForKey:(NSString *)key
{
    return [self zmax_integerValueForKey:key defaultValue:0] != 0;
}

- (NSString *)zmax_stringValueForKey:(NSString *)key
{
    return [self zmax_stringValueForKey:key defaultValue:nil];
}

- (NSNumber *)zmax_numberValueForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSNumber class]]) {
        return value;
    } else {
        return nil;
    }
}

- (NSArray *)zmax_arrayValueForKey:(NSString *)key
{
    return [self zmax_arrayValueForKey:key defaultValue:nil];
}

- (NSDictionary *)zmax_dictionaryValueForKey:(NSString *)key
{
    return [self zmax_dictionaryValueForKey:key defalutValue:nil];
}

- (NSString*)zmax_dictionaryToJson
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

- (id)zmax_objectForKey:(NSString *)key defalutObj:(id)defaultObj
{
    id obj = [self objectForKey:key];
    return obj ? obj : defaultObj;
}

- (id)zmax_objectForKey:(id)aKey ofClass:(Class)aClass defaultObj:(id)defaultObj
{
    id obj = [self objectForKey:aKey];
    return (obj && [obj isKindOfClass:aClass]) ? obj : defaultObj;
}

- (int)zmax_intValueForKey:(NSString *)key defaultValue:(int)defaultValue
{
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSString class]]) {
        return [(NSString *)value intValue];
    }
    return (value && [value isKindOfClass:[NSNumber class]]) ? [value intValue] : defaultValue;
}

- (NSInteger)zmax_integerValueForKey:(NSString *)key defaultValue:(NSInteger)defaultValue
{
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSString class]]) {
        return [(NSString *)value integerValue];
    }
    return (value && [value isKindOfClass:[NSNumber class]]) ? [value integerValue] : defaultValue;
}

- (NSUInteger)zmax_unsignedIntegerValueForKey:(NSString *)key defaultValue:(NSUInteger)defaultValue
{
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSString class]]) {
        return (NSUInteger)[(NSString *)value integerValue];
    }
    return (value && [value isKindOfClass:[NSNumber class]]) ? [value unsignedIntegerValue] : defaultValue;
}

- (double)zmax_doubleValueForKey:(NSString *)key defaultValue:(double)defaultValue
{
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSString class]]) {
        return [(NSString *)value doubleValue];
    }
    return (value && [value isKindOfClass:[NSNumber class]]) ? [value doubleValue] : defaultValue;
}

- (float)zmax_floatValueForKey:(NSString *)key defaultValue:(float)defaultValue
{
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSString class]]) {
        return [(NSString *)value floatValue];
    }
    return (value && [value isKindOfClass:[NSNumber class]]) ? [value floatValue] : defaultValue;
}

- (long)zmax_longValueForKey:(NSString *)key defaultValue:(long)defaultValue
{
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSString class]]) {
        return [(NSString *)value integerValue];
    }
    return (value && [value isKindOfClass:[NSNumber class]]) ? [value longValue] : defaultValue;
}

- (long long)zmax_longlongValueForKey:(NSString *)key defaultValue:(long long)defaultValue
{
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSString class]]) {
        return [(NSString *)value longLongValue];
    }
    return (value && [value isKindOfClass:[NSNumber class]]) ? [value longLongValue] : defaultValue;
}

- (NSString *)zmax_stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
    id value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSString class]]) {
        return value;
    }else if(value && [value isKindOfClass:[NSNumber class]]){
        return [value stringValue];
    }else{
        return defaultValue;
    }
}

- (NSArray *)zmax_arrayValueForKey:(NSString *)key defaultValue:(NSArray *)defaultValue
{
    id value = [self objectForKey:key];
    return (value && [value isKindOfClass:[NSArray class]]) ? value : defaultValue;
}

- (NSDictionary *)zmax_dictionaryValueForKey:(NSString *)key defalutValue:(NSDictionary *)defaultValue
{
    id value = [self objectForKey:key];
    return (value && [value isKindOfClass:[NSDictionary class]]) ? value : defaultValue;
}

@end
