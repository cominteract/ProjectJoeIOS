//
//  GivePassSuccessViewController.m
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "GivePassSuccessViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ReceivedPassViewController.h"
@interface GivePassSuccessViewController ()

@property (weak, nonatomic) IBOutlet UILabel *givePassSuccessPassNameCaption;

@property (weak, nonatomic) IBOutlet UIImageView *givePassSuccessPassImage;




@end

@implementation GivePassSuccessViewController


- (IBAction)givePassSuccessMyTransactionsClicked:(id)sender {
}

- (IBAction)givePassSuccessOkButtonClicked:(id)sender {
    ReceivedPassViewController *receivedPassViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"ReceivedPassViewController"];
    receivedPassViewController.selectedPass = _selectedPass;
    receivedPassViewController.selectedJoeUser = _selectedJoeUser;
    receivedPassViewController.message = _message;
    [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:receivedPassViewController];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if(_selectedPass && _selectedJoeUser)
    {
        _givePassSuccessPassNameCaption.text = [NSString stringWithFormat:@"You have given %@ to %@", _selectedPass.passDescription, _selectedJoeUser.fullName];
        [_givePassSuccessPassImage sd_setImageWithURL:[NSURL URLWithString:_selectedPass.passMerchant.merchantImage]];
        Transaction *transaction = [[Transaction alloc]initWith:_selectedJoeUser transactionDate:[self.fragmentInteractionProtocol getCurrentDate] transactionPass:_selectedPass transactionType:TransactionGivingPass];
        [[self.fragmentInteractionProtocol onDataPassesRetrieved] addTransaction:transaction];
        [[self.fragmentInteractionProtocol onDataPassesRetrieved].currentPassList removeObject:_selectedPass];
        
    
        
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
