//
//  ZMAXNetwork.m
//  Zmax
//
//  Created by 杨杰 on 2021/2/9.
//

#import <AFNetworking.h>

#import "ZMAXBaseLib.h"
#import "ZMAXNetwork.h"

@implementation ZMAXNetwork

+ (NSString *)baseUrl
{
    return @"http://139.196.161.28:8080/";
}

+ (void)getWeatherWithParams:(NSDictionary *)params complation:(void(^)(BOOL success, NSDictionary * response))complation
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"%@%@", [ZMAXNetwork baseUrl],@"/zmax/weather"];
    [manager GET:url
      parameters:params
         headers:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response;
        BOOL success = NO;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            response = (NSDictionary *)responseObject;
            success = YES;
        }
        BLOCK(complation, success, response);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BLOCK(complation, NO, nil);
    }];
}

+ (NSString *)__paramsToUrlWithParams:(NSDictionary *)params
{
    NSMutableString *url = [[NSMutableString alloc] init];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull value, BOOL * _Nonnull stop) {
        [url appendString:[NSString stringWithFormat:@"%@=%@&", key, value]];
    }];
    return [[url substringWithRange:NSMakeRange(0, url.length - 1)] copy];
}

@end
