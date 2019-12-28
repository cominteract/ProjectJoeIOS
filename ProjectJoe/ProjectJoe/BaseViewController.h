//
//  BaseViewController.h
//  ProjectJoe
//
//  Created by andre insigne on 21/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FragmentInteractionInterface.h"
@interface BaseViewController : UIViewController
@property (weak, nonatomic) id<FragmentInteractionProtocol> fragmentInteractionProtocol;
@end
