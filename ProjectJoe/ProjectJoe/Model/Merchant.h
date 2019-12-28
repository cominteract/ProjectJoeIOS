//
//  Merchant.h
//  ProjectJoe
//
//  Created by andre insigne on 20/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JoeUser;
@class Pass;
@class Post;
@class Branch;
@interface Merchant : NSObject
@property(strong,nonatomic) NSString *merchantDetails;
@property(strong,nonatomic) NSString *merchantName;
@property(strong,nonatomic) NSString *merchantCaption;
@property(strong,nonatomic) NSString *merchantCategory;
@property(strong,nonatomic) NSString *merchantImage;
@property(strong,nonatomic) NSString *merchantGeoType;
@property(strong,nonatomic) NSString *merchantGeoName;
@property(strong,nonatomic) NSString *merchantContact;

@property(strong,nonatomic) NSString *merchantImageResource;

@property(strong,nonatomic) NSMutableArray<JoeUser *> *merchantJoeUserList;
@property(strong,nonatomic) NSMutableArray<Pass *> *merchantJoePassList;
@property(strong,nonatomic) NSMutableArray<Branch *> *merchantBranchesList;
@property(strong,nonatomic) NSMutableArray<Post *> *merchantPostList;
@end
