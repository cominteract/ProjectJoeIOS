//
//  Transaction.h
//  ProjectJoe
//
//  Created by andre insigne on 20/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JoeUser.h"
@class Post;
@class Pass;
#import "Branch.h"
typedef enum {
    TransactionGivingPoints,
    TransactionReceivingPoints,
    TransactionReceivingPass,
    TransactionGivingPass,
    TransactionPost,
    TransactionUsingPoints,
    TransactionUsingPass,
    TransactionEarningPoints,
}TransactionType;
@interface Transaction : NSObject
@property TransactionType transactionType;
@property(strong,nonatomic) NSString *transactionTitle;
@property(strong,nonatomic) NSString *transactionDetails;
@property(strong,nonatomic) NSString *transactionDate;
@property(strong,nonatomic) NSString *transactionImage;
@property  int transactionPointsGiven;
@property  int transactionPointsReceived;
@property(strong,nonatomic)JoeUser *transactionJoeUserGiver;
@property(strong,nonatomic)JoeUser *transactionJoeUserReceiver;
@property(strong,nonatomic)Post *transactionPost;
@property(strong,nonatomic)Pass *transactionPass;

- (instancetype)initWith:(JoeUser *)transactionJoeUser transactionDate:(NSString *)transactionDate transactionPass:(Pass *)transactionPass transactionType:(TransactionType )transactionType;
- (instancetype)initWith:(JoeUser *)transactionJoeUser transactionDate:(NSString *)transactionDate transactionPost:(Post *)transactionPost transactionType:(TransactionType )transactionType;
- (void)setOtherTransactionUser:(JoeUser *)joeUser;
- (instancetype)initWith:(JoeUser *)transactionJoeUser transactionDate:(NSString *)transactionDate transactionPoints:(int)transactionPoints transactionType:(TransactionType )transactionType;

@end
