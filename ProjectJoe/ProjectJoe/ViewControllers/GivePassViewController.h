//
//  GivePassViewController.h
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "BaseViewController.h"
#import "Pass.h"
@interface GivePassViewController : BaseViewController
@property (strong,nonatomic) Pass *selectedPass;

@property (strong,nonatomic) NSString *selectedName;
@end
