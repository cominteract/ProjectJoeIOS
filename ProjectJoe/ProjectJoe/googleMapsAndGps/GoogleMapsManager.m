//
//  GoogleMapsManager.m
//  AIBits
//
//  Created by Admin on 3/22/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import "GoogleMapsManager.h"
@interface GoogleMapsManager()
{
    GoogleMapAccessor *googleMapAccessor;
    id<GoogleMapsProtocol> googleMapsProtocol;
    
}

@end
@implementation GoogleMapsManager

- (instancetype)initWith:(GoogleMapAccessor *)googleMapAccessor_ googleMapsProtocol:(id<GoogleMapsProtocol>)googleMapsProtocol_
{
    self = [super init];
    if(self)
    {
        googleMapAccessor = googleMapAccessor_;
        [googleMapAccessor initInterfaces:googleMapsProtocol];
        googleMapsProtocol = googleMapsProtocol_;
    }
    return self;
}

- (void)zoomIn
{
    [googleMapAccessor zoom:YES];
}

- (void)zoomOut
{
    [googleMapAccessor zoom:NO];
}

- (void)goToLocation:(CLLocation *)location
{
    [googleMapAccessor moveToLocation:location];
}
- (void)goToGoogleMapLocation:(GoogleMapLocation *)location
{
    [googleMapAccessor moveToGoogleMapLocation:location];
}

- (void)mapLocations
{
    [googleMapAccessor mapLocations];
}

@end
