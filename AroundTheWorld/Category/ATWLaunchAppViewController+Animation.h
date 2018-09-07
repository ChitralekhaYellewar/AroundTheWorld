//
//  ATWLaunchAppViewController+Animation.h
//  AroundTheWorld
//
//  Created by Chitralekha Yellewar on 07/09/18.
//  Copyright © 2018 Chitralekha Yellewar. All rights reserved.
//

#import "ATWLaunchAppViewController.h"

@interface ATWLaunchAppViewController (Animation)

- (void)setAlphaZero;
- (void)setAlphaOne;
- (void)startAnimation:(void(^)(void))completion;

@end
