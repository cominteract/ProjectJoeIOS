	//
//  GoogleMapsApiManager.m
//  AIBits
//
//  Created by Admin on 3/24/18.
//  Copyright © 2018 andre insigne. All rights reserved.
//

#import "GoogleMapsApiManager.h"
#import <AFNetworking/AFNetworking.h>
#import "GoogleMapDirectionResults.h"
#import <GoogleMaps/GoogleMaps.h>
@interface GoogleMapsApiManager()
{
}
@end
@implementation GoogleMapsApiManager
NSString *apikey = @"AIzaSyDb8rICzZ5cnGPe5xsz-Abdm7nv_xeTYZI";
- (void)startNearbyByName:(id<GoogleMapsProtocol>) googleMapsProtocol_ origin:(GoogleMapLocation *)origin types:(NSString *)types name:(NSString *)name radius:(NSString *)radius
{
    NSString *ori = [NSString stringWithFormat:@"%f,%f",origin.locationLatitude,origin.locationLongitude];
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"radius":radius
                             ,@"types":types
                             ,@"name":name
                             ,@"key":apikey
                             ,@"location":ori};
    [manager GET:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *response = (NSDictionary *)responseObject;
        [self populateGoogleNearby:response googleMapsProtocol_:googleMapsProtocol_];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)startNearbyByKeyword:(id<GoogleMapsProtocol>) googleMapsProtocol_ origin:(GoogleMapLocation *)origin types:(NSString *)types keyword:(NSString *)keyword radius:(NSString *)radius
{
    NSString *ori = [NSString stringWithFormat:@"%f,%f",origin.locationLatitude,origin.locationLongitude];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"radius":radius
                             ,@"types":types
                             ,@"keyword":keyword
                             ,@"key":apikey
                             ,@"location":ori};
    [manager GET:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *response = (NSDictionary *)responseObject;
        [self populateGoogleNearby:response googleMapsProtocol_:googleMapsProtocol_];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)startNearbyByTypes:(id<GoogleMapsProtocol>) googleMapsProtocol_ origin:(GoogleMapLocation *)origin types:(NSString *)types radius:(NSString *)radius
{

    NSString *ori = [NSString stringWithFormat:@"%f,%f",origin.locationLatitude,origin.locationLongitude];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"radius":radius
                             ,@"types":types
                             ,@"key":apikey
                             ,@"location":ori};
    [manager GET:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *response = (NSDictionary *)responseObject;
        [self populateGoogleNearby:response googleMapsProtocol_:googleMapsProtocol_];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (double)getLatFrom:(NSDictionary *)response
{
    return [[[[response objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"] doubleValue];
}
- (double)getLongFrom:(NSDictionary *)response
{
    return [[[[response objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"] doubleValue];
}


- (void)populateGoogleNearby:(NSDictionary *) response googleMapsProtocol_:(id<GoogleMapsProtocol>) googleMapsProtocol_
{
    NSArray *resultList = (NSArray *)[response objectForKey:@"results"];
    GoogleMapNearby *googleNearby = [[GoogleMapNearby alloc]init];
    googleNearby.resultList = [NSMutableArray new];
    for(int n = 0 ; n< resultList.count;n++)
    {
        
        Results *results = [[Results alloc]init];
        results.vicinity = [resultList[n] objectForKey:@"vicinity"];
        results.name = [resultList[n] objectForKey:@"name"];
        NSLog(@" vicinity %@ ", results.vicinity);
        results.location = [[CLLocation alloc]initWithLatitude: [self getLatFrom:resultList[n]] longitude:[self getLongFrom:resultList[n]]];
        
        results.types = [resultList[n] objectForKey:@"types"];
        results.icon = [resultList[n] objectForKey:@"icon"];
        if([[[[resultList[n] objectForKey:@"opening_hours"] objectForKey:@"open_now"] stringValue] isEqualToString:@"1"])
            results.open_now =  YES;
        else
            results.open_now =  NO;
        [googleNearby.resultList addObject:results];
    }
    [googleMapsProtocol_ onNearby:googleNearby];
}



- (void)getDirection:(GoogleMapLocation *)origin destination:(GoogleMapLocation *)destination googleMapProtocol:(id<GoogleMapsProtocol>)googleMapProtocol
{
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *ori = [NSString stringWithFormat:@"%f,%f",origin.locationLatitude,origin.locationLongitude];
    NSString *dest = [NSString stringWithFormat:@"%f,%f",destination.locationLatitude,destination.locationLongitude];
    NSDictionary *params = @{@"origin":ori
                             ,@"destination":dest
                             };
    [manager GET:@"https://maps.googleapis.com/maps/api/directions/json" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *response = (NSDictionary *)responseObject;
        [self populateDirection:response googleMapProtocol:googleMapProtocol];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)populateDirection:(NSDictionary *)responseObject googleMapProtocol:(id<GoogleMapsProtocol>)googleMapProtocol
{
    GoogleMapDirectionResults *googleMapDirectionResults = [[GoogleMapDirectionResults alloc]init];
    
    NSMutableArray<Route *> *routesArray = [NSMutableArray new];
    NSArray *routelist = ((NSArray *)[responseObject objectForKey:@"routes"]);
    GMSMutablePath *path = [GMSMutablePath path];
    Steps *lastSteps;
    for(int x = 0;x<routelist.count;x++)
    {
        Route *route = [[Route alloc]init];
        
        NSArray *legsList = ((NSArray *)[routelist[x] objectForKey:@"legs"]);
        NSMutableArray<Legs *> *legsArray = [NSMutableArray new];
        for(int n = 0;n<legsList.count;n++)
        {
            Legs *legs = [Legs new];
            legs.distanceinMeters = [[[legsList[n] objectForKey:@"distance"] objectForKey:@"value"] intValue];
            legs.durationinSeconds = [[[legsList[n] objectForKey:@"duration"] objectForKey:@"value"] intValue];
            NSMutableArray<Steps *> *stepsArray = [NSMutableArray new];
            NSArray *stepsList = ((NSArray *)[legsList[n] objectForKey:@"steps"]);
            
            for(int o = 0;o<stepsList.count;o++)
            {
                Steps *steps = [Steps new];
                steps.distanceinMeters = [[[stepsList[o] objectForKey:@"distance"] objectForKey:@"value"] intValue];
                steps.durationinSeconds = [[[stepsList[o] objectForKey:@"duration"] objectForKey:@"value"] intValue];
                steps.start_location = [self getLocationFrom:[stepsList[o] objectForKey:@"start_location"]];
                steps.end_location = [self getLocationFrom:[stepsList[o] objectForKey:@"end_location"]];
                steps.travel_mode = [stepsList[o] objectForKey:@"travel_mode"];
                [stepsArray addObject:steps];
 
                [path addCoordinate:steps.start_location.coordinate];
           
            }
            lastSteps = [stepsArray lastObject];
            legs.steps = stepsArray;
            [legsArray addObject:legs];
        }
        route.legs = legsArray;
        [routesArray addObject:route];
    }
    
    [path addCoordinate:lastSteps.end_location.coordinate];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    [googleMapProtocol onPolylineRetrieved:polyline];
    googleMapDirectionResults.routes = routesArray;
}

- (CLLocation *)getLocationFrom:(NSDictionary *)response
{
   
    return [[CLLocation alloc]initWithLatitude: [[response objectForKey:@"lat"] doubleValue] longitude: [[response objectForKey:@"lng"] doubleValue]];
}

@end
