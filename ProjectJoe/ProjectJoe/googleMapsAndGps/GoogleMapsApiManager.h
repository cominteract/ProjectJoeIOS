//
//  GoogleMapsApiManager.h
//  AIBits
//
//  Created by Admin on 3/24/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleMapLocation.h"
#import "GoogleMapsInterface.h"

@interface GoogleMapsApiManager : NSObject
- (void)startNearbyByName:(id<GoogleMapsProtocol>) googleMapsProtocol_ origin:(GoogleMapLocation *)origin types:(NSString *)types name:(NSString *)name radius:(NSString *)radius;
- (void)startNearbyByKeyword:(id<GoogleMapsProtocol>) googleMapsProtocol_ origin:(GoogleMapLocation *)origin types:(NSString *)types keyword:(NSString *)keyword radius:(NSString *)radius;
- (void)startNearbyByTypes:(id<GoogleMapsProtocol>) googleMapsProtocol_ origin:(GoogleMapLocation *)origin types:(NSString *)types radius:(NSString *)radius;
- (void)getDirection:(GoogleMapLocation *)origin destination:(GoogleMapLocation *)destination googleMapProtocol:(id<GoogleMapsProtocol>)googleMapProtocol;
@end
