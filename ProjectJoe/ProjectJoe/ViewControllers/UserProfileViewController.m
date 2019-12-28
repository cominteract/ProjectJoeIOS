//
//  UserProfileViewController.m
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "UserProfileViewController.h"
#import "DataPasses.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface UserProfileViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray<Transaction *> *transactionList;
    JoeUser *currentJoeUser;
}
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *userProfileFullName;
@property (weak, nonatomic) IBOutlet UILabel *userProfileUsername;


@property (weak, nonatomic) IBOutlet UILabel *userProfileCurrentPoints;
@property (weak, nonatomic) IBOutlet UILabel *userProfileCurrentPasses;

@property (weak, nonatomic) IBOutlet UILabel *userProfileCurrentConnections;
@property (weak, nonatomic) IBOutlet UILabel *userProfileCurrentTransactions;
@property (weak, nonatomic) IBOutlet UILabel *userProfileBirthday;

@property (weak, nonatomic) IBOutlet UILabel *userProfileAddress;

@property (weak, nonatomic) IBOutlet UILabel *userProfileContactNumber;
@property (weak, nonatomic) IBOutlet UILabel *userProfileEmailAddress;
@property (weak, nonatomic) IBOutlet UITableView *userProfileTransactionsTableView;



@property (weak, nonatomic) IBOutlet UIButton *userProfileGiveButton;




@end

@implementation UserProfileViewController

- (IBAction)userProfileGiveButtonClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = transactionList[indexPath.row].transactionDetails;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:transactionList[indexPath.row].transactionImage]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return transactionList.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor = [self.fragmentInteractionProtocol colorFromHex:@"#7cacbc"];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadProfile];
    

    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self reloadProfile];
}

- (void)reloadProfile
{
    if(_selectedJoeUser)
    {
        currentJoeUser = _selectedJoeUser;
        [_userProfileGiveButton setHidden:NO];
    }
    else
    {
        [_userProfileGiveButton setHidden:YES];
        currentJoeUser = [[self.fragmentInteractionProtocol onDataPassesRetrieved] currentJoeUser];
    }
    [_userProfileImage sd_setImageWithURL:[NSURL URLWithString:currentJoeUser.image]];
    _userProfileAddress.text = currentJoeUser.googleMapLocation.locationAddress;
    _userProfileBirthday.text = currentJoeUser.birthday;
    _userProfileFullName.text = currentJoeUser.fullName;
    _userProfileUsername.text = currentJoeUser.userName;
    _userProfileEmailAddress.text = currentJoeUser.email;
    _userProfileContactNumber.text = currentJoeUser.phone;
    
    
    _userProfileCurrentPasses.text = [NSString stringWithFormat:@"%lu points",(unsigned long)currentJoeUser.currentPoints];
    _userProfileCurrentPoints.text = [NSString stringWithFormat:@"%lu passes",(unsigned long)currentJoeUser.transactionList.count];
    _userProfileCurrentTransactions.text = [NSString stringWithFormat:@"%lu transactions",(unsigned long)currentJoeUser.transactionList.count];
    _userProfileCurrentConnections.text = [NSString stringWithFormat:@"%lu connections",(unsigned long)currentJoeUser.friendList.count];
    
    transactionList = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getTransactionFromUser:currentJoeUser];
    _userProfileTransactionsTableView.delegate = self;
    _userProfileTransactionsTableView.dataSource = self;
    [_userProfileTransactionsTableView reloadData];
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
