//
//  GoogleMapsManager.h
//  AIBits
//
//  Created by Admin on 3/22/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleMapAccessor.h"
#import "GoogleMapsInterface.h"
#import <GoogleMaps/GoogleMaps.h>
@interface GoogleMapsManager : NSObject
- (void)mapLocations;
- (void)goToGoogleMapLocation:(GoogleMapLocation *)location;
- (void)goToLocation:(CLLocation *)location;
- (void)zoomOut;
- (void)zoomIn;
- (instancetype)initWith:(GoogleMapAccessor *)googleMapAccessor_ googleMapsProtocol:(id<GoogleMapsProtocol>)googleMapsProtocol_;
@end
