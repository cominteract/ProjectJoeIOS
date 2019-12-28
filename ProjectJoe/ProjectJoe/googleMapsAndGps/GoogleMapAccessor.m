//
//  GoogleMapAccessor.m
//  AIBits
//
//  Created by Admin on 3/24/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import "GoogleMapAccessor.h"

@interface GoogleMapAccessor()<GMSMapViewDelegate>
{
    GMSMapView *mapView;
    GMSCameraPosition *camera;
    BOOL isZoomed;
    GoogleMapDataSample *googleMapDataSample;
    id<GoogleMapsProtocol> googleMapsProtocol;
}
@end
@implementation GoogleMapAccessor

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
     [googleMapsProtocol onMarkerClick:[self getGoogleMapLocationFromMarker:marker]];
    mapView.selectedMarker = marker;
    return YES;
}

- (void)mapView:(GMSMapView *)mapView didDragMarker:(GMSMarker *)marker
{
    
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    
}

- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    
}

- (void)mapView:(GMSMapView *)mapView didLongPressInfoWindowOfMarker:(GMSMarker *)marker
{
    [googleMapsProtocol onInfoMarkerLongClick:[self getGoogleMapLocationFromMarker:marker]];
}

- (void)mapView:(GMSMapView *)mapView didCloseInfoWindowOfMarker:(GMSMarker *)marker
{
    [googleMapsProtocol onInfoMarkerClose:[self getGoogleMapLocationFromMarker:marker]];
}

- (instancetype)initWith:(GoogleMapDataSample *)googleMapDataSample_ isZoomed:(BOOL)isZoomed_ mapView:(GMSMapView *)mapView_
{
    self = [super init];
    if(self)
    {
        googleMapDataSample = googleMapDataSample_;
        isZoomed = isZoomed_;
        mapView = mapView_;
    }
    return self;
}

- (GoogleMapLocation *)getGoogleMapLocationFromMarker:(GMSMarker *)marker
{
    for(GoogleMapLocation *googleMapLocation in googleMapDataSample.googleMapLocations)
    {
        if([googleMapLocation.locationName isEqualToString:marker.title])
        {
            return googleMapLocation;
        }
    }
    return nil;
}

- (void)initInterfaces:(id<GoogleMapsProtocol>)googleMapsProtocol_
{
    googleMapsProtocol = googleMapsProtocol_;
    mapView.delegate = self;
}

- (void)zoom:(BOOL)zoomIn
{
    isZoomed = zoomIn;
    int zoom = 6;
    if(zoomIn)
        zoom = 12;
    camera = [GMSCameraPosition cameraWithLatitude:googleMapDataSample.currentZoomed.coordinate.latitude longitude:googleMapDataSample.currentZoomed.coordinate.longitude zoom:zoom];
    [mapView setCamera:camera];
    
}

- (void)moveToLocation:(CLLocation *)location
{
    camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude zoom:6];
    [mapView setCamera:camera];
}

- (void)moveToGoogleMapLocation:(GoogleMapLocation *)location
{
    camera = [GMSCameraPosition cameraWithLatitude:location.currentLocation.coordinate.latitude longitude:location.currentLocation.coordinate.longitude zoom:6];
    [mapView setCamera:camera];
}
    
- (void)setGoogleMapLocations:(NSMutableArray *)googleMapLocations
{
    googleMapDataSample.googleMapLocations = googleMapLocations;
}
    
- (void)mapLocations
{
//    NSArray* arrMarkerData = @[
//                               @{@"title": @"Sydney", @"snippet": @"Australia", @"position": [[CLLocation alloc]initWithLatitude:17.4368 longitude:78.4439]},
//                               @{@"title": @"Other location", @"snippet": @"other snippet", @"position": [[CLLocation alloc]initWithLatitude:17.398932 longitude:78.472718]}
//                               ];
    
    NSLog(@"map loc called once");
    for(GoogleMapLocation *googleMapLocation in [googleMapDataSample googleMapLocations])
    {
        mapView.myLocationEnabled = YES;
        GMSMarker *	marker = [[GMSMarker alloc] init];
        marker.position = googleMapLocation.currentLocation.coordinate;
        marker.title = googleMapLocation.locationName;
        marker.snippet = googleMapLocation.locationName;
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.infoWindowAnchor = CGPointMake(.20, .29);
        marker.map = mapView;
    }
}

@end
