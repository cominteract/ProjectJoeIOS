//
//  BaseViewController.m
//  ProjectJoe
//
//  Created by andre insigne on 21/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.navigationController && [self.navigationController parentViewController])
     self.fragmentInteractionProtocol = ((id<FragmentInteractionProtocol> ) [self.navigationController parentViewController]);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
