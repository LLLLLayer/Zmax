//
//  ZMAXLocationManager.m
//  Zmax
//
//  Created by 杨杰 on 2021/2/9.
//

#import <CoreLocation/CoreLocation.h>

#import "ZMAXBaseLib.h"
#import "ZMAXLocationManager.h"

 NSString * const ZMAXDidUpdateLocationsNotification = @"ZMAXDidUpdateLocationsNotification";

@interface ZMAXLocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) NSArray<CLLocation *> *locations;
@end


@implementation ZMAXLocationManager

+ (ZMAXLocationManager *)sharedInstance
{
    static ZMAXLocationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZMAXLocationManager alloc] init];
    });
    return manager;
}

- (void)start
{
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}


- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;

    }
    return _locationManager;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    _locations = [locations copy];
    [[NSNotificationCenter defaultCenter] postNotificationName:ZMAXDidUpdateLocationsNotification object:locations];
}

- (NSArray<CLLocation *> *)getCurrentLocations
{
    return self.locations;
}

@end
