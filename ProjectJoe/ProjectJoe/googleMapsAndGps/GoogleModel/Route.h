//
//  Route.h
//  AIBits
//
//  Created by Admin on 3/24/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OverviewPolyline.h"
#import "Legs.h"
@interface Route : NSObject
@property(strong,nonatomic) OverviewPolyline *overviewPolyline;
@property(strong,nonatomic) NSMutableArray<Legs *> *legs;
@property double distance;
@property double duration;
@end
