//
//  LogoutViewController.m
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "LogoutViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DataPasses.h"
@interface LogoutViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *logoutImage;



@end

@implementation LogoutViewController

- (IBAction)logoutOkButtonClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_logoutImage sd_setImageWithURL:[NSURL URLWithString:[[self.fragmentInteractionProtocol onDataPassesRetrieved] currentJoeUser].image]];
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
