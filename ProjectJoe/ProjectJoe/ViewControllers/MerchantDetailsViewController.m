//
//  MerchantDetailsViewController.m
//  ProjectJoe
//
//  Created by andre insigne on 23/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "MerchantDetailsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MerchantBranchesTableViewCell.h"
#import "DiscoverFeedTableViewCell.h"
#import "UserLeaderboardTableViewCell.h"
#import "PostsCollectionViewCell.h"
#import "GoogleMapsManager.h"
#import "GoogleMapsApiManager.h"
#import "DataPasses.h"
@interface MerchantDetailsViewController ()<UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate,UICollectionViewDataSource, GoogleMapsProtocol>
{
    GoogleMapsManager *googleMapsManager;
    GoogleMapAccessor *googleMapAccessor;
    GoogleMapDataSample *googleDataSample;
    GMSMapView *mapView;
    GoogleMapsApiManager *googleMapsApiManager;
    NSMutableArray<Post *> *postsFromMerchant;
    NSMutableArray<JoeUser *> *usersFromMerchant;
    NSMutableArray<Branch *> *branchesFromMerchant;
    NSMutableArray<Pass *> *passesFromMerchant;
    NSString *selectedType;
}
@property (weak, nonatomic) IBOutlet UIImageView *merchantDetailsImageView;
@property (weak, nonatomic) IBOutlet UILabel *merchantDetailsTitle;

@property (weak, nonatomic) IBOutlet UILabel *merchantDetailsCaption;

@property (weak, nonatomic) IBOutlet UILabel *merchantDetailsDescription;

@property (weak, nonatomic) IBOutlet UIButton *merchantDetailsButton;

@property (weak, nonatomic) IBOutlet UIButton *merchantDetailsPassesButton;

@property (weak, nonatomic) IBOutlet UIButton *merchantDetailsPhotosButton;

@property (weak, nonatomic) IBOutlet UIButton *merchantDetailsBranchesButton;

@property (weak, nonatomic) IBOutlet UILabel *merchantDetailsLongDescription;
@property (weak, nonatomic) IBOutlet UITableView *merchantDetailsTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *merchantDetailsTableViewTopConstraint;

    @property (weak, nonatomic) IBOutlet UICollectionView *merchantDetailsPostsCollectionView;

@property (weak, nonatomic) IBOutlet UIView *mapContainerView;

@property (weak, nonatomic) IBOutlet UILabel *leaderBoardTitle;




@end

@implementation MerchantDetailsViewController


- (IBAction)merchantDetailsBackClicked:(id)sender {
    [_mapContainerView setHidden:YES];
}
- (IBAction)merchantDetailsGetDirectionsClicked:(id)sender {
    [googleMapsApiManager getDirection:[googleDataSample googleMapLocations][0] destination:[googleDataSample googleMapLocations][1] googleMapProtocol:self];
}

- (IBAction)merchantDetailsContactClicked:(id)sender {
}



- (IBAction)merchantDetailsButtonClicked:(id)sender {
    selectedType = @"details";
    [_merchantDetailsLongDescription setHidden:NO];
    [_leaderBoardTitle setHidden:NO];
    [_merchantDetailsPostsCollectionView setHidden:YES];
    [_merchantDetailsTableView setHidden:NO];
    [_merchantDetailsTableView reloadData];
    _merchantDetailsTableViewTopConstraint.constant = 175;
}

- (IBAction)merchantDetailsPassesButtonClicked:(id)sender {
    _merchantDetailsTableViewTopConstraint.constant = 20;
    [_merchantDetailsLongDescription setHidden:YES];
    [_leaderBoardTitle setHidden:YES];
    selectedType = @"pass";
    [_merchantDetailsPostsCollectionView setHidden:YES];
    [_merchantDetailsTableView setHidden:NO];
    [_merchantDetailsTableView reloadData];
}

- (IBAction)merchantDetailsPhotosClicked:(id)sender {
    selectedType = @"posts";
    [_merchantDetailsLongDescription setHidden:YES];
    [_leaderBoardTitle setHidden:YES];
    [_merchantDetailsPostsCollectionView setHidden:NO];
    [_merchantDetailsTableView setHidden:YES];
    [_merchantDetailsPostsCollectionView reloadData];
}

- (IBAction)merchantDetailsBranchesClicked:(id)sender {
    _merchantDetailsTableViewTopConstraint.constant = 20;
    [_merchantDetailsLongDescription setHidden:YES];
    [_leaderBoardTitle setHidden:YES];
    selectedType = @"branch";
    [_merchantDetailsPostsCollectionView setHidden:YES];
    [_merchantDetailsTableView setHidden:NO];
    [_merchantDetailsTableView reloadData];
}

