//
//  PassesDetailViewController.m
//  ProjectJoe
//
//  Created by andre insigne on 21/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "PassesDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DataPasses.h"
#import "GoogleMapsManager.h"
#import "GoogleMapsApiManager.h"
#import "GrabSuccessViewController.h"
#import "MerchantBranchesTableViewCell.h"
#import "PostsCollectionViewCell.h"
#import "GivePassViewController.h"
#import "InputPasscodeViewController.h"
@interface PassesDetailViewController ()<GoogleMapsProtocol, UITableViewDataSource,UITableViewDelegate, UICollectionViewDelegate,UICollectionViewDataSource>
{
    GoogleMapsManager *googleMapsManager;
    GoogleMapAccessor *googleMapAccessor;
    GoogleMapDataSample *googleDataSample;
    GMSMapView *mapView;
    GoogleMapsApiManager *googleMapsApiManager;

    NSMutableArray<Post *> *postsFromMerchant;
    NSMutableArray<Branch *> *branchesFromMerchant;
    NSString *selectedDisplay;
}
@property (weak, nonatomic) IBOutlet UIButton *passDetailsLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *passDetailsRightButton;

@property (weak, nonatomic) IBOutlet UIButton *passDetailsFinePrintButton;
@property (weak, nonatomic) IBOutlet UIButton *passDetailsPhotosButton;
@property (weak, nonatomic) IBOutlet UIButton *passDetailsLocationsButton;
    @property (weak, nonatomic) IBOutlet UILabel *passDetailsTitle;
    @property (weak, nonatomic) IBOutlet UILabel *passDetailsDescription;
    
    
    @property (weak, nonatomic) IBOutlet UILabel *passDetailsClaims;
    
    @property (weak, nonatomic) IBOutlet UILabel *passDetailsDuration;
    
    @property (weak, nonatomic) IBOutlet UITextView *passDetailsFinePrintText;
    
    @property (weak, nonatomic) IBOutlet UITableView *passDetailsLocationsTableView;
    
    @property (weak, nonatomic) IBOutlet UICollectionView *passDetailsPhotosCollectionView;
    
    @property (weak, nonatomic) IBOutlet UIView *mapContainerView;
    
@end

@implementation PassesDetailViewController

- (IBAction)passDetailsBackClicked:(id)sender {
       [_mapContainerView setHidden:YES];
}

- (IBAction)passDetailsGetDirectionsClicked:(id)sender {
    [googleMapsApiManager getDirection:[googleDataSample googleMapLocations][0] destination:[googleDataSample googleMapLocations][1] googleMapProtocol:self];
}

- (IBAction)passDetailsContactClicked:(id)sender {
}


