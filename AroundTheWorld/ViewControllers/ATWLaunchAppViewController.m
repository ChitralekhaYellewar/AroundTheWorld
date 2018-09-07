//
//  ATWLaunchAppViewController.m
//  AroundTheWorld
//
//  Created by Chitralekha Yellewar on 07/09/18.
//  Copyright © 2018 Chitralekha Yellewar. All rights reserved.
//

#import "ATWLaunchAppViewController.h"
#import "ATWPlacesRootViewController.h"
#import "ATWDataManager.h"
#import "ATWLaunchAppViewController+animation.h"
@import GooglePlaces;

@interface ATWLaunchAppViewController () <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    GMSPlacesClient *placesClient;
    GMSPlace *userCurrentLocation;
}

@end

@implementation ATWLaunchAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAlphaZero];
    placesClient = [GMSPlacesClient sharedClient];
    locationManager = [[CLLocationManager alloc] init];
    [self startAnimation:^{
        [self accessLocationPermission];
        [self getUserLocation];
    }];
}

#pragma mark - ask for location permission.

- (void)accessLocationPermission {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestLocation];
}

#pragma mark - CLLocation Manager delegates

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error while getting user permission %@", error.localizedDescription);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self getUserLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"locations %@", locations);
}

- (void)getUserLocation {
    [placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error){
        if (error != nil) {
            NSLog(@"Pick Place error %@", [error localizedDescription]);
            return;
        }
        if (placeLikelihoodList != nil) {
            [[ATWDataManager sharedInstance] getPlacesNameAndPhotos:placeLikelihoodList withCompletion:^{
                [self performSegueWithIdentifier:@"START_SEGUE" sender:self];
            }];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ATWPlacesRootViewController *rootView = [segue destinationViewController];
    rootView.placesPicArray = [[ATWDataManager sharedInstance] getImagesFromUserDefaults];
    rootView.placesNamesArray = [[ATWDataManager sharedInstance] getPlaceNamesFromUserDefaults];
}

@end

