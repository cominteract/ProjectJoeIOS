//
//  SecondViewController.m
//  ProjectJoe
//
//  Created by Wylog Mac Mini on 19/03/2018.
//  Copyright © 2018 AInsigne. All rights reserved.
//

#import "DiscoverFeedViewController.h"
#import "DiscoverFeedTableViewCell.h"
#import "DiscoverNewsTableViewCell.h"
#import "DiscoverLockedTableViewCell.h"
#import "DiscoverChallengeTableViewCell.h"
#import "PassesDetailViewController.h"
#import "GrabSuccessViewController.h"
#import "AllMerchantsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GoogleMapsManager.h"
#import "GoogleMapsApiManager.h"
#import "DataPasses.h"
#import "GpsTracker.h"
@interface DiscoverFeedViewController ()<UITableViewDataSource,UITableViewDelegate,GoogleMapsProtocol>
    {
        GoogleMapsManager *googleMapsManager;
        GoogleMapAccessor *googleMapAccessor;
        GoogleMapDataSample *googleDataSample;
        GpsTracker *gpsTracker;
        GMSMapView *mapView;
        GoogleMapsApiManager *googleMapsApiManager;
        NSMutableArray<GoogleMapLocation *> *nearestGoogleMapLocations;
        NSMutableArray<GoogleMapLocation *> *availableGoogleMapLocations;
    }
@property (weak, nonatomic) IBOutlet UITableView *discoverTableView;

@property (weak, nonatomic) IBOutlet UIStackView *firstRowStackView;

@property (weak, nonatomic) IBOutlet UIStackView *secondRowStackView;

@property (weak, nonatomic) IBOutlet UIStackView *thirdRowStackView;

@property (weak, nonatomic) IBOutlet UITableView *merchantListTableView;

@property (weak, nonatomic) IBOutlet UIStackView *filterStackView;

@property (weak, nonatomic) IBOutlet UIView *mapContainerView;
    
@property (weak, nonatomic) IBOutlet UIButton *nearMeButton;
    

@end

@implementation DiscoverFeedViewController

BOOL shownFilter = NO;
BOOL isAlreadyLoaded = NO;
BOOL isNearbyC = NO;
BOOL isTrending = NO;
BOOL isIndustry = NO;
CLLocation *startLocation;
CLLocation *endLocation;
int currentIndex = 0;
NSString *currentCategory;
- (IBAction)nearMeButtonClicked:(id)sender {
    
        [_thirdRowStackView setHidden:YES];
        [_firstRowStackView setHidden:YES];
        [_secondRowStackView setHidden:YES];
        [_merchantListTableView setHidden:YES];
        [_discoverTableView setHidden:YES];
        [_filterStackView setHidden:YES];
        [_mapContainerView setHidden:NO];
  
}


- (IBAction)discoverMerchantCategoryClicked:(id)sender {
    isNearbyC = NO;
    isIndustry = YES;
    isTrending = NO;
    [self filterWithCategoryTag:((UITapGestureRecognizer *)sender).view.tag];
}

-(IBAction)discoverAllMerchantsClicked:(id)sender {
    AllMerchantsViewController *allMerchantsViewController = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"AllMerchantsViewController"];
    [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:allMerchantsViewController];
    
}
- (IBAction)discoverIndustryClicked:(id)sender {
    [_thirdRowStackView setHidden:NO];
    [_firstRowStackView setHidden:NO];
    [_secondRowStackView setHidden:NO];
    [_merchantListTableView setHidden:YES];
    [_discoverTableView setHidden:YES];
    [_filterStackView setHidden:YES];
    [_mapContainerView setHidden:YES];
    [_nearMeButton setHidden:YES];
    
    shownFilter = NO;
}
- (IBAction)discoverNearMeClicked:(id)sender {
    isNearbyC = YES;
    isTrending = NO;
    isIndustry = NO;
    shownFilter = YES;
    [self visibilityUIDiscover];
    [_nearMeButton setHidden:NO];
    [_discoverTableView reloadData];
}
- (IBAction)discoverTrendingClicked:(id)sender {
    isNearbyC = NO;
    isTrending = YES;
    isIndustry = NO;
    shownFilter = YES;
    [self visibilityUIDiscover];
    [_discoverTableView reloadData];
    
}
- (IBAction)discoverAllPassesClicked:(id)sender {
    isNearbyC = NO;
    isIndustry = NO;
    isTrending = NO;
    shownFilter = YES;
    [self visibilityUIDiscover];
    [_discoverTableView reloadData];
    
}
    
- (NSArray *)getIndustries
{
    return @[@"Arts" ,@"Beauty",@"Food",@"Fashion",@"Health",@"Lifestyle",@"Music",@"Travel",@"Cars"];

}

