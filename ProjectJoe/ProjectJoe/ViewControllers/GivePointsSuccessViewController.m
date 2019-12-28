//
//  GivePointsSuccessViewController.m
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "GivePointsSuccessViewController.h"
#import "ReceivedPointsViewController.h"
@interface GivePointsSuccessViewController ()
@property (weak, nonatomic) IBOutlet UILabel *givePointsSuccessCurrentPoints;
@property (weak, nonatomic) IBOutlet UILabel *givePointsSuccessCaption;

@end

@implementation GivePointsSuccessViewController

- (IBAction)givePointsSuccessOkButtonClicked:(id)sender {
    
    ReceivedPointsViewController *receivedPointsViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"ReceivedPointsViewController"];
    
    receivedPointsViewController.selectedPoints = _selectedPoints;
    receivedPointsViewController.selectedJoeUser = _selectedJoeUser;
    receivedPointsViewController.transactionType = TransactionReceivingPoints;
    receivedPointsViewController.message = _message;
    [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:receivedPointsViewController];
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    if(_selectedPoints && _selectedJoeUser)
    {
        _givePointsSuccessCurrentPoints.text = [NSString stringWithFormat:@"%d pts", [[self.fragmentInteractionProtocol onDataPassesRetrieved] joeUser].currentPoints];
        
        _givePointsSuccessCaption.text = [NSString stringWithFormat:@"You have successfully given %d points to %@", _selectedPoints.point,_selectedJoeUser.fullName];
        
        Transaction *transaction = [[Transaction alloc]initWith:[[self.fragmentInteractionProtocol onDataPassesRetrieved] joeUser] transactionDate:[self.fragmentInteractionProtocol getCurrentDate] transactionPoints:_selectedPoints.point transactionType:TransactionGivingPoints];
        [[self.fragmentInteractionProtocol onDataPassesRetrieved] addTransaction:transaction];

        [[self.fragmentInteractionProtocol onDataPassesRetrieved] joeUser].givenPoints += _selectedPoints.point;
        [[self.fragmentInteractionProtocol onDataPassesRetrieved] joeUser].currentPoints -= _selectedPoints.point;
        [self.fragmentInteractionProtocol showToast:[NSString stringWithFormat:@"%d points have been given to %@ ", _selectedPoints.point,_selectedJoeUser.fullName]];
        
    }
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
