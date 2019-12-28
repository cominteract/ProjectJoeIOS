//
//  GoogleMapLocation.h
//  AIBits
//
//  Created by Admin on 3/24/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface GoogleMapLocation : NSObject


@property(strong,nonatomic) CLLocation *currentLocation;
@property(strong,nonatomic) NSString *locationName;
@property(strong,nonatomic) NSString *locationDesc;
@property(strong,nonatomic) NSString *locationAddress;
@property(strong,nonatomic) NSString *locationIcon;
@property double locationLatitude;
@property double locationLongitude;
@end
