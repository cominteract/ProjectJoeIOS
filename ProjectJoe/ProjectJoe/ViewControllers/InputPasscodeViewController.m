//
//  InputPasscodeViewController.m
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "InputPasscodeViewController.h"
#import "GivePassSuccessViewController.h"
#import "ShowQrCodeViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface InputPasscodeViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *inputPasscodePassImage;
@property (weak, nonatomic) IBOutlet UILabel *inputPasscodePassDescription;
@property (weak, nonatomic) IBOutlet UITextField *inputPasscodeTextField;

@end

@implementation InputPasscodeViewController
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
- (IBAction)inputPasscodeOkButtonClicked:(id)sender {
    if(_selectedPass && _selectedJoe && _transactionType != TransactionUsingPass)
    {
        GivePassSuccessViewController *givePassSuccessViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"GivePassSuccessViewController"];
        givePassSuccessViewController.selectedPass = _selectedPass;
        givePassSuccessViewController.selectedJoeUser = _selectedJoe;
        givePassSuccessViewController.message = _message;
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:givePassSuccessViewController];
    }
    else
    {
        ShowQrCodeViewController *showQrCodeViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"ShowQrCodeViewController"];
        showQrCodeViewController.selectedPass = _selectedPass;
        showQrCodeViewController.transactionType = _transactionType;
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:showQrCodeViewController];
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    if(_selectedPass)
    {
        _inputPasscodeTextField.delegate = self;
        [_inputPasscodePassImage sd_setImageWithURL:[NSURL URLWithString:_selectedPass.passMerchant.merchantImage]];
        _inputPasscodePassDescription.text = _selectedPass.passDescription;
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
