//
//  GoogleMapSampleViewController.m
//  AIBits
//
//  Created by Admin on 3/22/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import "GoogleMapSampleViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "GoogleMapsManager.h"
#import "GoogleMapsApiManager.h"
#import "GpsTracker.h"
@interface GoogleMapSampleViewController ()<GoogleMapsProtocol>
{
    GoogleMapsManager *googleMapsManager;
    GoogleMapAccessor *googleMapAccessor;
    GoogleMapDataSample *googleDataSample;
    GpsTracker *gpsTracker;
    GMSMapView *mapView;
    GoogleMapsApiManager *googleMapsApiManager;
}
@end

@implementation GoogleMapSampleViewController
BOOL isNearby = NO;
- (void)viewDidLoad {
    [super viewDidLoad];
    gpsTracker = [[GpsTracker alloc]initWith:self];
    [gpsTracker startLocation];
//    [self loadView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onNearby:(GoogleMapNearby *)googleMapNearby
{
    isNearby = YES;
    [googleDataSample addLocationsFromNearby:googleMapNearby isCleared:YES];
    
    [googleMapsManager mapLocations];
}
-(void)onMapLocationsLoaded:(NSMutableArray<GoogleMapLocation *> *)googleMapLocation
{
    if(!isNearby)
    {
        googleMapAccessor = [[GoogleMapAccessor alloc]initWith:googleDataSample isZoomed:YES mapView:mapView];
        [googleMapAccessor initInterfaces:self];
        googleMapsManager = [[GoogleMapsManager alloc]initWith:googleMapAccessor googleMapsProtocol:self];
        [googleMapsManager mapLocations];
        googleMapsApiManager = [[GoogleMapsApiManager alloc]init];
        if(googleMapLocation && googleMapLocation.count > 1)
        {
            [googleMapsApiManager getDirection:googleMapLocation[0] destination:googleMapLocation[1] googleMapProtocol:self];
        }
        //[googleMapsApiManager startNearbyByTypes:self origin:[googleDataSample googleMapLocations][0] types:@"cafe" radius:@"3000"];
    }
    else
    {
        
    }
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
    [self loadMap:location];
}
-(void)onInfoMarkerClick:(GoogleMapLocation *)googleMapLocation
{
    
}
-(void)onInfoMarkerClose:(GoogleMapLocation *)googleMapLocation
{
    
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

- (void)loadView {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView;
}

- (void)loadMap:(CLLocation *)ownLocation {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    googleDataSample = [[GoogleMapDataSample alloc]initWith:self];
    [googleDataSample setCurrentLocation:ownLocation];
    [googleDataSample setRandomLocationMaps:YES];
    //[googleDataSample setPolyLocationsSample];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:ownLocation.coordinate.latitude longitude:ownLocation.coordinate.longitude zoom:6];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    // Creates a marker in the center of the map.

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
