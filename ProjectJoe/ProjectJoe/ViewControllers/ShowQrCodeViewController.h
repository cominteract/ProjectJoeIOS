//
//  ShowQrCodeViewController.h
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "BaseViewController.h"
#import "DataPasses.h"

@interface ShowQrCodeViewController : BaseViewController
@property (strong,nonatomic) Pass *selectedPass;
@property (strong,nonatomic) Points *selectedPoints;
@property TransactionType transactionType;
@end
