//
//  ATWPlacesContentViewController.m
//  AroundTheWorld
//
//  Created by Chitralekha Yellewar on 07/09/18.
//  Copyright © 2018 Chitralekha Yellewar. All rights reserved.
//

#import "ATWPlacesContentViewController.h"
#import <GooglePlaces/GooglePlaces.h>

@interface ATWPlacesContentViewController () {
    UIActivityIndicatorView *loaderView;
    UISearchController *searchController;
    GMSAutocompleteResultsViewController *resultsViewController;
    NSArray *images;
}

@end

@implementation ATWPlacesContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLoaderView];
    self.placeImage.image = self.placesPictures[_pageIndex];
    self.placeLabel.text = self.placesNames[_pageIndex];
}

#pragma mark - set up loader view

- (void)setUpLoaderView {
    loaderView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loaderView setFrame:CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2, 25, 25)];
    [loaderView setHidesWhenStopped:YES];
    [self.view addSubview:loaderView];
}

@end

