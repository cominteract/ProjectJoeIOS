//
//  DataPasses.h
//  ProjectJoe
//
//  Created by andre insigne on 20/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JoeUser.h"
#import "Merchant.h"
#import "Pass.h"
#import "Points.h"
#import "Post.h"
#import "Branch.h"
#import "Transaction.h"
#import "GoogleMapLocation.h"
#import "FragmentInteractionInterface.h"
//const NSString *kDeal = @"DEAL";
//const NSString *kCoupon = @"COUPON";
//const NSString *kFree = @"FREE";
//const NSString *kChallenge = @"CHALLENGE";
//const NSString *kNews = @"NEWS";
//const NSString *kAd = @"AD";
@interface DataPasses : NSObject
@property(weak,nonatomic) id<FragmentInteractionProtocol> fragmentInteractionProtocol;
@property(strong,nonatomic) JoeUser *joeUser;
@property(strong,nonatomic) NSMutableArray<JoeUser *> *joeUserList;
@property(strong,nonatomic) NSMutableArray<Merchant *> *merchantList;
@property(strong,nonatomic) NSMutableArray<Branch *> *branchList;
@property(strong,nonatomic) NSMutableArray<Pass *> *availablePasses;
@property(strong,nonatomic) NSMutableArray<Pass *> *nearbyAvailablePasses;
@property(strong,nonatomic) NSMutableArray<Pass *> *trendingPasses;
@property(strong,nonatomic) NSMutableArray<Post *> *availablePostList;
@property(strong,nonatomic) NSMutableArray<Pass *> *currentPassList;
@property(strong,nonatomic) NSMutableArray<Post *> *currentPostList;
@property(strong,nonatomic) NSMutableArray<Transaction *> *allTransactionList;
@property(strong,nonatomic) NSMutableArray<GoogleMapLocation *> *availableGoogleMapLocationList;
@property(strong,nonatomic) NSMutableArray<GoogleMapLocation *> *nearestGoogleMapLocationList;
- (void)addTransaction:(Transaction *)transaction;
- (NSMutableArray<Merchant *> *)getMerchantList;
- (NSMutableArray<Pass *> *)getAvailablePasses;
- (NSMutableArray <Pass *> *) getCurrentPassList;
- (void)setBranchListFrom:(NSMutableArray<GoogleMapLocation *> *)googleMapLocationList;
- (NSMutableArray<Post *> *)getAvailablePostList;
- (NSMutableArray<Branch *> *)getBranchesFromMerchant:(Merchant *)merchant;
- (NSMutableArray<Pass *> *)getPassesFromMerchant:(Merchant *)merchant;
- (NSMutableArray<Post *> *)getPostsFromMerchant:(Merchant *)merchant;
- (NSMutableArray <JoeUser * > *) getUsersListFromMerchant:(Merchant *)merchant;
- (instancetype)initWithFragmentInteractionProtocol:(id<FragmentInteractionProtocol>)protocol;
- (JoeUser *)currentJoeUser;
- (NSMutableArray<JoeUser *> *)getJoeUserList;
- (NSMutableArray<Transaction *> *)getTransactionFromUser:(JoeUser *)joeUser;
- (NSMutableArray<Pass *> *)getAvailablePassesFrom:(NSString *)category;
- (NSMutableArray<GoogleMapLocation *> *)getLocationsFromMerchant:(Merchant *)merchant;
@property BOOL isRetrieved;
    
@end
