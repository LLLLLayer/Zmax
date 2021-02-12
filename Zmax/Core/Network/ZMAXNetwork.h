//
//  ZMAXNetwork.h
//  Zmax
//
//  Created by 杨杰 on 2021/2/9.
//

#import <Foundation/Foundation.h>

@class CLLocation;

@interface ZMAXNetwork : NSObject

+ (void)getWeatherWithParams:(NSDictionary *)params complation:(void(^)(BOOL success, NSDictionary * response))complation;

@end

