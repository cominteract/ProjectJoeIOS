//
//  ColorUtilities.h
//  ProjectJoe
//
//  Created by andre insigne on 23/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface ColorUtilities : NSObject
- (CAGradientLayer*) addGradient:(UIColor *)colorOne colorTwo:(UIColor *)colorTwo;
- (CAGradientLayer*) addGradientHex:(NSString *)colorOneHex colorTwoHex:(NSString *)colorTwoHex;
- (UIColor *)colorFromHexString:(NSString *)hexString;
@end
