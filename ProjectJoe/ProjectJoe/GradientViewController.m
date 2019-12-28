//
//  GradientViewController.m
//  ProjectJoe
//
//  Created by andre insigne on 23/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "GradientViewController.h"

@interface GradientViewController ()

@end

@implementation GradientViewController
ColorUtilities *colorUtilities;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!colorUtilities)
    colorUtilities = [ColorUtilities new];
    CAGradientLayer *bgLayer = [colorUtilities addGradientHex:@"#41436d" colorTwoHex:@"#7377a3"];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
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
