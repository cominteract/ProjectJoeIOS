//
//  ReceivedPointsViewController.h
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "BaseViewController.h"
#import "DataPasses.h"
@interface ReceivedPointsViewController : BaseViewController
@property (strong,nonatomic) Points *selectedPoints;
@property (strong,nonatomic) JoeUser *selectedJoeUser;
@property TransactionType transactionType;
@property (strong,nonatomic) NSString *message;
@end
