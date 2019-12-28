//
//  GoogleMapAccessor.h
//  AIBits
//
//  Created by Admin on 3/24/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleMapDataSample.h"
#import <GoogleMaps/GoogleMaps.h>
#import "GoogleMapsInterface.h"
#import <CoreLocation/CoreLocation.h>
@interface GoogleMapAccessor : NSObject
- (instancetype)initWith:(GoogleMapDataSample *)googleMapDataSample isZoomed:(BOOL)isZoomed mapView:(GMSMapView *)mapView;
- (void)initInterfaces:(id<GoogleMapsProtocol>)googleMapsProtocol;
- (void)zoom:(BOOL)zoomIn;
- (void)moveToLocation:(CLLocation *)location;
- (void)moveToGoogleMapLocation:(GoogleMapLocation *)location;
- (void)mapLocations;
- (void)setGoogleMapLocations:(NSMutableArray *)googleMapLocations;
@end
