//
//  PhotoCheckInViewController.m
//  ProjectJoe
//
//  Created by Wylog Mac Mini on 19/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "PhotoCheckInViewController.h"
#import "PhotosCheckInTableViewCell.h"
#import "FilterPhotoViewController.h"
#import "TagPhotoViewController.h"
#import "DataPasses.h"
#import "MainNavigationViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface PhotoCheckInViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray <Post *> *postList;
}
@property (weak, nonatomic) IBOutlet UITableView *photoCheckTableView;
@property (weak, nonatomic) IBOutlet UIImageView *photoCheckImageView;

@end

@implementation PhotoCheckInViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhotosCheckInTableViewCell *photosCheckInTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"PhotosCheckInTableViewCell"];
    if(!photosCheckInTableViewCell)
    {
        photosCheckInTableViewCell = [[PhotosCheckInTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PhotosCheckInTableViewCell"];
    }
    photosCheckInTableViewCell.photoCheckinNameLabel.text = postList[indexPath.row].postUser.fullName;
    
    photosCheckInTableViewCell.photoCheckinAddressLabel.text = postList[indexPath.row].postBranch.branchAddress;
    [photosCheckInTableViewCell.photoCheckinPostImage sd_setImageWithURL:[NSURL URLWithString:postList[indexPath.row].postUser.image]];
    return photosCheckInTableViewCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return postList.count;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"PhotosCheckInTableViewCell" bundle:nil];
   
    [_photoCheckTableView registerNib:nib forCellReuseIdentifier:@"PhotosCheckInTableViewCell"];
    if([self.fragmentInteractionProtocol onDataPassesRetrieved].isRetrieved)
    {
        postList = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getAvailablePostList];
        _photoCheckTableView.dataSource = self;
        _photoCheckTableView.delegate = self;
        [_photoCheckTableView reloadData];
    }
    UITapGestureRecognizer *clickRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(navigateToTagPhoto)];
    clickRecognizer.numberOfTapsRequired = 1;
    [_photoCheckImageView addGestureRecognizer:clickRecognizer];
   
    //[_photoCheckImageView targetForAction:@selector(navigateToFilterPhoto) withSender:self];
    // Do any additional setup after loading the view.
}

- (void)navigateToTagPhoto
{
    
    if([self.fragmentInteractionProtocol onDataPassesRetrieved].isRetrieved)
    {
        TagPhotoViewController *tagPhotoViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"TagPhotoViewController"];
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:tagPhotoViewController];
    }
    else
    {
        [self.fragmentInteractionProtocol showToast:@" Can't do this yet"];
    }
    
}

- (void)navigateToFilterPhoto
{
 
        if([self.fragmentInteractionProtocol onDataPassesRetrieved].isRetrieved)
        {
            FilterPhotoViewController *filterPhotoViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"FilterPhotoViewController"];
            [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:filterPhotoViewController];
        }
        else
        {
            [self.fragmentInteractionProtocol showToast:@" Can't do this yet"];
        }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.fragmentInteractionProtocol tabBarFromDiscover:NO];
    [self.navigationController.navigationBar setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#005B7E"]];
    if([self.fragmentInteractionProtocol onDataPassesRetrieved].isRetrieved)
    {
        postList = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getAvailablePostList];
        _photoCheckTableView.dataSource = self;
        _photoCheckTableView.delegate = self;
        [_photoCheckTableView reloadData];
    }

    
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
