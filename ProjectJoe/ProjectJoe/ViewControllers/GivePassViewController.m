//
//  GivePassViewController.m
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "GivePassViewController.h"
#import "DataPasses.h"
#import "UserInteractionInterface.h"
#import "UsersPopOverViewController.h"
#import "InputPasscodeViewController.h"
@interface GivePassViewController ()<UserInteractionProtocol, UIPopoverPresentationControllerDelegate, UITextFieldDelegate>
{
    JoeUser * selectedJoeUser;
}
@property (weak, nonatomic) IBOutlet UITextField *givePassUserTextField;
@property (weak, nonatomic) IBOutlet UILabel *givePassPassDetails;
@property (weak, nonatomic) IBOutlet UILabel *givePassPassTitle;

@property (weak, nonatomic) IBOutlet UILabel *givePassPassClaims;

@property (weak, nonatomic) IBOutlet UILabel *givePassPassDuration;

@property (weak, nonatomic) IBOutlet UILabel *givePassPassType;

@property (weak, nonatomic) IBOutlet UITextView *givePassMessage;
@property (weak, nonatomic) IBOutlet UIButton *givePassUserButton;


@end

@implementation GivePassViewController

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

-(void)onSelected:(JoeUser *)selectedJoe
{
    selectedJoeUser = selectedJoe;
    [_givePassUserButton setTitle:selectedJoe.fullName forState:UIControlStateNormal];
}

-(void)onChangedName:(NSString *)selectedName
{

}



- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection
{
    return UIModalPresentationNone;
}

- (IBAction)givePassOkButtonClicked:(id)sender {
    
    if(_selectedPass && selectedJoeUser)
    {
        InputPasscodeViewController *inputPasscodeViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"InputPasscodeViewController"];
        inputPasscodeViewController.selectedPass = _selectedPass;
        inputPasscodeViewController.selectedJoe = selectedJoeUser;
        inputPasscodeViewController.transactionType = TransactionGivingPass;
        inputPasscodeViewController.message = _givePassMessage.text;
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:inputPasscodeViewController];
    }
    else
    {
        [self.fragmentInteractionProtocol showToast:@" Can't do this yet "];
    }
    
}



- (IBAction)givePassUserTextFieldClicked:(id)sender {
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    if(_selectedPass)
    {
        _givePassPassType.text = _selectedPass.passType;
        _givePassPassTitle.text = _selectedPass.passMerchant.merchantName;
        _givePassPassClaims.text = _selectedPass.passClaims;
        _givePassPassDuration.text = _selectedPass.passDuration;
        _givePassPassDetails.text = _selectedPass.passDescription;
    }
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(_givePassUserButton && selectedJoeUser)
    {
        [_givePassUserButton setTitle:selectedJoeUser.fullName forState:UIControlStateNormal];
    }

        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"UserInteraction"])
    {
        UsersPopOverViewController *usersPopOverViewController = (UsersPopOverViewController *)[segue destinationViewController];
        [segue destinationViewController].popoverPresentationController.delegate = self;
        
        usersPopOverViewController.fragmentInteractionProtocol = self.fragmentInteractionProtocol;
        
        usersPopOverViewController.modalPresentationStyle = UIModalPresentationPopover;
        
        usersPopOverViewController.userprotocol = self;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
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
