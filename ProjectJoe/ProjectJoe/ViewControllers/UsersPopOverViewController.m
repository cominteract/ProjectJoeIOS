//
//  UsersPopOverViewController.m
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "UsersPopOverViewController.h"
#import "DataPasses.h"
@interface UsersPopOverViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray <JoeUser *> *joeUserFriends;
}

@property (weak, nonatomic) IBOutlet UITableView *usersPopOverTableView;

@end

@implementation UsersPopOverViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.delegate onChangedName:joeUserFriends[indexPath.row].fullName];
    [self.userprotocol onSelected:joeUserFriends[indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = joeUserFriends[indexPath.row].fullName;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return joeUserFriends.count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    joeUserFriends = [[self.fragmentInteractionProtocol onDataPassesRetrieved] currentJoeUser].friendList;
    _usersPopOverTableView.delegate = self;
    _usersPopOverTableView.dataSource = self;
    [_usersPopOverTableView reloadData];
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
