//
//  Results.h
//  AIBits
//
//  Created by Admin on 3/24/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface Results : NSObject
@property(strong,nonatomic) NSString *icon;
@property(strong,nonatomic) NSString *place_id;
@property(strong,nonatomic) NSString *name;
@property BOOL open_now;
@property(strong,nonatomic) CLLocation *location;
@property(strong,nonatomic) NSString *vicinity;
@property(strong,nonatomic) NSMutableArray<NSString *> *types;


@end
