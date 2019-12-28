//
//  JoeUser.h
//  ProjectJoe
//
//  Created by andre insigne on 20/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pass.h"
#import "Post.h"
#import "Points.h"
@class Transaction;

@class GoogleMapLocation;
@interface JoeUser : NSObject
@property(strong,nonatomic) NSString *userName;
@property(strong,nonatomic) NSString *fullName;
@property(strong,nonatomic) NSString *email;
@property(strong,nonatomic) NSString *image;
@property(strong,nonatomic) NSString *birthday;
@property(strong,nonatomic) NSString *phone;
@property(strong,nonatomic) NSString *facebook;
@property(strong,nonatomic) NSString *branchDetails;
@property(strong,nonatomic) GoogleMapLocation *googleMapLocation;
@property int currentPoints;
@property int givenPoints;
@property int earnedPoints;
@property int usedPoints;
@property int receivedPoints;
@property int merchantPoints;
@property(strong,nonatomic) NSMutableArray<JoeUser *> *friendList;
@property(strong,nonatomic) NSMutableArray<Pass *> *passList;
@property(strong,nonatomic) NSMutableArray<Post *> *postList;
@property(strong,nonatomic) NSMutableArray<Points *> *pointsList;
@property(strong,nonatomic) NSMutableArray<Transaction *> *transactionList;

@end
