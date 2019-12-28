//
//  UsersPopOverViewController.h
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "BaseViewController.h"

#import "UserInteractionInterface.h"
@interface UsersPopOverViewController : BaseViewController

@property (weak,nonatomic) id<UserInteractionProtocol> userprotocol;
@end
