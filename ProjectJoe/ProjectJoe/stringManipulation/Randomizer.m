//
//  Randomizer.m
//  AIBits
//
//  Created by andre insigne on 05/12/2017.
//  Copyright © 2017 andre insigne. All rights reserved.
//

#import "Randomizer.h"

@implementation Randomizer
    NSString *const AB = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    NSString *const smallAB = @"abcdefghijklmnopqrstuvwxyz";
    NSString *const smallNumber = @"0123456789";
    NSString *const smallNumberAB = @"0123456789abcdefghijklmnopqrstuvwxyz";

    UIViewController *vc;
    WordDictionary *wordDictionary;
    NSMutableArray *profilePicList;
- (id)init
{
    self = [super init];
    if (self)
    {
        wordDictionary  = [WordDictionary new];
        profilePicList = [NSMutableArray new];
        [wordDictionary initWords];
        // Superclass successfully initialized.
    }
    return self;
}

- (id)initWith:(UIViewController *)viewController
{
    // Initialize the superclass first.
    //
    // Make sure initialization was successful by making sure
    // an instance was returned. If initialization fails, e.g.
    // because we run out of memory, the returned value would
    // be nil.
    self = [super init];
    if (self)
    {
        vc = viewController;
        wordDictionary  = [WordDictionary new];
        //[wordDictionary initWords];
        // Superclass successfully initialized.
    }
    return self;
}

- (NSString *)getRandomFullName
{
    return [wordDictionary getRandomName:[self randInt:0 max:(int)[wordDictionary getNames].count]];
}

- (NSString *)getRandomMaleFullName
{
    return [wordDictionary getRandomMaleFullName:[self randInt:0 max:(int)[wordDictionary getMales].count]];
}
- (NSString *)getRandomFemaleFullName
{
    return [wordDictionary getRandomFemaleFullName:[self randInt:0 max:(int)[wordDictionary getFemales].count]];
}

- (NSString *)getRandomProfilePic
{
    int getR = [self randInt:0 max:(int)[self getRandomProfilePicList].count - 1];
    NSLog(@" Random int %d %lu  ", getR, profilePicList.count);
    return [[self getRandomProfilePicList] objectAtIndex:getR];
}

- (NSMutableArray *)getRandomProfilePicList
{
    if(profilePicList!=nil && profilePicList.count < 1)
    {
        [profilePicList addObject: @"https://randomuser.me/api/portraits/men/46.jpg"];
        [profilePicList addObject: @"https://randomuser.me/api/portraits/men/72.jpg"];
        [profilePicList addObject: @"https://randomuser.me/api/portraits/women/20.jpg"];
        [profilePicList addObject: @"https://randomuser.me/api/portraits/women/21.jpg"];
        [profilePicList addObject: @"https://randomuser.me/api/portraits/women/22.jpg"];
        [profilePicList addObject: @"https://randomuser.me/api/portraits/women/23.jpg"];
        [profilePicList addObject: @"https://randomuser.me/api/portraits/men/24.jpg"];
        [profilePicList addObject: @"https://randomuser.me/api/portraits/men/28.jpg"];
        [profilePicList addObject: @"https://randomuser.me/api/portraits/men/29.jpg"];
        [profilePicList addObject: @"https://randomuser.me/api/portraits/men/11.jpg"];
        [profilePicList addObject: @"https://randomuser.me/api/portraits/women/11.jpg"];
        [profilePicList addObject: @"https://randomuser.me/api/portraits/men/55.jpg"];
        [profilePicList addObject : @"https://randomuser.me/api/portraits/women/55.jpg"];
    }
    return profilePicList;
}

- (Name *)getRandomMale
{
    return [[wordDictionary getMales]objectAtIndex:[self randInt:0 max:(int)[wordDictionary getMales].count - 1]];
}

- (Name *)getRandomFemale
{
    return [[wordDictionary getFemales]objectAtIndex:[self randInt:0 max:(int)[wordDictionary getFemales].count - 1]];
}

