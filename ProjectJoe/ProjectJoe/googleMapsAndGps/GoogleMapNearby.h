//
//  GoogleMapNearby.h
//  AIBits
//
//  Created by Admin on 3/24/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Results.h"
@interface GoogleMapNearby : NSObject
@property (strong,nonatomic) NSMutableArray<Results *> *resultList;
@end
