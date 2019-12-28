//
//  Randomizer.h
//  AIBits
//
//  Created by andre insigne on 05/12/2017.
//  Copyright © 2017 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WordDictionary.h"
@interface Randomizer : NSObject
- (NSString *)randomEmailExtension;
- (NSString *)randomFileNameWithExtension:(NSString *)placeholder extension:(NSString *)extension;
- (double)randDouble:(double)min max:(double)max;
- (int)randInt:(int)min max:(int)max;
- (NSString *)randomCustomUserId:(int)len;
- (NSString *)randomCustomPassword:(int)len;
- (NSString *)randomEmail:(int)len;
- (NSString *)getRandomName;
- (NSString *)getRandomMaleFullName;
- (NSString *)getRandomFemaleFullName;
- (NSMutableArray *)getRandomProfilePicList;
- (NSString *)getRandomProfilePic;
- (id)init;
- (id)initWith:(UIViewController *)viewController;
- (void )generateNames:(int) count gender:(Gender)gender;
- (NSMutableArray <Name *> *)getNames;
@end
