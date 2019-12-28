//
//  PointsViewController.m
//  ProjectJoe
//
//  Created by Wylog Mac Mini on 19/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "PointsViewController.h"
#import "DataPasses.h"
#import "InputPasscodeViewController.h"
#import "ShowQrCodeViewController.h"
#import "GivePointsViewController.h"
#import "UsePointsViewController.h"
@interface PointsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *pointsEarned;
@property (weak, nonatomic) IBOutlet UILabel *pointsUsed;
@property (weak, nonatomic) IBOutlet UILabel *pointsReceived;
@property (weak, nonatomic) IBOutlet UILabel *pointsGiven;
@property (weak, nonatomic) IBOutlet UILabel *pointsCurrent;






@end

@implementation PointsViewController
- (IBAction)pointsEarnButtonClicked:(id)sender {
    if([self.fragmentInteractionProtocol onDataPassesRetrieved].isRetrieved)
    {
        ShowQrCodeViewController *showQrCodeViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"ShowQrCodeViewController"];
        
        showQrCodeViewController.transactionType = TransactionEarningPoints;
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:showQrCodeViewController];
    }
    else
    {
        [self.fragmentInteractionProtocol showToast:@"Can't do this yet"];
    }
}

- (IBAction)pointsUseButtonClicked:(id)sender {
    if([self.fragmentInteractionProtocol onDataPassesRetrieved].isRetrieved)
    {
        UsePointsViewController *usePointsViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"UsePointsViewController"];
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:usePointsViewController];
    }
    else
    {
        [self.fragmentInteractionProtocol showToast:@"Can't do this yet"];
    }
}
- (IBAction)pointsGiveButtonClicked:(id)sender {
    if([self.fragmentInteractionProtocol onDataPassesRetrieved].isRetrieved)
    {
        GivePointsViewController *givePointsViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"GivePointsViewController"];
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:givePointsViewController];
    }
    else
    {
        [self.fragmentInteractionProtocol showToast:@"Can't do this yet"];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self updatePoints];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updatePoints
{
    if([[self.fragmentInteractionProtocol onDataPassesRetrieved] currentJoeUser])
    {
        _pointsEarned.text = [NSString stringWithFormat:@"%d",[[self.fragmentInteractionProtocol onDataPassesRetrieved] currentJoeUser].earnedPoints];
        _pointsCurrent.text = [NSString stringWithFormat:@"%d",[[self.fragmentInteractionProtocol onDataPassesRetrieved] currentJoeUser].currentPoints];
        _pointsGiven.text = [NSString stringWithFormat:@"%d",[[self.fragmentInteractionProtocol onDataPassesRetrieved] currentJoeUser].givenPoints];
        _pointsReceived.text = [NSString stringWithFormat:@"%d",[[self.fragmentInteractionProtocol onDataPassesRetrieved] currentJoeUser].receivedPoints];
        _pointsUsed.text = [NSString stringWithFormat:@"%d",[[self.fragmentInteractionProtocol onDataPassesRetrieved] currentJoeUser].usedPoints];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.fragmentInteractionProtocol tabBarFromDiscover:NO];
    [self.navigationController.navigationBar setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#005B7E"]];
    [self updatePoints];

    
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
