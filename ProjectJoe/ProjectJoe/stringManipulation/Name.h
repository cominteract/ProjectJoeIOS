//
//  Name.h
//  AIBits
//
//  Created by andre insigne on 05/12/2017.
//  Copyright © 2017 andre insigne. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    Male = 1,
    Female = 2,
    Mixed = 3,
} Gender;
@interface Name : NSObject
@property (strong,nonatomic) NSString *firstName;
@property (strong,nonatomic) NSString *lastName;
@property  Gender gender;
- (id)initWith:(Gender )gendr first:(NSString *)first last:(NSString *)last;
- (NSString *)getRandomMaleFullName:(int)index;
- (NSString *)getRandomFemaleFullName:(int)index;
@end
