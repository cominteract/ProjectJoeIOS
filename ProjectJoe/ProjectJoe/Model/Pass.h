//
//  Pass.h
//  ProjectJoe
//
//  Created by andre insigne on 20/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Merchant;
@class Points;
typedef enum
{
    LockShare,
    LockRedeem,
    LockSurvey,

} LockType;
@interface Pass : NSObject
@property(strong,nonatomic) NSString *passDescription;
@property(strong,nonatomic) NSString *passClaims;
@property(strong,nonatomic) NSString *passType;
@property(strong,nonatomic) NSString *passDuration;
@property(strong,nonatomic) NSString *passLink;
@property(strong,nonatomic) NSString *passImage;

@property int passClaimCount;
@property double passPrice;
@property(strong,nonatomic) Merchant *passMerchant;
@property(strong,nonatomic) Points *passPoints;
@property BOOL isLocked;
@property BOOL isNotified;
@property LockType lockType;


@end
