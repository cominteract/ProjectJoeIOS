//
//  UserProfileViewController.h
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "BaseViewController.h"
#import "JoeUser.h"
@interface UserProfileViewController : BaseViewController
@property(strong,nonatomic) JoeUser *selectedJoeUser;
@end
