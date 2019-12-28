//
//  FirstViewController.m
//  ProjectJoe
//
//  Created by Wylog Mac Mini on 19/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "PassesFeedViewController.h"
#import "PassesTableViewCell.h"
#import "DataPasses.h"

#import "PassesDetailViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>
@interface PassesFeedViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray<Pass *> *currentPasses;
}

@property (weak, nonatomic) IBOutlet UITableView *passesTableView;

@end

@implementation PassesFeedViewController


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    PassesTableViewCell *passesTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"PassesTableViewCell"];
    if(!passesTableViewCell)
    {
        passesTableViewCell= [[PassesTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PassesTableViewCell"];
    }
    
    [passesTableViewCell.passImage sd_setImageWithURL:[NSURL URLWithString:currentPasses[indexPath.row].passMerchant.merchantImage]];
    passesTableViewCell.passTitle.text = currentPasses[indexPath.row].passMerchant.merchantName;
    passesTableViewCell.passClaims.text = currentPasses[indexPath.row].passClaims;
    passesTableViewCell.passDuration.text = currentPasses[indexPath.row].passDuration;
    passesTableViewCell.passDescription.text = currentPasses[indexPath.row].passDescription;
    return passesTableViewCell;
  
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.fragmentInteractionProtocol onDataPassesRetrieved].isRetrieved)
    {
        PassesDetailViewController *passesDetailViewController  = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"PassesDetailViewController"];
        passesDetailViewController.selectedPass = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getCurrentPassList][indexPath.row];
        passesDetailViewController.fromDiscover = NO;
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:passesDetailViewController];
    }
    else
    {
        [self.fragmentInteractionProtocol showToast:@"Can't do this yet"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return currentPasses.count;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"PassesTableViewCell" bundle:nil];
    [_passesTableView registerNib:nib forCellReuseIdentifier:@"PassesTableViewCell"];
    currentPasses = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getCurrentPassList];
    _passesTableView.delegate = self;
    _passesTableView.dataSource = self;
    [_passesTableView  reloadData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.fragmentInteractionProtocol tabBarFromDiscover:NO];
    [self.navigationController.navigationBar setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#005B7E"]];
    currentPasses = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getCurrentPassList];
    [_passesTableView  reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