- (void)onMapShownWith:(GoogleMapLocation *)googleMapLocation
{
    if(mapView)
    {
        [mapView clear];
        [googleDataSample setCurrentLocation:nil];
        mapView.myLocationEnabled = YES;
        [[googleDataSample googleMapLocations]addObject:googleMapLocation];
        [googleMapsManager mapLocations];
        [_mapContainerView setHidden:NO];
        
    }
    else
    {
        googleDataSample = [[GoogleMapDataSample alloc]initWith:self];
        [googleDataSample setCurrentLocation:nil];
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[googleDataSample googleMapLocations][0].currentLocation.coordinate.latitude longitude:[googleDataSample googleMapLocations][0].currentLocation.coordinate.longitude zoom:6];
        mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, _mapContainerView.frame.size.width, _mapContainerView.frame.size.height) camera:camera];
        mapView.myLocationEnabled = YES;
        [[googleDataSample googleMapLocations]addObject:googleMapLocation];
        [_mapContainerView addSubview:mapView];
        
        googleMapAccessor = [[GoogleMapAccessor alloc]initWith:googleDataSample isZoomed:YES mapView:mapView];
        [googleMapAccessor initInterfaces:self];
        googleMapsManager = [[GoogleMapsManager alloc]initWith:googleMapAccessor googleMapsProtocol:self];
        googleMapsApiManager = [[GoogleMapsApiManager alloc]init];
        [_mapContainerView sendSubviewToBack:mapView];
        [googleMapsManager mapLocations];
        [_mapContainerView setHidden:NO];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if(_selectedMerchant)
    {
        [_mapContainerView setHidden:YES];
        _merchantDetailsTitle.text = _selectedMerchant.merchantName;
        _merchantDetailsCaption.text = _selectedMerchant.merchantCaption;
        [_merchantDetailsImageView sd_setImageWithURL:[NSURL URLWithString:_selectedMerchant.merchantImage]];
        _merchantDetailsDescription.text = _selectedMerchant.merchantDetails;
        _merchantDetailsLongDescription.text = _selectedMerchant.merchantDetails;
        UINib *nib1 = [UINib nibWithNibName:@"MerchantBranchesTableViewCell" bundle:nil];
        [_merchantDetailsTableView registerNib:nib1 forCellReuseIdentifier:@"MerchantBranchesTableViewCell"];
        UINib *nib2 = [UINib nibWithNibName:@"UserLeaderboardTableViewCell" bundle:nil];
        [_merchantDetailsTableView registerNib:nib2 forCellReuseIdentifier:@"UserLeaderboardTableViewCell"];
        UINib *nib3 = [UINib nibWithNibName:@"DiscoverFeedTableViewCell" bundle:nil];
        [_merchantDetailsTableView registerNib:nib3 forCellReuseIdentifier:@"DiscoverFeedTableViewCell"];
        UINib *nib4 = [UINib nibWithNibName:@"PostsCollectionViewCell" bundle:nil];
        [_merchantDetailsPostsCollectionView registerNib:nib4 forCellWithReuseIdentifier:@"PostsCollectionViewCell" ];
        
        
        postsFromMerchant = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getPostsFromMerchant:_selectedMerchant];
        branchesFromMerchant = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getBranchesFromMerchant:_selectedMerchant];
        usersFromMerchant = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getUsersListFromMerchant:_selectedMerchant];
        passesFromMerchant = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getPassesFromMerchant:_selectedMerchant];
        
        selectedType = @"details";
        [_merchantDetailsPostsCollectionView setHidden:YES];
        [_merchantDetailsTableView setHidden:NO];
        _merchantDetailsTableView.delegate = self;
        _merchantDetailsTableView.dataSource = self;
        [_merchantDetailsTableView reloadData];
        
        
        
        UICollectionViewFlowLayout *uiCollectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        uiCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat totalWidth = [UIScreen mainScreen].bounds.size.width;
        int width = (totalWidth - 22) / 3;
        uiCollectionViewFlowLayout.itemSize =
        CGSizeMake(width, width + 15) ;
        [_merchantDetailsPostsCollectionView setCollectionViewLayout:uiCollectionViewFlowLayout];
        
        _merchantDetailsPostsCollectionView.delegate = self;
        _merchantDetailsPostsCollectionView.dataSource = self;
        [_merchantDetailsPostsCollectionView reloadData];
        
    }
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.fragmentInteractionProtocol tabBarFromDiscover:YES];
    
    [self.navigationController.navigationBar setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#50527A"]];
    
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        if([selectedType isEqualToString:@"branch"])
            [self onMapShownWith: branchesFromMerchant[indexPath.row].googleMapLocation];
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([selectedType isEqualToString:@"branch"])
    {
        MerchantBranchesTableViewCell *merchantBranchesTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"MerchantBranchesTableViewCell"];
        
        if(!merchantBranchesTableViewCell)
        {
            merchantBranchesTableViewCell = [[MerchantBranchesTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MerchantBranchesTableViewCell"];
        }
        merchantBranchesTableViewCell.merchantBranchName.text = branchesFromMerchant[indexPath.row].branchName;
        merchantBranchesTableViewCell.merchantBranchAddress.text = branchesFromMerchant[indexPath.row].branchAddress;

        return merchantBranchesTableViewCell;
    }
    
    else if([selectedType isEqualToString:@"pass"])
    {
        DiscoverFeedTableViewCell *discoverFeedTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverFeedTableViewCell"];
        
        if(!discoverFeedTableViewCell)
        {
            discoverFeedTableViewCell = [[DiscoverFeedTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DiscoverFeedTableViewCell"];
        }
        [discoverFeedTableViewCell.discoverImage sd_setImageWithURL:[NSURL URLWithString:passesFromMerchant[indexPath.row].passMerchant.merchantImage]];
        discoverFeedTableViewCell.discoverTitleLabel.text = passesFromMerchant[indexPath.row].passMerchant.merchantName;
        discoverFeedTableViewCell.discoverClaimsLabel.text = passesFromMerchant[indexPath.row].passClaims;
        discoverFeedTableViewCell.discoverDescriptionLabel.text = passesFromMerchant[indexPath.row].passDescription;
        discoverFeedTableViewCell.discoverDeadlineLabel.text = passesFromMerchant[indexPath.row].passDuration;
        return discoverFeedTableViewCell;
    }
    else
    {
        UserLeaderboardTableViewCell *userLeaderboardTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"UserLeaderboardTableViewCell"];
        
        if(!userLeaderboardTableViewCell)
        {
            userLeaderboardTableViewCell = [[UserLeaderboardTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UserLeaderboardTableViewCell"];
        }
        userLeaderboardTableViewCell.userLeaderboardName.text = usersFromMerchant[indexPath.row].fullName;
        userLeaderboardTableViewCell.userLeaderboardPoints.text = [NSString stringWithFormat:@"%d",usersFromMerchant[indexPath.row].currentPoints];
        [userLeaderboardTableViewCell.userLeaderboardImage sd_setImageWithURL:[NSURL URLWithString:usersFromMerchant[indexPath.row].image]];
        
        return userLeaderboardTableViewCell;
    }
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([selectedType isEqualToString:@"pass"])
        return 200;
    else if([selectedType isEqualToString:@"branch"])
        return 60;
    else if([selectedType isEqualToString:@"details"])
        return 100;
    else
        return 200;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([selectedType isEqualToString:@"branch"])
        return branchesFromMerchant.count;
    else if([selectedType isEqualToString:@"pass"])
        return passesFromMerchant.count;
    else return usersFromMerchant.count;
    return 5;
}
    
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        PostsCollectionViewCell *postsCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostsCollectionViewCell" forIndexPath:indexPath];
        if(postsFromMerchant && postsFromMerchant.count > 0)
        {
            [postsCollectionViewCell.postImage sd_setImageWithURL:[NSURL URLWithString:postsFromMerchant[indexPath.row].postImage]];
            postsCollectionViewCell.postDetails.text = postsFromMerchant[indexPath.row].postDetails;
        }
        return postsCollectionViewCell;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
        return 1;
}
    
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        if(postsFromMerchant.count > 0)
        return postsFromMerchant.count;
        return 6;
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onPolylineRetrieved:(GMSPolyline *)polyLine
{
    //    GMSMutablePath *path = [GMSMutablePath path];
    //    [path addCoordinate:CLLocationCoordinate2DMake(-33.85, 151.20)];
    //    [path addCoordinate:CLLocationCoordinate2DMake(-33.70, 151.40)];
    //    [path addCoordinate:CLLocationCoordinate2DMake(-33.73, 151.41)];
    //    GMSPolyline *poly = [GMSPolyline polylineWithPath:path];
    polyLine.strokeColor = [UIColor blackColor];
    polyLine.strokeWidth = 7;
    polyLine.map = mapView;
    [mapView animateToZoom:10];
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