- (void)getStartPoint
{
    startLocation = [[CLLocation alloc]initWithLatitude:14.583771 longitude:121.059675];
}

- (void)getNearestLocationList:(NSArray<GoogleMapLocation *> *) availableGoogleMapLocationList
{
    for(GoogleMapLocation *googleMapLocation in availableGoogleMapLocationList)
    {
        endLocation = [[CLLocation alloc]initWithLatitude:googleMapLocation.locationLatitude longitude:googleMapLocation.locationLongitude];
        //NSLog(@"the distance %f", [startLocation distanceFromLocation:endLocation] );
        if([startLocation distanceFromLocation:endLocation] < 500)
        {
            [nearestGoogleMapLocations addObject:googleMapLocation];
            [self checkNearbyPasses:googleMapLocation];
        }
    }
}
    
- (void)checkNearbyPasses:(GoogleMapLocation *)googleMapLocation
{
    for(Pass *pass in [[self.fragmentInteractionProtocol onDataPassesRetrieved] getAvailablePasses])
    {
        if([googleMapLocation.locationName.lowercaseString containsString:pass.passMerchant.merchantGeoName.lowercaseString] && ![[self.fragmentInteractionProtocol onDataPassesRetrieved].nearbyAvailablePasses containsObject:pass])
        {
            [[self.fragmentInteractionProtocol onDataPassesRetrieved].nearbyAvailablePasses addObject:pass];
        }
    }
}
- (void)visibilityUIDiscover
{
    [_thirdRowStackView setHidden:YES];
    [_firstRowStackView setHidden:YES];
    [_secondRowStackView setHidden:YES];
    [_merchantListTableView setHidden:YES];
    if(shownFilter)
        [_discoverTableView setHidden:NO];
    else
        [_discoverTableView setHidden:YES];
    [_filterStackView setHidden:shownFilter];
    [_mapContainerView setHidden:YES];
    [_nearMeButton setHidden:YES];
}

- (void)filterWithCategoryTag:(NSInteger )tag
{
    NSLog(@" tag %lu ", tag);
    isNearbyC = NO;
    isTrending = NO;
    isIndustry = YES;
    shownFilter = YES;
    if(tag < [self getIndustries].count)
        currentCategory = [self getIndustries][tag];
    [self visibilityUIDiscover];
    [_discoverTableView reloadData];
}

