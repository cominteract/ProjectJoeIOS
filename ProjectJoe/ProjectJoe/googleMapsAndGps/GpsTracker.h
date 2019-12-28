//
//  GpsTracker.h
//  AIBits
//
//  Created by Admin on 3/24/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "GoogleMapsInterface.h"
#import <UIKit/UIKit.h>
@interface GpsTracker : NSObject
- (instancetype)initWith:(id<GoogleMapsProtocol>) googleMapProtocol_;
- (void)startLocation;
@end
