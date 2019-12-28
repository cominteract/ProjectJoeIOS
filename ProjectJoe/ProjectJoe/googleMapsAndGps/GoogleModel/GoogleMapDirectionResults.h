//
//  GoogleMapDirectionResults.h
//  AIBits
//
//  Created by Admin on 3/24/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Route.h"

@interface GoogleMapDirectionResults : NSObject

@property(strong,nonatomic) NSMutableArray<Route *> *routes;
@end