- (Name *)getRandomName
{
    return [[self getNames]objectAtIndex:[self randInt:0 max:(int)[self getNames].count - 1]];
}




- (NSString *)getRandomCustomEmail:(int)posAdj posNoun:(int)posNoun
{
    return [wordDictionary nextWord:posNoun posAdj:posAdj];
}

- (NSString *)randomEmail:(int)len
{
    NSString *customEmail = @"";
    if(len > 5) {
        for (int i = 0; i < len - 2; i++)
            customEmail = [customEmail stringByAppendingString:[smallAB substringWithRange:NSMakeRange([self randInt:0 max:(int)smallAB.length], 1)]];
        for (int i = 0; i < 2; i++)
            customEmail = [customEmail stringByAppendingString:[smallNumber substringWithRange:NSMakeRange([self randInt:0 max:(int)smallNumber.length], 1)]];
    }
    else
    {
        int remaining = len - 2;
        int nextlength;
        if(remaining > 1) {
            nextlength = len - remaining;
            for (int i = 0; i < remaining; i++)
                customEmail = [customEmail stringByAppendingString:[smallAB substringWithRange:NSMakeRange([self randInt:0 max:(int)smallAB.length], 1)]];
            for (int i = 0; i < nextlength; i++)
                customEmail = [customEmail stringByAppendingString:[smallNumber substringWithRange:NSMakeRange([self randInt:0 max:(int)smallNumber.length], 1)]];
            
        }
        else
        {
            for (int i = 0; i < len; i++)
                customEmail = [customEmail stringByAppendingString:[smallAB substringWithRange:NSMakeRange([self randInt:0 max:(int)smallAB.length], 1)]];
        }
    }
    return customEmail;
}

- (NSString *)randomCustomPassword:(int)len
{
    NSString *customPassword = @"";
    for (int i = 0; i < len; i++)
        customPassword = [customPassword stringByAppendingString:[AB substringWithRange:NSMakeRange([self randInt:0 max:(int)AB.length], 1)]];
    return customPassword;
}

- (NSString *)randomCustomUserId:(int)len
{
    NSString *customUserId = @"";
    if(len>7)
    {
        for(int i = 0;i<len-2;i++)
            customUserId = [customUserId stringByAppendingString:[AB substringWithRange:NSMakeRange([self randInt:0 max:(int)AB.length], 1)]];
        for(int i = 0;i<2;i++)
            customUserId = [customUserId stringByAppendingString:[smallNumber substringWithRange:NSMakeRange([self randInt:0 max:(int)smallNumber.length], 1)]];
    }
    else
    {
        for (int i = 0; i < len; i++)
            customUserId = [customUserId stringByAppendingString:[AB substringWithRange:NSMakeRange([self randInt:0 max:(int)AB.length], 1)]];
    }
    return customUserId;
}


- (int)randInt:(int)min max:(int)max
{
    int randNum = rand() % (max - min) + min;
    return randNum;
}

- (double)randDouble:(double)min max:(double)max
{
    double diff = max - min;
    return (((double) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + min;
}

- (NSString *)randomFileNameWithExtension:(NSString *)placeholder extension:(NSString *)extension
{
    return [NSString stringWithFormat:@"%f_%@.%@",[[NSDate date] timeIntervalSince1970],placeholder,extension];
}


- (void )generateNames:(int) count gender:(Gender)gender
{
    [wordDictionary generateNames:count gender:gender];
}

- (NSMutableArray <Name *> *)getNames
{
    return [wordDictionary getNames];
}

- (NSString *)randomEmailExtension
{
    NSString *randEmail;
    switch ([self randInt:0 max:4]) {
        case 0:
            randEmail = @"@yahoo.com";
            break;
        case 1:
            randEmail = @"@gmail.com";
            break;
        case 2:
            randEmail = @"@apple.com";
            break;
        case 3:
            randEmail = @"@outlook.com";
            break;
        case 4:
            randEmail = @"@mail.com";
            break;
        default:
            randEmail = @"@mail.com";
            break;
    }
    return randEmail;
}

@end
