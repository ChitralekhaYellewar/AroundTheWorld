//
//  ATWPlacesContentViewController.h
//  AroundTheWorld
//
//  Created by Chitralekha Yellewar on 07/09/18.
//  Copyright © 2018 Chitralekha Yellewar. All rights reserved.
//

#import "ATWBaseViewController.h"

@interface ATWPlacesContentViewController : ATWBaseViewController

@property NSUInteger pageIndex;

@property (strong, nonatomic) NSArray *placesPictures;
@property (strong, nonatomic) NSArray *placesNames;

@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeImage;

@end
