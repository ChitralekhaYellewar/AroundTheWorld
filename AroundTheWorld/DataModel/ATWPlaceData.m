//
//  ATWPlaceData.m
//  AroundTheWorld
//
//  Created by Chitralekha Yellewar on 07/09/18.
//  Copyright © 2018 Chitralekha Yellewar. All rights reserved.
//

#import "ATWPlaceData.h"

@implementation ATWPlaceData

- (void)removeAll {
    [self.ATWPlaceNames removeAllObjects];
    [self.ATWPlaceImages removeAllObjects];
}

- (instancetype)init {
    _ATWPlaceNames = [[NSMutableArray alloc] init];
    _ATWPlaceImages = [[NSMutableArray alloc] init];
    return self;
}

@end
