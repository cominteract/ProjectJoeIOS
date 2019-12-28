//
//  GpsTracker.m
//  AIBits
//
//  Created by Admin on 3/24/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import "GpsTracker.h"


@interface GpsTracker()<CLLocationManagerDelegate>
{
    id<GoogleMapsProtocol> googleMapProtocol;
}
@end
@implementation GpsTracker
 CLLocationManager *locationManager;
BOOL isAlreadyUpdated = NO;
- (instancetype)initWith:(id<GoogleMapsProtocol>) googleMapProtocol_
{
    self = [super init];
    if(self)
    googleMapProtocol = googleMapProtocol_;
    return self;
}

- (void)startLocation
{
    locationManager = [[CLLocationManager alloc] init];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if(locations && googleMapProtocol && !isAlreadyUpdated)
    {
        [googleMapProtocol onLocationLoaded:[locations lastObject]];
        isAlreadyUpdated = YES;
    }
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager
{
    
}

- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager
{
    
}

@end
