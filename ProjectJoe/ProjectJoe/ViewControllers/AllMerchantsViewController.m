//
//  AllMerchantsViewController.m
//  ProjectJoe
//
//  Created by andre insigne on 23/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "AllMerchantsViewController.h"
#import "MerchantsListTableViewCell.h"
#import "MerchantDetailsViewController.h"
#import "DataPasses.h"
@interface AllMerchantsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *allMerchantsTableView;

@end

@implementation AllMerchantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"MerchantsListTableViewCell" bundle:nil];
    [_allMerchantsTableView registerNib:nib forCellReuseIdentifier:@"MerchantsListTableViewCell"];
    _allMerchantsTableView.dataSource = self;
    _allMerchantsTableView.delegate = self;
    [_allMerchantsTableView reloadData];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.fragmentInteractionProtocol tabBarFromDiscover:YES];

    [self.navigationController.navigationBar setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#50527A"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MerchantDetailsViewController *merchantDetailsViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"MerchantDetailsViewController"];
    Merchant *merchant = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getMerchantList][indexPath.row];
    merchantDetailsViewController.selectedMerchant = merchant;
    [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:merchantDetailsViewController];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Merchant *merchant = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getMerchantList][indexPath.row];
    MerchantsListTableViewCell *merchantsListTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"MerchantsListTableViewCell"];
    
    if(!merchantsListTableViewCell)
    {
        merchantsListTableViewCell = [[MerchantsListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MerchantsListTableViewCell"];
    }
    merchantsListTableViewCell.backgroundColor = [UIColor clearColor];
    merchantsListTableViewCell.merchantImage.image = [UIImage imageNamed:merchant.merchantImageResource];
    merchantsListTableViewCell.merchantTitle.text = merchant.merchantName;
    merchantsListTableViewCell.merchantDetails.text = merchant.merchantDetails;
    
//    photosCheckInTableViewCell.photoCheckinNameLabel.text = @"Shorty";
//    photosCheckInTableViewCell.photoCheckinAddressLabel.text = @"Shorty";
//    photosCheckInTableViewCell.photoCheckinPostImage.image = [UIImage imageNamed:@"bg1"];
    return merchantsListTableViewCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.fragmentInteractionProtocol onDataPassesRetrieved] getMerchantList].count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
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
