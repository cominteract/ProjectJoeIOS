//
//  Legs.h
//  AIBits
//
//  Created by Admin on 3/24/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Steps.h"
@interface Legs : NSObject
@property(strong,nonatomic) NSMutableArray<Steps *> *steps;
@property int distanceinMeters;
@property int durationinSeconds;
@end
