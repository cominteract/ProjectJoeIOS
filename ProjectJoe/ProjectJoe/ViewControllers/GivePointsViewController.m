//
//  GivePointsViewController.m
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "GivePointsViewController.h"
#import "UserInteractionInterface.h"
#import "UsersPopOverViewController.h"
#import "InputPointscodeViewController.h"

@interface GivePointsViewController ()<UserInteractionProtocol,UIPopoverPresentationControllerDelegate,UITextFieldDelegate, UITextViewDelegate>{
    JoeUser * selectedJoeUser;
}
@property (weak, nonatomic) IBOutlet UILabel *givePointsCurrent;

@property (weak, nonatomic) IBOutlet UIButton *givePointsUserButton;

@property (weak, nonatomic) IBOutlet UITextField *givePointsGivePointsTextField;

@property (weak, nonatomic) IBOutlet UITextView *givePointsMessage;

@end

@implementation GivePointsViewController

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound)
    {
        return YES;
    }
    [textView resignFirstResponder];
    return NO;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)onSelected:(JoeUser *)selectedJoe
{
    selectedJoeUser = selectedJoe;
    [_givePointsUserButton setTitle:selectedJoe.fullName forState:UIControlStateNormal];
}

- (IBAction)givePointsOkButtonClicked:(id)sender {
    
    InputPointscodeViewController *inputPointscodeViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"InputPointscodeViewController"];
    Points *points = [Points new];
    points.point = [_givePointsGivePointsTextField.text intValue];
    inputPointscodeViewController.selectedPoints = points;
    inputPointscodeViewController.selectedJoeUser = selectedJoeUser;
    inputPointscodeViewController.transactionType = TransactionGivingPoints;
    inputPointscodeViewController.message = _givePointsMessage.text;
    [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:inputPointscodeViewController];
}


- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection
{
    return UIModalPresentationNone;
}

- (void)resignTextField
{
    [_givePointsGivePointsTextField resignFirstResponder];
    [_givePointsMessage resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _givePointsGivePointsTextField.delegate = self;
 
    _givePointsCurrent.text = [NSString stringWithFormat:@" %d pts",[[self.fragmentInteractionProtocol onDataPassesRetrieved] joeUser].currentPoints];
       UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignTextField)];
    [self.view addGestureRecognizer:gesture];
    // Do any additional setup after loading the view.
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
