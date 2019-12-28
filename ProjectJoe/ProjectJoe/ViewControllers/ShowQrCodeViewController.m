//
//  ShowQrCodeViewController.m
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "ShowQrCodeViewController.h"
#import "DataPasses.h"
@interface ShowQrCodeViewController ()
@property (weak, nonatomic) IBOutlet UIView *showQrCodeContainer;
@property (weak, nonatomic) IBOutlet UILabel *showQrCodeTransactionCode;

@end

@implementation ShowQrCodeViewController

- (IBAction)showQrCodeOkButtonClicked:(id)sender {
    if(_transactionType == TransactionUsingPass)
    {
        Transaction *transaction = [[Transaction alloc]initWith:[[self.fragmentInteractionProtocol onDataPassesRetrieved] joeUser] transactionDate:[self.fragmentInteractionProtocol getCurrentDate] transactionPass:_selectedPass transactionType:TransactionUsingPass];
        [[self.fragmentInteractionProtocol onDataPassesRetrieved] addTransaction:transaction];
        if([[[self.fragmentInteractionProtocol onDataPassesRetrieved] currentPassList] containsObject:_selectedPass])
        {
            [[[self.fragmentInteractionProtocol onDataPassesRetrieved] currentPassList] removeObject:_selectedPass];
           
            [self.navigationController popToRootViewControllerAnimated:YES];
             [self.fragmentInteractionProtocol showToast:@"Pass have been used up"];
        }
    }
    else if(_transactionType == TransactionEarningPoints)
    {
        Transaction *transaction = [[Transaction alloc]initWith:[[self.fragmentInteractionProtocol onDataPassesRetrieved] joeUser] transactionDate:[self.fragmentInteractionProtocol getCurrentDate] transactionPoints:30 transactionType:TransactionEarningPoints];
        [[self.fragmentInteractionProtocol onDataPassesRetrieved] addTransaction:transaction];
        [[self.fragmentInteractionProtocol onDataPassesRetrieved] joeUser].earnedPoints += 30;
        [[self.fragmentInteractionProtocol onDataPassesRetrieved] joeUser].currentPoints += 30;

        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.fragmentInteractionProtocol showToast:@"30 points have been earned"];
        
    }
    else if(_transactionType == TransactionUsingPoints && _selectedPoints)
    {
        Transaction *transaction = [[Transaction alloc]initWith:[[self.fragmentInteractionProtocol onDataPassesRetrieved] joeUser] transactionDate:[self.fragmentInteractionProtocol getCurrentDate] transactionPoints:_selectedPoints.point transactionType:TransactionUsingPoints];
        [[self.fragmentInteractionProtocol onDataPassesRetrieved] addTransaction:transaction];
        [[self.fragmentInteractionProtocol onDataPassesRetrieved] joeUser].usedPoints += _selectedPoints.point;
        [[self.fragmentInteractionProtocol onDataPassesRetrieved] joeUser].currentPoints -= _selectedPoints.point;
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.fragmentInteractionProtocol showToast:@"30 points have been used"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
