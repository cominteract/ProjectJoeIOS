//
//  WordDictionary.m
//  AIBits
//
//  Created by andre insigne on 05/12/2017.
//  Copyright © 2017 andre insigne. All rights reserved.
//

#import "WordDictionary.h"

@implementation WordDictionary
NSArray *nouns;
NSArray *adjectives;
NSMutableArray *lastNameList;
NSMutableArray *maleNameList;
NSMutableArray *femaleNameList;
NSMutableArray<Name *> *nameList;
NSMutableArray<Name *> *maleList;
NSMutableArray<Name *> *femaleList;
- (void)initWords
{
    NSString* adjPath = [[NSBundle mainBundle] pathForResource:@"a"
                                                     ofType:@"txt"];
    NSString* nounPath = [[NSBundle mainBundle] pathForResource:@"n"
                                                        ofType:@"txt"];
    
    NSError *adjErr;
    NSError *nounErr;
    NSString* adjContent = [NSString stringWithContentsOfFile:adjPath
                                                  encoding:NSUTF8StringEncoding
                                                     error:&adjErr];
    NSString *nounContent = [NSString stringWithContentsOfFile:nounPath
                                                     encoding:NSUTF8StringEncoding
                                                        error:&nounErr];
    
    adjectives = [adjContent componentsSeparatedByString:@"\n"];
    nouns = [nounContent componentsSeparatedByString:@"\n"];
    
}


- (void )generateNames:(int) count gender:(Gender)gender
{
    [self generateList:count gender:Male];
    [self generateList:count gender:Female];
    [self generateList:count gender:Mixed];
    [self generateNamesFrom:gender];
}


- (NSString *)getRandomName:(int)index
{
    return [NSString stringWithFormat:@"%@ %@", [nameList objectAtIndex:index].firstName, [nameList objectAtIndex:index].lastName];
}

- (NSString *)getRandomMaleFullName:(int)index
{
    
    //[maleNameList objectAtIndex:index]
    return [NSString stringWithFormat:@"%@ %@", [maleList objectAtIndex:index].firstName, [maleList objectAtIndex:index].lastName];
}

- (NSString *)getRandomFemaleFullName:(int)index
{
    return [NSString stringWithFormat:@"%@ %@", [femaleList objectAtIndex:index].firstName, [femaleList objectAtIndex:index].lastName];
}

- (NSMutableArray<Name*> *) getNames
{
    return nameList;
}

- (void )generateList:(int) count gender:(Gender)gender
{
    NSString* fileName;
    switch (gender) {
        case Male:
            fileName = @"dist_male_first";
            break;
        case Female:
            fileName = @"dist_female_first";
            break;
        default:
            fileName = @"dist_all_last";
            break;
    }
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName
                                                         ofType:@"txt"];
    if(gender == Male)
        [self generateMale:count array:[[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding
                                                     error:nil] componentsSeparatedByString:@"\n"]];
    else if(gender == Female)
        [self generateFemale:count array:[[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding
                                                                       error:nil] componentsSeparatedByString:@"\n"]];
    else
        [self generateSurnames:count];
}



- (NSArray *)getGenderArray
{
    return @[maleNameList,femaleNameList];
}

- (void)generateNamesFrom:(Gender)gender
{
    Name *name;
    nameList = [NSMutableArray new];
    maleList = [NSMutableArray new];
    femaleList = [NSMutableArray new];
    NSLog(@" LastNme count %lu ", lastNameList.count);
    for(int n = 0;n<lastNameList.count;n++)
    {
        
        if(gender!=Mixed)
        {
            name = [[Name alloc]initWith:gender first:[[self getGenderArray][gender] objectAtIndex:n] last:[lastNameList objectAtIndex:n]];
            if(gender == 0)
                [maleList addObject:name];
            else
                [femaleList addObject:name];
        }
        else
        {
            int randomGender = arc4random() % 2;
            name = [[Name alloc]initWith:randomGender first:[[self getGenderArray][randomGender] objectAtIndex:n] last:[lastNameList objectAtIndex:n]];
            if(randomGender == 0)
                [maleList addObject:name];
            else
                [femaleList addObject:name];
        }
        [nameList addObject:name];
        
    }
    NSLog(@" Name count %lu ", nameList.count);
    [femaleNameList removeAllObjects];
    [maleNameList removeAllObjects];
}

- (NSMutableArray<Name *> *)getMales
{
    return maleList;
}
- (NSMutableArray<Name *> *)getFemales
{
    return femaleList;
}

- (void)generateMale:(int)count array:(NSArray *)array
{
    maleNameList = [NSMutableArray new];
    NSLog(@" Sample Male %@ ", [[array objectAtIndex:0] componentsSeparatedByString:@" "][0]);
    for(int n = 0;n<count;n++)
    {
        [maleNameList addObject:[[array objectAtIndex:n]componentsSeparatedByString:@" "][0]];
    }
}

- (void )generateFemale:(int) count array:(NSArray *)array
{
    femaleNameList = [NSMutableArray new];
    for(int n = 0;n<count;n++)
    {
        [femaleNameList addObject:[[array objectAtIndex:n]componentsSeparatedByString:@" "][0]];
    }
}

- (void )generateSurnames:(int)count
{
    NSString* lastNamePath = [[NSBundle mainBundle] pathForResource:@"dist_all_last"
                                                             ofType:@"txt"];
    NSArray *array = [[NSString stringWithContentsOfFile:lastNamePath
                                                encoding:NSUTF8StringEncoding
                                                   error:nil] componentsSeparatedByString:@"\n"];
    
    lastNameList = [NSMutableArray new];
    for(int n = 0;n<count;n++)
    {
        [lastNameList addObject:[[array objectAtIndex:n]componentsSeparatedByString:@" "][0]];
    }
}

- (NSString *)nextWord:(int)posNoun posAdj:(int)posAdj
{
    return [NSString stringWithFormat:@"%@_%@",[adjectives objectAtIndex:posAdj],[nouns objectAtIndex:posNoun]];
}


@end
