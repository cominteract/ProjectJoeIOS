//
//  UsePointsViewController.m
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "UsePointsViewController.h"
#import "DataPasses.h"
#import "InputPointscodeViewController.h"
@interface UsePointsViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *usePointsCurrentPointsCaption;
@property (weak, nonatomic) IBOutlet UITextField *usePointsUsePointsTextField;

@end

@implementation UsePointsViewController

- (IBAction)usePointsOkButtonClicked:(id)sender {
    InputPointscodeViewController *inputPointscodeViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"InputPointscodeViewController"];
    Points *points = [Points new];
    points.point = [_usePointsUsePointsTextField.text intValue];
    inputPointscodeViewController.selectedPoints = points;
    inputPointscodeViewController.transactionType = TransactionUsingPoints;
    [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:inputPointscodeViewController];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _usePointsCurrentPointsCaption.text = [NSString stringWithFormat:@"%d pts",[self.fragmentInteractionProtocol onDataPassesRetrieved].joeUser.currentPoints];
    _usePointsUsePointsTextField.delegate = self;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignTextField)];
    [self.view addGestureRecognizer:gesture];
    // Do any additional setup after loading the view.
}

- (void)resignTextField
{
    [_usePointsUsePointsTextField resignFirstResponder];
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
