//
//  CompletePhotoViewController.m
//  ProjectJoe
//
//  Created by andre insigne on 21/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "CompletePhotoViewController.h"
#import "PhotoCheckInViewController.h"
#import "DataPasses.h"
@interface CompletePhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *completePhotoImageView;
@property (weak, nonatomic) IBOutlet UITextView *completePhotoTextView;
@property (weak, nonatomic) IBOutlet UILabel *completePhotoLabel;

@end

@implementation CompletePhotoViewController

- (IBAction)completePhotoOkButtonClicked:(id)sender {
    Transaction *transaction = [[Transaction alloc]initWith:[[self.fragmentInteractionProtocol onDataPassesRetrieved] joeUser] transactionDate:[self.fragmentInteractionProtocol getCurrentDate] transactionPoints:30 transactionType:TransactionEarningPoints];
    [[self.fragmentInteractionProtocol onDataPassesRetrieved] addTransaction:transaction];
    [[self.fragmentInteractionProtocol onDataPassesRetrieved] joeUser].earnedPoints += 30;
    [[self.fragmentInteractionProtocol onDataPassesRetrieved] joeUser].currentPoints += 30;
    
 
    [self.navigationController popToRootViewControllerAnimated:YES];
       [self.fragmentInteractionProtocol showToast:@"Congratulations You have successfully done a photo-check at Jollibee Greenhills You earned 30 bonus points"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(_image)
    {
        [_completePhotoImageView setImage:_image];
        _completePhotoLabel.text = _branchName;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.fragmentInteractionProtocol tabBarFromDiscover:NO];
    [self.navigationController.navigationBar setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#005B7E"]];
    
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
