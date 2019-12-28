//
//  GoogleMapDataSample.m
//  AIBits
//
//  Created by Admin on 3/24/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import "GoogleMapDataSample.h"
#import "Randomizer.h"
@interface GoogleMapDataSample()
{
    id<GoogleMapsProtocol> googleMapsProtocol;
    
    CLGeocoder *geocoder;
    Randomizer *randomizer;
}
@end
@implementation GoogleMapDataSample
int maxLocations = 15;


- (instancetype)initWith:(id<GoogleMapsProtocol>)googleMapsProtocol_
{
    self = [super init];
    if(self)
    {
        googleMapsProtocol = googleMapsProtocol_;
        _googleMapLocations = [NSMutableArray new];
    }
    return self;
}

- (GoogleMapLocation *)getLoc:(CLLocation *)location
{
    GoogleMapLocation *googleMapLocation = [GoogleMapLocation new];
    googleMapLocation.locationName = @"You are here";
    googleMapLocation.locationDesc = @"You are here";
    googleMapLocation.locationAddress = @"You are here";
    googleMapLocation.locationIcon = @"marker";
    if(!location)
    {
        googleMapLocation.locationLatitude = 14.583771;
        googleMapLocation.locationLongitude = 121.059675;
        googleMapLocation.currentLocation = [[CLLocation alloc]initWithLatitude:14.583771 longitude:121.059675];
    }
    else
    {
        googleMapLocation.locationLatitude = location.coordinate.latitude;
        googleMapLocation.locationLongitude = location.coordinate.longitude;
        googleMapLocation.currentLocation = location;
    }
    
    return googleMapLocation;
}

- (void)setCurrentLocation:(CLLocation *)location
{
    if(_googleMapLocations && _googleMapLocations.count > 0)
        [_googleMapLocations removeAllObjects];
    else
        _googleMapLocations = [NSMutableArray new];
    [_googleMapLocations addObject:[self getLoc:location]];
    _currentZoomed = location;
}

- (void)setOwnLocation:(CLLocation *)location
{
    [self setCurrentLocation:location];
    [googleMapsProtocol onMapLocationsLoaded:_googleMapLocations];
}

- (void)setPolyLocationsSample
{
    [_googleMapLocations removeAllObjects];
    GoogleMapLocation *wylog = [GoogleMapLocation new];
    wylog.locationName = @"Wylog";
    wylog.locationAddress = @"Ortigas";
    wylog.locationDesc = @"JMT";
    wylog.locationLatitude = 14.5839333;
    wylog.locationLongitude = 121.0500025;
    wylog.currentLocation = [[CLLocation alloc]initWithLatitude:14.5839333 longitude:121.0500025];
    GoogleMapLocation *cavite = [GoogleMapLocation new];
    cavite.locationName = @"Andre's house";
    cavite.locationAddress = @"Cavite";
    cavite.locationDesc = @"Cardinal village";
    cavite.locationLatitude = 14.3478279;
    cavite.locationLongitude = 120.9471624;
    cavite.currentLocation = [[CLLocation alloc]initWithLatitude:14.3478279 longitude:120.9471624];
    [_googleMapLocations addObject:wylog];
    [_googleMapLocations addObject:cavite];
    [googleMapsProtocol onMapLocationsLoaded:_googleMapLocations];
}

- (void)addLocationsFromNearby:(GoogleMapNearby *)nearby isCleared:(BOOL)isCleared
{
    NSLog(@"called once");
    if(isCleared)
        [self setCurrentLocation:nil];
    if(nearby && nearby.resultList && nearby.resultList!=nil)
    {
        for(Results *result in nearby.resultList)
        {
            GoogleMapLocation *googleMapLocation = [GoogleMapLocation new];
            googleMapLocation.locationName = result.name;
            googleMapLocation.locationIcon = @"marker";
            googleMapLocation.locationLatitude = result.location.coordinate.latitude;
            googleMapLocation.locationLongitude = result.location.coordinate.longitude;
            googleMapLocation.currentLocation = result.location;
            googleMapLocation.locationAddress = result.vicinity;
            googleMapLocation.locationDesc = result.vicinity;
            [_googleMapLocations addObject:googleMapLocation];
        }
    }
    [googleMapsProtocol onMapLocationsLoaded:_googleMapLocations];
    
}

- (CLLocation *)getRandomLocation:(double)lat lon:(double)lon
{
    CLLocation *currentLocation = [[CLLocation alloc]initWithLatitude:[randomizer randDouble:lat-2 max:lat+2]  longitude: [randomizer randDouble: lon-2 max:lon+2]];
    return currentLocation;
}

- (void)setRandomLocationMaps:(BOOL)isClose
{
    if(!geocoder)
    geocoder = [[CLGeocoder alloc] init];
    if(!randomizer)
        randomizer = [[Randomizer alloc]init];
    double sLat;
    double sLong;
    int x = 0;

    if(isClose)
    {
        sLat = 14.347827;
        sLong = 120.9471264;
    }
    else
    {
        sLat = 65.00;
        sLong = 124.00;
    }
    [self adjustMapLocations:sLat sLong:sLong x:x];
}

- (void)adjustMapLocations:(double)sLat sLong:(double)sLong x:(int)x
{
    
    [geocoder reverseGeocodeLocation:[self getRandomLocation:sLat lon:sLong] completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            
            GoogleMapLocation *googleMapLocation = [GoogleMapLocation new];
            googleMapLocation.locationName = ((CLPlacemark *)[placemarks lastObject]).name;
            googleMapLocation.locationAddress = ((CLPlacemark *)[placemarks lastObject]).administrativeArea;
            googleMapLocation.locationDesc = ((CLPlacemark *)[placemarks lastObject]).subAdministrativeArea;
            googleMapLocation.currentLocation = ((CLPlacemark *)[placemarks lastObject]).location;
            googleMapLocation.locationLongitude = ((CLPlacemark *)[placemarks lastObject]).location.coordinate.longitude;
            googleMapLocation.locationLatitude = ((CLPlacemark *)[placemarks lastObject]).location.coordinate.latitude;
            
            googleMapLocation.locationIcon = @"marker";
            [_googleMapLocations addObject:googleMapLocation];
            
            //            addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
            //                                 placemark.subThoroughfare, placemark.thoroughfare,
            //                                 placemark.postalCode, placemark.locality,
            //                                 placemark.administrativeArea,
            //                                 placemark.country];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
        if(x==14)
        {
            [googleMapsProtocol onMapLocationsLoaded:_googleMapLocations];
        }
        else
        {
            int y = x+ 1;
            [self adjustMapLocations:sLat sLong:sLong x:y];
        }
    }];
}

@end
