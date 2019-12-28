//
//  Branch.h
//  ProjectJoe
//
//  Created by andre insigne on 20/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Merchant;
@class Post;
@class GoogleMapLocation;
@interface Branch : NSObject
@property(strong,nonatomic) NSString *branchDetails;
@property(strong,nonatomic) NSString *branchName;
@property(strong,nonatomic) NSString *branchAddress;
@property(strong,nonatomic) NSString *branchContact;
@property(strong,nonatomic) Merchant *branchMerchant;
@property(strong,nonatomic) GoogleMapLocation *googleMapLocation;
@property(strong,nonatomic) NSArray<Post *> *branchTaggedPost;
@end

