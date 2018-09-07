//
//  ATWLaunchAppViewController+Animation.m
//  AroundTheWorld
//
//  Created by Chitralekha Yellewar on 07/09/18.
//  Copyright © 2018 Chitralekha Yellewar. All rights reserved.
//

#import "ATWLaunchAppViewController+Animation.h"

@implementation ATWLaunchAppViewController (Animation)

- (void)setAlphaZero {
    [self.imageOne setAlpha:ALPHA_ZERO];
    [self.imageTwo setAlpha:ALPHA_ZERO];
    [self.imageThree setAlpha:ALPHA_ZERO];
    [self.imageFour setAlpha:ALPHA_ZERO];
    [self.imageFive setAlpha:ALPHA_ZERO];
}

- (void)setAlphaOne {
    [self.imageOne setAlpha:ALPHA_ONE];
    [self.imageTwo setAlpha:ALPHA_ONE];
    [self.imageThree setAlpha:ALPHA_ONE];
    [self.imageFour setAlpha:ALPHA_ONE];
    [self.imageFive setAlpha:ALPHA_ONE];
}

- (void)startAnimation:(void(^)(void))completion {
    [UIView animateWithDuration:ANIMATE_DURATION delay:ANIMATE_DELAY options:UIViewAnimationOptionTransitionCurlUp animations:^{
        [self.topConstraintLabel setConstant:TOP_MULTIPLIER];
        [self setAlphaOne];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        completion();
    }];
}

@end
