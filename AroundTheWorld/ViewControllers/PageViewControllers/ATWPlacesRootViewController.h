//
//  ATWPlacesRootViewController.h
//  AroundTheWorld
//
//  Created by Chitralekha Yellewar on 07/09/18.
//  Copyright © 2018 Chitralekha Yellewar. All rights reserved.
//

#import "ATWSearchViewController.h"

@interface ATWPlacesRootViewController : ATWSearchViewController

@property (strong, nonatomic) NSArray *placesPicArray;
@property (strong, nonatomic) NSArray *placesNamesArray;

- (void)setUpPlacesPageContentView ;

@end
