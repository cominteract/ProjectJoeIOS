//
//  PassesDetailViewController.h
//  ProjectJoe
//
//  Created by andre insigne on 21/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "BaseViewController.h"
#import "Pass.h"
@interface PassesDetailViewController : BaseViewController

@property BOOL fromDiscover;
@property (strong,nonatomic) Pass *selectedPass;
@end
