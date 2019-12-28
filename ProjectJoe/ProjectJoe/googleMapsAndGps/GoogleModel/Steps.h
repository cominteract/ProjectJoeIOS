//
//  Steps.h
//  AIBits
//
//  Created by Admin on 3/24/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "OverviewPolyline.h"
@interface Steps : NSObject
@property(strong,nonatomic) CLLocation *start_location;
@property(strong,nonatomic) CLLocation *end_location;
@property(strong,nonatomic) OverviewPolyline *overviewPolyline;
@property int distanceinMeters;
@property int durationinSeconds;
@property (strong,nonatomic) NSString *travel_mode;

@end
