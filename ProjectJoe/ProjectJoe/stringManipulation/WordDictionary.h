//
//  WordDictionary.h
//  AIBits
//
//  Created by andre insigne on 05/12/2017.
//  Copyright © 2017 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Name.h"
@interface WordDictionary : NSObject
- (void)initWords;
- (NSString *)nextWord:(int)posNoun posAdj:(int)posAdj;
- (void )generateNames:(int) count gender:(Gender)gender;
- (NSMutableArray<Name*> *) getNames;
- (NSString *)getRandomName:(int)index;
- (NSMutableArray<Name *> *)getMales;
- (NSMutableArray<Name *> *)getFemales;
- (NSString *)getRandomFemaleFullName:(int)index;
- (NSString *)getRandomMaleFullName:(int)index;
@end