- (IBAction)finePrintButtonClicked:(id)sender {
    [_passDetailsFinePrintButton setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#30B82C"]];
    [_passDetailsPhotosButton setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#005B7E"]];
    [_passDetailsLocationsButton setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#005B7E"]];
    selectedDisplay = @"fineprint";
    [_passDetailsLocationsTableView setHidden:YES];
    [_passDetailsFinePrintText setHidden:NO];
    [_passDetailsPhotosCollectionView setHidden:YES];
    
}

- (IBAction)photosButtonClicked:(id)sender {
    [_passDetailsFinePrintButton setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#005B7E"]];
    [_passDetailsPhotosButton setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#30B82C"]];
    [_passDetailsLocationsButton setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#005B7E"]];
    selectedDisplay = @"photos";
    [_passDetailsLocationsTableView setHidden:YES];
    [_passDetailsFinePrintText setHidden:YES];
    [_passDetailsPhotosCollectionView setHidden:NO];
    
}

- (IBAction)locationsButtonClicked:(id)sender {
    [_passDetailsFinePrintButton setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#005B7E"]];
    [_passDetailsPhotosButton setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#005B7E"]];
    [_passDetailsLocationsButton setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#30B82C"]];
    selectedDisplay = @"locations";
    [_passDetailsLocationsTableView setHidden:NO];
    [_passDetailsFinePrintText setHidden:YES];
    [_passDetailsPhotosCollectionView setHidden:YES];
}
- (IBAction)passDetailsLeftButtonClicked:(id)sender {
    if(_fromDiscover)
        [self showAlert:@"Note : Grabbing pass does not entitle user for reservation of the pass. Grabbing pass only allows claiming pass even without internet connection" title:@"Are you sure you want to grab this pass?"];
    else
    {
        InputPasscodeViewController *inputPasscodeViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"InputPasscodeViewController"];
        inputPasscodeViewController.selectedPass = _selectedPass;
        inputPasscodeViewController.transactionType = TransactionUsingPass;
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:inputPasscodeViewController];
    }
}
    
- (IBAction)passDetailsRightButtonClicked:(id)sender {
    if(_fromDiscover)
        [self showAlert:@"Sharing to facebook" title:@"Are you sure you want to share this pass?"];
    else
    {
        GivePassViewController *givePassViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"GivePassViewController"];
        givePassViewController.selectedPass = _selectedPass;
        
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:givePassViewController];
    }
    
    
}




- (void)showAlert:(NSString *)message title:(NSString *)title
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    if(_fromDiscover)
                                    {
                                        GrabSuccessViewController *grabSuccessViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"GrabSuccessViewController"];
                                        grabSuccessViewController.selectedPass = _selectedPass;
                                        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:grabSuccessViewController];
                                    }
                                    //Handle your yes please button action here
                                    
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"BACK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    
    //Add your buttons to alert controller
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [_mapContainerView setHidden:YES];
    if(_selectedPass)
    {
        
        _passDetailsTitle.text = _selectedPass.passMerchant.merchantName;
        _passDetailsClaims.text = _selectedPass.passClaims;
        _passDetailsDuration.text = _selectedPass.passDuration;
        _passDetailsDescription.text = _selectedPass.passDescription;
        //        _passDetailsFinePrintText.text = _selectedPass.
        UINib *nib1 = [UINib nibWithNibName:@"MerchantBranchesTableViewCell" bundle:nil];
        [_passDetailsLocationsTableView registerNib:nib1 forCellReuseIdentifier:@"MerchantBranchesTableViewCell"];
        UINib *nib2 = [UINib nibWithNibName:@"PostsCollectionViewCell" bundle:nil];
        [_passDetailsPhotosCollectionView registerNib:nib2 forCellWithReuseIdentifier:@"PostsCollectionViewCell" ];
        
        UICollectionViewFlowLayout *uiCollectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        uiCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat totalWidth = [UIScreen mainScreen].bounds.size.width;
        int width = (totalWidth - 32) / 3;
        uiCollectionViewFlowLayout.itemSize = CGSizeMake(width, width) ;
        [_passDetailsPhotosCollectionView setCollectionViewLayout:uiCollectionViewFlowLayout];
        
  
        
        postsFromMerchant = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getPostsFromMerchant:_selectedPass.passMerchant];
        
        if([[self.fragmentInteractionProtocol onDataPassesRetrieved] getBranchesFromMerchant:_selectedPass.passMerchant].count > 0)
        branchesFromMerchant = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getBranchesFromMerchant:_selectedPass.passMerchant];

        _passDetailsPhotosCollectionView.delegate = self;
        _passDetailsPhotosCollectionView.dataSource = self;
        _passDetailsLocationsTableView.delegate = self;
        _passDetailsLocationsTableView.dataSource = self;
        [_passDetailsLocationsTableView reloadData];
        [_passDetailsPhotosCollectionView reloadData];
//        [_discoverTableView registerNib:nib2 forCellReuseIdentifier:@"DiscoverNewsTableViewCell"];
    }
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

    if(_fromDiscover)
    {
        [self.fragmentInteractionProtocol tabBarFromDiscover:YES];
        [self.navigationController.navigationBar setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#50527A"]];
        [_passDetailsLeftButton setTitle:@"Grab" forState:UIControlStateNormal];
        [_passDetailsRightButton setTitle:@"Share" forState:UIControlStateNormal];
    }
    else
    {
   
        [self.fragmentInteractionProtocol tabBarFromDiscover:NO];
        [self.navigationController.navigationBar setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#005B7E"]];
        [_passDetailsLeftButton setTitle:@"Use" forState:UIControlStateNormal];
        [_passDetailsRightButton setTitle:@"Give" forState:UIControlStateNormal];

    }

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    
- (void)startGoogleMap
{
   
    
    
    
    [googleMapsApiManager startNearbyByName:self origin:[googleDataSample googleMapLocations][0] types:_selectedPass.passMerchant.merchantGeoType name:_selectedPass.passMerchant.merchantGeoName radius:@"4000"];
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

- (void)onNearby:(GoogleMapNearby *)googleMapNearby
{
    [googleDataSample addLocationsFromNearby:googleMapNearby isCleared:YES];
}
    
- (void)onMapLocationsLoaded:(NSMutableArray<GoogleMapLocation *> *)googleMapLocation
{
    if(googleMapsManager)
        [googleMapsManager mapLocations];
    //nearbyBranches = googleMapLocation;
    [_passDetailsLocationsTableView reloadData];
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
        [_mapContainerView sendSubviewToBack:mapView];
        
        googleMapAccessor = [[GoogleMapAccessor alloc]initWith:googleDataSample isZoomed:YES mapView:mapView];
        [googleMapAccessor initInterfaces:self];
        googleMapsManager = [[GoogleMapsManager alloc]initWith:googleMapAccessor googleMapsProtocol:self];
        googleMapsApiManager = [[GoogleMapsApiManager alloc]init];
        [googleMapsManager mapLocations];
        [_mapContainerView setHidden:NO];
    }
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MerchantBranchesTableViewCell *merchantBranchesTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"MerchantBranchesTableViewCell"];
    
    if(!merchantBranchesTableViewCell)
    {
        merchantBranchesTableViewCell = [[MerchantBranchesTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MerchantBranchesTableViewCell"];
    }
    if(indexPath.row % 2 == 1)
        [merchantBranchesTableViewCell.contentView setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#2473ab"]];
    else
        [merchantBranchesTableViewCell.contentView setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#3497db"]];
    if(branchesFromMerchant && branchesFromMerchant.count > 0)
    {
        merchantBranchesTableViewCell.merchantBranchName.text = branchesFromMerchant[indexPath.row].branchName;
        merchantBranchesTableViewCell.merchantBranchAddress.text = branchesFromMerchant[indexPath.row].branchAddress;
    }
    
    return merchantBranchesTableViewCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(branchesFromMerchant && branchesFromMerchant.count > 0)
    {
        return branchesFromMerchant.count;
    }
    return 5;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self onMapShownWith:branchesFromMerchant[indexPath.row].googleMapLocation];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
    
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(postsFromMerchant.count > 0)
        return postsFromMerchant.count;
    return 6;
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
