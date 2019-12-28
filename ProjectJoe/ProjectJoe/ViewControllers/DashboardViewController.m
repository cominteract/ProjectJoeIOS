//
//  DashboardViewController.m
//  ProjectJoe
//
//  Created by Wylog Mac Mini on 19/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "DashboardViewController.h"
#import "LogoutViewController.h"
#import "UserProfileViewController.h"
#import "ConnectionsViewController.h"
#import "TransactionsViewController.h"
#import "DataPasses.h"
#import "SettingsViewController.h"
@interface DashboardViewController ()

@end

@implementation DashboardViewController

- (IBAction)dashboardProfileClicked:(id)sender {
    if([self.fragmentInteractionProtocol onDataPassesRetrieved].isRetrieved)
    {
        UserProfileViewController *userProfileViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
    
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:userProfileViewController];
    }
    else
    {
        [self.fragmentInteractionProtocol showToast:@" Can't do this yet"];
    }

}

- (IBAction)dashboardConnectionsClicked:(id)sender {
    if([self.fragmentInteractionProtocol onDataPassesRetrieved].isRetrieved)
    {
        ConnectionsViewController *connectionsViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"ConnectionsViewController"];
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:connectionsViewController];
    }
    else
    {
        [self.fragmentInteractionProtocol showToast:@" Can't do this yet"];
    }
    
}


- (IBAction)dashboardSettingsClicked:(id)sender {
    if([self.fragmentInteractionProtocol onDataPassesRetrieved].isRetrieved)
    {
        SettingsViewController *settingsViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"SettingsViewController"];
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:settingsViewController];
    }
    else
    {
        [self.fragmentInteractionProtocol showToast:@" Can't do this yet"];
    }
}


- (IBAction)dashboardTransactionsClicked:(id)sender {
    if([self.fragmentInteractionProtocol onDataPassesRetrieved].isRetrieved)
    {
        TransactionsViewController *transactionsViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"TransactionsViewController"];
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:transactionsViewController];
    }
    else
    {
        [self.fragmentInteractionProtocol showToast:@" Can't do this yet"];
    }
    
}

- (IBAction)dashboardLogoutClicked:(id)sender {
    if([self.fragmentInteractionProtocol onDataPassesRetrieved].isRetrieved)
    {
        LogoutViewController *logoutViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"LogoutViewController"];
        
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:logoutViewController];
    }
    else
    {
        [self.fragmentInteractionProtocol showToast:@" Can't do this yet"];
    }
}








- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.fragmentInteractionProtocol tabBarFromDiscover:NO];
    [self.navigationController.navigationBar setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#005B7E"]];

    
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
