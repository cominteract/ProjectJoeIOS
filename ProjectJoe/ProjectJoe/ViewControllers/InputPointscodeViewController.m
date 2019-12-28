//
//  InputPointscodeViewController.m
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "InputPointscodeViewController.h"
#import "GivePointsSuccessViewController.h"
#import "ShowQrCodeViewController.h"
@interface InputPointscodeViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *inputPointscodeCaption;

@property (weak, nonatomic) IBOutlet UITextField *inputPointsCodeTextField;


@end

@implementation InputPointscodeViewController

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)inputPointscodeOkButtonClicked:(id)sender {
    
    if(_selectedPoints && _selectedJoeUser && _transactionType == TransactionGivingPoints)
    {
        GivePointsSuccessViewController *givePointsSuccessViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"GivePointsSuccessViewController"];
      
        givePointsSuccessViewController.selectedPoints = _selectedPoints;
        givePointsSuccessViewController.selectedJoeUser = _selectedJoeUser;
        givePointsSuccessViewController.transactionType = TransactionGivingPoints;
        givePointsSuccessViewController.message = _message;
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:givePointsSuccessViewController];
    }
    else if(_selectedPoints && _transactionType == TransactionUsingPoints)
    {
        ShowQrCodeViewController *showQrCodeViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"ShowQrCodeViewController"];
        showQrCodeViewController.transactionType = TransactionUsingPoints;
        showQrCodeViewController.selectedPoints = _selectedPoints;
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:showQrCodeViewController];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _inputPointsCodeTextField.delegate = self;
    if(_selectedPoints && _selectedJoeUser && _transactionType == TransactionGivingPoints)
    {
        _inputPointscodeCaption.text = [NSString stringWithFormat:@" You are about to give %d points to %@ ",_selectedPoints.point,_selectedJoeUser.fullName];
    }
    else if(_selectedPoints && _selectedJoeUser && _transactionType == TransactionUsingPoints)
    {
        _inputPointscodeCaption.text = [NSString stringWithFormat:@" You are about to use %d points to %@ ",_selectedPoints.point,_selectedJoeUser.fullName];
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
