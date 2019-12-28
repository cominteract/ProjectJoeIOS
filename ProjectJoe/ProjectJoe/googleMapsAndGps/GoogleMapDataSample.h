//
//  GoogleMapDataSample.h
//  AIBits
//
//  Created by Admin on 3/24/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleMapLocation.h"
#import "GoogleMapsInterface.h"
#import <CoreLocation/CoreLocation.h>
@interface GoogleMapDataSample : NSObject
@property(strong,nonatomic) NSMutableArray<GoogleMapLocation *> *googleMapLocations;
- (instancetype)initWith:(id<GoogleMapsProtocol>)googleMapsProtocol;

- (void)addLocationsFromNearby:(GoogleMapNearby *)nearby isCleared:(BOOL)isCleared;
- (void)setRandomLocationMaps:(BOOL)isClose;
- (void)setPolyLocationsSample;
- (void)setOwnLocation:(CLLocation *)location;
- (void)setCurrentLocation:(CLLocation *)location;
@property(strong,nonatomic)CLLocation *currentZoomed;

@end
