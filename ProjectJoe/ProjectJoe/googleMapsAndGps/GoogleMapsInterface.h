//
//  GoogleMapsInterface.h
//  AIBits
//
//  Created by Admin on 3/24/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleMapLocation.h"
#import "GoogleMapNearby.h"
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
@protocol GoogleMapsProtocol<NSObject>
- (void)onCameraMove:(GoogleMapLocation *)googleMapLocation;
- (void)onMarkerClick:(GoogleMapLocation *)googleMapLocation;
- (void)onMapLongClick:(GoogleMapLocation *)googleMapLocation;
- (void)onInfoMarkerClick:(GoogleMapLocation *)googleMapLocation;
- (void)onInfoMarkerLongClick:(GoogleMapLocation *)googleMapLocation;
- (void)onInfoMarkerClose:(GoogleMapLocation *)googleMapLocation;
- (void)onMapLocationsLoaded:(NSMutableArray<GoogleMapLocation *> *)googleMapLocation;
- (void)onLocationLoaded:(CLLocation *)location;
- (void)onNearby:(GoogleMapNearby *)googleMapNearby;
- (void)onChangeType:(NSString *)type;
- (void)onPolylineRetrieved:(GMSPolyline *)polyLine;
@end
@interface GoogleMapsInterface : NSObject

@end