- (IBAction)discoverFilterButtonClicked:(id)sender {
    
    if([self.fragmentInteractionProtocol onDataPassesRetrieved].isRetrieved)
    {
         shownFilter = !shownFilter;
        [self visibilityUIDiscover];
       
    }
    else
    {
        [self.fragmentInteractionProtocol showToast:@" Can't do this yet"];
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Pass *pass;
    if(isNearbyC)
        pass = [self.fragmentInteractionProtocol onDataPassesRetrieved].nearbyAvailablePasses[indexPath.row];
    else if(isTrending)
        pass = [self.fragmentInteractionProtocol onDataPassesRetrieved].trendingPasses[indexPath.row];
    else if(isIndustry)
        pass = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getAvailablePassesFrom:currentCategory][indexPath.row];
    else
        pass = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getAvailablePasses][indexPath.row];
    //@"DEAL",@"COUPON",@"FREE",@"CHALLENGE",@"NEWS",@"AD"
    if([pass.passType isEqualToString:@"CHALLENGE"])
    {
            
        DiscoverChallengeTableViewCell *discoverChallengeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverChallengeTableViewCell"];
        discoverChallengeTableViewCell.discoverChallengeTitle.text = pass.passDescription;
        if(!discoverChallengeTableViewCell)
        {
            discoverChallengeTableViewCell = [[DiscoverChallengeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DiscoverChallengeTableViewCell"];
        }
        return discoverChallengeTableViewCell;
        
    }
    else if( [pass.passType isEqualToString:@"NEWS"] || [pass.passType isEqualToString:@"AD"] )
    {
        DiscoverNewsTableViewCell *discoverNewsTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverNewsTableViewCell"];
        
        
        if(!discoverNewsTableViewCell)
        {
            discoverNewsTableViewCell = [[DiscoverNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DiscoverNewsTableViewCell"];
        }
        discoverNewsTableViewCell.discoverNewsTitleLabel.text = pass.passDescription;
        [discoverNewsTableViewCell.discoverNewsImage sd_setImageWithURL:[NSURL URLWithString:pass.passImage]];
        return discoverNewsTableViewCell;
    }
    else{
        if(pass.isLocked)
        {
            DiscoverLockedTableViewCell *discoverLockedTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverLockedTableViewCell"];
           
            if(!discoverLockedTableViewCell)
            {
                discoverLockedTableViewCell = [[DiscoverLockedTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DiscoverLockedTableViewCell"];
            }
            [discoverLockedTableViewCell.discoverLockedImage sd_setImageWithURL:[NSURL URLWithString:pass.passImage]];
            discoverLockedTableViewCell.discoverClaimsLabel.text = pass.passClaims;
            discoverLockedTableViewCell.discoverDeadlineLabel.text = pass.passDuration;
            discoverLockedTableViewCell.discoverLockedTitleLabel.text = pass.passMerchant.merchantName;
            discoverLockedTableViewCell.discoverDescriptionLabel.text = pass.passDescription;
            return discoverLockedTableViewCell;
        }
        else
        {
            DiscoverFeedTableViewCell *discoverFeedTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverFeedTableViewCell"];
            

            
            if(!discoverFeedTableViewCell)
            {
                discoverFeedTableViewCell = [[DiscoverFeedTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DiscoverFeedTableViewCell"];
            }
            [discoverFeedTableViewCell.discoverImage sd_setImageWithURL:[NSURL URLWithString:pass.passImage]];
            discoverFeedTableViewCell.discoverClaimsLabel.text = pass.passClaims;
            discoverFeedTableViewCell.discoverDeadlineLabel.text = pass.passDuration;
            discoverFeedTableViewCell.discoverTitleLabel.text = pass.passMerchant.merchantName;
            discoverFeedTableViewCell.discoverDescriptionLabel.text = pass.passDescription;
            return discoverFeedTableViewCell;
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isNearbyC)
        return [self.fragmentInteractionProtocol onDataPassesRetrieved].nearbyAvailablePasses.count;
    else if(isTrending)
        return [self.fragmentInteractionProtocol onDataPassesRetrieved].trendingPasses.count;
    else if(isIndustry)
        return [[self.fragmentInteractionProtocol onDataPassesRetrieved] getAvailablePassesFrom:currentCategory].count;
    else
        return [[self.fragmentInteractionProtocol onDataPassesRetrieved] getAvailablePasses].count;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.fragmentInteractionProtocol onDataPassesRetrieved].isRetrieved)
    {
        PassesDetailViewController *passesDetailViewController  = [[self.fragmentInteractionProtocol storyboard] instantiateViewControllerWithIdentifier:@"PassesDetailViewController"];
        passesDetailViewController.selectedPass = [[self.fragmentInteractionProtocol onDataPassesRetrieved] getAvailablePasses][indexPath.row];
        passesDetailViewController.fromDiscover = YES;
        [self.fragmentInteractionProtocol onSwitchFrom:self.navigationController to:passesDetailViewController];
    }
    else
    {
        [self.fragmentInteractionProtocol showToast:@"Can't do this yet"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.fragmentInteractionProtocol onDataPassesRetrieved];
    UINib *nib1 = [UINib nibWithNibName:@"DiscoverChallengeTableViewCell" bundle:nil];
    [_discoverTableView registerNib:nib1 forCellReuseIdentifier:@"DiscoverChallengeTableViewCell"];
    UINib *nib2 = [UINib nibWithNibName:@"DiscoverNewsTableViewCell" bundle:nil];
    [_discoverTableView registerNib:nib2 forCellReuseIdentifier:@"DiscoverNewsTableViewCell"];
    UINib *nib3 = [UINib nibWithNibName:@"DiscoverLockedTableViewCell" bundle:nil];
    [_discoverTableView registerNib:nib3 forCellReuseIdentifier:@"DiscoverLockedTableViewCell"];
    UINib *nib4 = [UINib nibWithNibName:@"DiscoverFeedTableViewCell" bundle:nil];
    [_discoverTableView registerNib:nib4 forCellReuseIdentifier:@"DiscoverFeedTableViewCell"];
    NSLog(@" %lu datapasses available pass size ", (unsigned long)[[self.fragmentInteractionProtocol onDataPassesRetrieved] getAvailablePasses].count);
    //gpsTracker = [[GpsTracker alloc]initWith:self];
    //[gpsTracker startLocation];
    nearestGoogleMapLocations = [NSMutableArray new];
    availableGoogleMapLocations = [NSMutableArray new];
    [_nearMeButton setHidden:YES];
    _discoverTableView.delegate = self;
    _discoverTableView.dataSource = self;
    [_discoverTableView reloadData];
    [self startGoogleMap];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.fragmentInteractionProtocol tabBarFromDiscover:YES];
    [self.navigationController.navigationBar setBackgroundColor:[self.fragmentInteractionProtocol colorFromHex:@"#005B7E"]];
    _discoverTableView.delegate = self;
    _discoverTableView.dataSource = self;
    [_discoverTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    
- (void)onNearby:(GoogleMapNearby *)googleMapNearby
{
    [googleDataSample addLocationsFromNearby:googleMapNearby isCleared:NO];
}
-(void)onMapLocationsLoaded:(NSMutableArray<GoogleMapLocation *> *)googleMapLocation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self handleLocationList:googleMapLocation];
    });
   
    
}
- (void)onCameraMove:(GoogleMapLocation *)googleMapLocation
{
        
}
-(void)onChangeType:(NSString *)type
{
        
}
-(void)onMarkerClick:(GoogleMapLocation *)googleMapLocation
{
        
}
-(void)onLocationLoaded:(CLLocation *)location
{
//        [self loadMap:location];
}
-(void)onInfoMarkerClick:(GoogleMapLocation *)googleMapLocation
{
        
}
-(void)onInfoMarkerClose:(GoogleMapLocation *)googleMapLocation
{
        
}

- (void)startGoogleMap
{
    googleDataSample = [[GoogleMapDataSample alloc]initWith:self];
    [googleDataSample setCurrentLocation:nil];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[googleDataSample googleMapLocations][0].currentLocation.coordinate.latitude longitude:[googleDataSample googleMapLocations][0].currentLocation.coordinate.longitude zoom:6];
    mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, 375, 500) camera:camera];
    mapView.myLocationEnabled = YES;
    [_mapContainerView addSubview:mapView];
    
    googleMapAccessor = [[GoogleMapAccessor alloc]initWith:googleDataSample isZoomed:YES mapView:mapView];
    [googleMapAccessor initInterfaces:self];
    googleMapsManager = [[GoogleMapsManager alloc]initWith:googleMapAccessor googleMapsProtocol:self];
    
    googleMapsApiManager = [[GoogleMapsApiManager alloc]init];
    
    if([self.fragmentInteractionProtocol onDataPassesRetrieved].getAvailablePasses.count > 0 &&
       [self.fragmentInteractionProtocol onDataPassesRetrieved].branchList.count < 1)
    [googleMapsApiManager startNearbyByName:self origin:[googleDataSample googleMapLocations][0] types:[self.fragmentInteractionProtocol onDataPassesRetrieved].getAvailablePasses[currentIndex].passMerchant.merchantGeoType name:[self.fragmentInteractionProtocol onDataPassesRetrieved].getAvailablePasses[currentIndex].passMerchant.merchantGeoName radius:@"4000"];
    else
    {
        nearestGoogleMapLocations = [self.fragmentInteractionProtocol onDataPassesRetrieved].nearestGoogleMapLocationList;
        availableGoogleMapLocations = [self.fragmentInteractionProtocol onDataPassesRetrieved].availableGoogleMapLocationList;
        [googleMapAccessor setGoogleMapLocations:nearestGoogleMapLocations];
        [googleMapsManager mapLocations];
        

    }
 
}
    
- (void)handleLocationList:(NSMutableArray<GoogleMapLocation *> *)googleMapLocationsList
{
    if(googleMapsManager!=nil && currentIndex == [self.fragmentInteractionProtocol onDataPassesRetrieved].getAvailablePasses.count - 1)
    {
        [[self.fragmentInteractionProtocol onDataPassesRetrieved] setBranchListFrom:googleMapLocationsList];
        availableGoogleMapLocations = googleMapLocationsList;
        [self getStartPoint];
        [self getNearestLocationList:googleMapLocationsList];
        [googleMapAccessor setGoogleMapLocations:nearestGoogleMapLocations];
        [googleMapsManager mapLocations];
        [self.fragmentInteractionProtocol onDataPassesRetrieved].nearestGoogleMapLocationList = nearestGoogleMapLocations;
        [self.fragmentInteractionProtocol onDataPassesRetrieved].availableGoogleMapLocationList = availableGoogleMapLocations;
   
        
        isAlreadyLoaded = YES;
    }
    else
    {
        [googleMapsApiManager startNearbyByName:self origin:[googleDataSample googleMapLocations][0] types:[self.fragmentInteractionProtocol onDataPassesRetrieved].getAvailablePasses[currentIndex].passMerchant.merchantGeoType name:[self.fragmentInteractionProtocol onDataPassesRetrieved].getAvailablePasses[currentIndex].passMerchant.merchantGeoName radius:@"4000"];
        currentIndex++;
    }
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
        [mapView animateToZoom:15];
    }
    

    
- (void)loadMap:(CLLocation *)ownLocation {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.


    //[googleDataSample setPolyLocationsSample];
    

    
    // Creates a marker in the center of the map.
    
}

@end
