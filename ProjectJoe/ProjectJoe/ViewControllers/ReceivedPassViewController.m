//
//  ReceivedPassViewController.m
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "ReceivedPassViewController.h"

@interface ReceivedPassViewController ()

@property (weak, nonatomic) IBOutlet UILabel *receivedPassPassName;
@property (weak, nonatomic) IBOutlet UILabel *receivedPassPassDetails;

@property (weak, nonatomic) IBOutlet UILabel *receivedPassPassClaims;
@property (weak, nonatomic) IBOutlet UILabel *receivedPassPassDuration;

@property (weak, nonatomic) IBOutlet UILabel *receivedPassJoeUserCaption;
@property (weak, nonatomic) IBOutlet UITextView *receivedPassMessageTextView;



@end

@implementation ReceivedPassViewController



- (IBAction)receivedPassOkButtonClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    if(_selectedPass && _selectedJoeUser)
    {
        _receivedPassPassName.text = _selectedPass.passMerchant.merchantName;
        _receivedPassPassClaims.text = _selectedPass.passClaims;
        _receivedPassPassDetails.text = _selectedPass.passDescription;
        _receivedPassPassDuration.text = _selectedPass.passDuration;
        _receivedPassJoeUserCaption.text = [NSString stringWithFormat:@"From : %@",_selectedJoeUser.fullName];
        _receivedPassMessageTextView.text = _message;
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
