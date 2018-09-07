//
//  ATWPlacesRootViewController.m
//  AroundTheWorld
//
//  Created by Chitralekha Yellewar on 07/09/18.
//  Copyright © 2018 Chitralekha Yellewar. All rights reserved.
//

#import "ATWPlacesRootViewController.h"
#import "ATWPlacesContentViewController.h"

@interface ATWPlacesRootViewController () <UIPageViewControllerDataSource>{
    int index;
}
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) GMSAutocompleteResultsViewController *resultsViewController;
@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation ATWPlacesRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    index = 0;
    [self setSearchBarForLocation];
    [self.navigationController.navigationBar setHidden:NO];
    [self setUpPlacesPageContentView];
}

#pragma mark - set up places page content view.

- (void) setUpPlacesPageContentView {
    NSLog(@"Data : %@%@", self.placesNamesArray,self.placesPicArray);
    [self.navigationItem setHidesBackButton:YES animated:YES];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.pageViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    // setup an interval
    [NSTimer scheduledTimerWithTimeInterval:5.0
                                         target:self
                                       selector:@selector(loadNextController)
                                       userInfo:nil
                                        repeats:YES];
    
    NSArray *viewControllers = [NSArray new];
    ATWPlacesContentViewController *startingViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    startingViewController = [self viewControllerAtIndex:0];
    viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)loadNextController {
    ATWPlacesContentViewController *nextViewController = [self viewControllerAtIndex:index++];
    if (nextViewController == nil) {
        index = 0;
        nextViewController = [self viewControllerAtIndex:index];
    }
    [self.pageViewController setViewControllers:@[nextViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];
}

#pragma mark - page view controller data source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((ATWPlacesContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((ATWPlacesContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.placesPicArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (ATWPlacesContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.placesPicArray count] == 0) || (index >= [self.placesPicArray count])) {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    UIStoryboard *mainStoryboard  =[ UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ATWPlacesContentViewController *pageContentViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.placesPictures = self.placesPicArray;
    pageContentViewController.placesNames = self.placesNamesArray;
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 4;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

@end

