//
//  ZMAXLocationManager.h
//  Zmax
//
//  Created by 杨杰 on 2021/2/9.
//

#import <Foundation/Foundation.h>

extern  NSString * const ZMAXDidUpdateLocationsNotification;

@class CLLocation;

typedef void (^LocationUpdateBlock)(NSArray<CLLocation *> *locations);

@interface ZMAXLocationManager : NSObject

+ (ZMAXLocationManager *)sharedInstance;

- (void)start;

- (NSArray<CLLocation *> *)getCurrentLocations;


@end

