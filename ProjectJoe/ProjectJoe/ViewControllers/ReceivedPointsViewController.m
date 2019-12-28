//
//  ReceivedPointsViewController.m
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "ReceivedPointsViewController.h"

@interface ReceivedPointsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *receivedPointsCaption;
@property (weak, nonatomic) IBOutlet UILabel *receivedPointsMessage;




@end

@implementation ReceivedPointsViewController

- (IBAction)receivedPointsOkButtonClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    if(_selectedPoints && _selectedJoeUser)
    {
        _receivedPointsCaption.text = [NSString stringWithFormat:@" Hurrah You have been given %d points by %@ ", _selectedPoints.point,[self.fragmentInteractionProtocol onDataPassesRetrieved].joeUser.fullName];
        _receivedPointsMessage.text = _message;
        
        Transaction *transaction = [[Transaction alloc]initWith:_selectedJoeUser transactionDate:[self.fragmentInteractionProtocol getCurrentDate] transactionPoints:_selectedPoints.point transactionType:TransactionReceivingPoints];
        [[self.fragmentInteractionProtocol onDataPassesRetrieved] addTransaction:transaction];
 
        _selectedJoeUser.receivedPoints += _selectedPoints.point;
        _selectedJoeUser.currentPoints += _selectedPoints.point;
        [self.fragmentInteractionProtocol showToast:[NSString stringWithFormat:@"%d points have been received from %@ ", _selectedPoints.point,[self.fragmentInteractionProtocol onDataPassesRetrieved].joeUser.fullName]];
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
