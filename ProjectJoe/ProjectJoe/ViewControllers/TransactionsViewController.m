//
//  TransactionsViewController.m
//  ProjectJoe
//
//  Created by Admin on 4/1/18.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "TransactionsViewController.h"
#import "DataPasses.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface TransactionsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray <Transaction *> *transactionList;
}
@property (weak, nonatomic) IBOutlet UITableView *transactionsTableView;

@end

@implementation TransactionsViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return transactionList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    [cell.contentView setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#7eafbd"]];
    cell.textLabel.text = transactionList[indexPath.row].transactionDetails;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:transactionList[indexPath.row].transactionImage]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor = [self.fragmentInteractionProtocol colorFromHex:@"#5ab2c8"];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    transactionList = [[self.fragmentInteractionProtocol onDataPassesRetrieved] currentJoeUser].transactionList;
    _transactionsTableView.delegate = self;
    _transactionsTableView.dataSource = self;
    [_transactionsTableView reloadData];
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
