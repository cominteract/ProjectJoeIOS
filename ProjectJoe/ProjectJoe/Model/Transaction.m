//
//  Transaction.m
//  ProjectJoe
//
//  Created by andre insigne on 20/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction

- (instancetype)initWith:(JoeUser *)transactionJoeUser transactionDate:(NSString *)transactionDate transactionPoints:(int)transactionPoints transactionType:(TransactionType )transactionType
{
    self = [super init];
    if(self)
    {
        self.transactionImage = transactionJoeUser.image;
        self.transactionDate = transactionDate;
        self.transactionType = transactionType;
        if(transactionType == TransactionReceivingPoints)
        {
            
            self.transactionPointsReceived = transactionPoints;
            self.transactionJoeUserGiver = transactionJoeUser;
            self.transactionTitle = @"Points Received Successfully";
            self.transactionDetails = [NSString stringWithFormat:@"Claimed %d points from %@ at %@",transactionPoints,transactionJoeUser.fullName ,transactionDate];
        }
        else if(transactionType == TransactionGivingPoints)
        {
            
            self.transactionPointsReceived = transactionPoints;
            self.transactionJoeUserGiver = transactionJoeUser;
            self.transactionTitle = @"Points Given Successfully";
            self.transactionDetails = [NSString stringWithFormat:@"Given %d points to %@ at %@",transactionPoints,transactionJoeUser.fullName ,transactionDate];
        }
        else if(transactionType == TransactionUsingPoints)
        {
            
            self.transactionPointsReceived = transactionPoints;
            self.transactionJoeUserGiver = transactionJoeUser;
            self.transactionTitle = @"Points Used Successfully";
            self.transactionDetails = [NSString stringWithFormat:@"Used %d points from %@ at %@",transactionPoints,transactionJoeUser.fullName ,transactionDate];
        }
        else{
            self.transactionPointsReceived = transactionPoints;
            self.transactionJoeUserGiver = transactionJoeUser;
            self.transactionTitle = @"Points Earned Successfully";
            self.transactionDetails = [NSString stringWithFormat:@"Earned %d points from %@ at %@",transactionPoints,transactionJoeUser.fullName ,transactionDate];
        }
    }
    return self;
}


- (instancetype)initWith:(JoeUser *)transactionJoeUser transactionDate:(NSString *)transactionDate transactionPass:(Pass *)transactionPass transactionType:(TransactionType )transactionType
{
    self = [super init];
    if(self)
    {
        self.transactionImage = transactionJoeUser.image;
        self.transactionDate = transactionDate;
        self.transactionType = transactionType;
        if(transactionType == TransactionReceivingPass)
        {
            
            self.transactionPass = transactionPass;
            self.transactionJoeUserGiver = transactionJoeUser;
            self.transactionTitle = @"Pass Received Successfully";
            self.transactionDetails = [NSString stringWithFormat:@"Claimed %@ pass from %@ at %@",transactionPass.passDescription,transactionJoeUser.fullName ,transactionDate];
        }
        else if(transactionType == TransactionGivingPoints)
        {
            
            self.transactionPass = transactionPass;
            self.transactionJoeUserReceiver = transactionJoeUser;
            self.transactionTitle = @"Pass Given Successfully";
            self.transactionDetails = [NSString stringWithFormat:@"Given %@ pass to %@ at %@",transactionPass.passDescription,transactionJoeUser.fullName ,transactionDate];
        }
        else if(transactionType == TransactionUsingPoints)
        {
            
            self.transactionPass = transactionPass;
            self.transactionJoeUserReceiver = transactionJoeUser;
            self.transactionTitle = @"Points Shared Successfully";
            self.transactionDetails = [NSString stringWithFormat:@"Shared %@ by  %@ at %@",transactionPass.passDescription,transactionJoeUser.fullName ,transactionDate];
        }
    
    }
    return self;
}

- (instancetype)initWith:(JoeUser *)transactionJoeUser transactionDate:(NSString *)transactionDate transactionPost:(Post *)transactionPost transactionType:(TransactionType )transactionType
{
    self = [super init];
    if(self)
    {
        self.transactionImage = transactionJoeUser.image;
        self.transactionDate = transactionDate;
        self.transactionType = transactionType;
        self.transactionJoeUserReceiver = transactionJoeUser;
        self.transactionTitle = @"Posted Successfully";
        self.transactionDetails = [NSString stringWithFormat:@"Posted %@ by  %@ at %@",transactionPost.postBranch.branchName,transactionJoeUser.fullName ,transactionDate];
    }
    return self;
}

- (void)setOtherTransactionUser:(JoeUser *)joeUser
{
    if(self.transactionJoeUserGiver!=nil)
    {
        _transactionJoeUserReceiver = joeUser;
    }
    else
        _transactionJoeUserGiver = joeUser;
    if(self.transactionType == TransactionGivingPoints || self.transactionType == TransactionGivingPass)
    {
        
    }
    else
        self.transactionImage = joeUser.image;
    
    
}

@end
