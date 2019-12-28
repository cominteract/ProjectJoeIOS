//
//  GrabSuccessViewController.m
//  ProjectJoe
//
//  Created by andre insigne on 22/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "GrabSuccessViewController.h"
#import "DataPasses.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface GrabSuccessViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *grabSuccessPassImage;
@property (weak, nonatomic) IBOutlet UILabel *grabSuccessPassDetails;
@property (weak, nonatomic) IBOutlet UILabel *grabSuccessPassPrice;



@end

@implementation GrabSuccessViewController

- (IBAction)grabSuccessOkButtonClicked:(id)sender {
    Transaction *transaction = [[Transaction alloc]initWith:[[self.fragmentInteractionProtocol onDataPassesRetrieved] joeUser] transactionDate:[self.fragmentInteractionProtocol getCurrentDate] transactionPass:_selectedPass transactionType:TransactionReceivingPass];
    [[self.fragmentInteractionProtocol onDataPassesRetrieved] addTransaction:transaction];
    if([[[self.fragmentInteractionProtocol onDataPassesRetrieved] currentPassList] containsObject:_selectedPass])
    {
        [self.fragmentInteractionProtocol showToast:@"Pass already claimed"];
    }
    else
    {
      
        if([[[self.fragmentInteractionProtocol onDataPassesRetrieved] getAvailablePasses] containsObject:_selectedPass])
            [[[self.fragmentInteractionProtocol onDataPassesRetrieved] getAvailablePasses] removeObject:_selectedPass];
        _selectedPass.passClaimCount += 1;
        _selectedPass.passClaims = [NSString stringWithFormat:@"%d claims",_selectedPass.passClaimCount];
        [[[self.fragmentInteractionProtocol onDataPassesRetrieved] currentPassList] addObject:_selectedPass];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    if(_selectedPass)
    {
        [_grabSuccessPassImage sd_setImageWithURL:[NSURL URLWithString:_selectedPass.passMerchant.merchantImage]];
        _grabSuccessPassPrice.text = [NSString stringWithFormat:@" %f php",_selectedPass.passPrice];
        _grabSuccessPassDetails.text = _selectedPass.passDescription;
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
    [self.fragmentInteractionProtocol tabBarFromDiscover:YES]; 
    [self.navigationController.navigationBar setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#50527A"]];
    
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
