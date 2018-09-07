//
//  ATWSearchViewController.m
//  AroundTheWorld
//
//  Created by Chitralekha Yellewar on 07/09/18.
//  Copyright © 2018 Chitralekha Yellewar. All rights reserved.
//

#import "ATWSearchViewController.h"
#import "ATWLaunchAppViewController.h"
#import "ATWPlacesRootViewController.h"
#import <GooglePlaces/GooglePlaces.h>
#import "ATWDataManager.h"

@interface ATWSearchViewController()<GMSAutocompleteResultsViewControllerDelegate> {
    ATWLaunchAppViewController *launchView;
}
@property (strong, nonatomic) GMSAutocompleteResultsViewController *resultsViewController;
@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation ATWSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    launchView = [[ATWLaunchAppViewController alloc]init];
}

#pragma mark - search location bar.

- (void)setSearchBarForLocation {
    self.resultsViewController = [[GMSAutocompleteResultsViewController alloc] init];
    self.resultsViewController.delegate = self;
    
    self.searchController = [[UISearchController alloc]
                             initWithSearchResultsController:self.resultsViewController];
    self.searchController.searchResultsUpdater = self.resultsViewController;
    
    // Put the search bar in the navigation bar.
    [self.searchController.searchBar sizeToFit];
    self.navigationItem.titleView = self.searchController.searchBar;
    
    // When UISearchController presents the results view, present it in
    // this view controller, not one further up the chain.
    self.definesPresentationContext = YES;
    
    // Prevent the navigation bar from being hidden when searching.
    self.searchController.hidesNavigationBarDuringPresentation = NO;
}

// Handle the user's selection.
- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
 didAutocompleteWithPlace:(GMSPlace *)place {
    self.searchController.active = NO;
    
    [[ATWDataManager sharedInstance] getImagesForSelectedPlace:place WithCompletion:^{
        [self reloadPageView];
    }];
    
}

- (void)reloadPageView {
    ATWPlacesRootViewController *rootView = [self.storyboard instantiateViewControllerWithIdentifier:@"PlacesRootViewController"];
    rootView.placesPicArray = [[ATWDataManager sharedInstance] getImagesFromUserDefaults];
    rootView.placesNamesArray = [[ATWDataManager sharedInstance] getPlaceNamesFromUserDefaults];
    
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:rootView];
    [self presentViewController:navigationController
                       animated:NO
                     completion:nil];
}

- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictionsForResultsController:
(GMSAutocompleteResultsViewController *)resultsController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictionsForResultsController:
(GMSAutocompleteResultsViewController *)resultsController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end



