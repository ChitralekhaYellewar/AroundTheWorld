//
//  ATWPlaceData.h
//  AroundTheWorld
//
//  Created by Chitralekha Yellewar on 07/09/18.
//  Copyright © 2018 Chitralekha Yellewar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GooglePlaces/GooglePlaces.h>

@interface ATWPlaceData : NSObject

@property (strong, nonatomic) NSMutableArray *ATWPlaceImages;
@property (strong, nonatomic) NSMutableArray *ATWPlaceNames;

- (void)removeAll ;
- (instancetype)init ;

@end
