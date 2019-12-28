//
//  Post.h
//  ProjectJoe
//
//  Created by andre insigne on 20/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Merchant;
@class JoeUser;
@class Points;
@class Branch;
@interface Post : NSObject
@property(strong,nonatomic) NSString *postCaption;
@property(strong,nonatomic) NSString *postDetails;
@property(strong,nonatomic) NSString *postDate;
@property(strong,nonatomic) NSString *postImage;
@property int postPoints;
@property(strong,nonatomic) Merchant *postMerchant;
@property(strong,nonatomic) JoeUser *postUser;
@property(strong,nonatomic) Branch *postBranch;
@end
