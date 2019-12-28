//
//  ConnectionsViewController.m
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "ConnectionsViewController.h"
#import "DataPasses.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UserProfileViewController.h"
@interface ConnectionsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray<JoeUser *> *joeUserList;
}
@property (weak, nonatomic) IBOutlet UITableView *connectionsTableView;

@end

@implementation ConnectionsViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserProfileViewController *userProfileViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
    userProfileViewController.selectedJoeUser = joeUserList[indexPath.row];
    [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:userProfileViewController];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return joeUserList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }

    cell.textLabel.text = joeUserList[indexPath.row].fullName;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:joeUserList[indexPath.row].image]];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor = [self.fragmentInteractionProtocol colorFromHex:@"#29768a"];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    joeUserList = [[self.fragmentInteractionProtocol onDataPassesRetrieved] currentJoeUser].friendList;
    _connectionsTableView.delegate = self;
    _connectionsTableView.dataSource = self;
    [_connectionsTableView reloadData];
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
