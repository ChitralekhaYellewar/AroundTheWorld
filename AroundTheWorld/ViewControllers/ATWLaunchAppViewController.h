//
//  ATWLaunchAppViewController.h
//  AroundTheWorld
//
//  Created by Chitralekha Yellewar on 07/09/18.
//  Copyright © 2018 Chitralekha Yellewar. All rights reserved.
//

#import "ATWBaseViewController.h"
#import <GooglePlaces/GooglePlaces.h>
#import "ATWSearchViewController.h"
#import "Constants.h"

@interface ATWLaunchAppViewController : ATWBaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageThree;
@property (weak, nonatomic) IBOutlet UIImageView *imageFour;
@property (weak, nonatomic) IBOutlet UIImageView *imageFive;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraintLabel;

@end
