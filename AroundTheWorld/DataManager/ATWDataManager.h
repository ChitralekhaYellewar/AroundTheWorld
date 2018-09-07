//
//  ATWDataManager.h
//  AroundTheWorld
//
//  Created by Chitralekha Yellewar on 07/09/18.
//  Copyright © 2018 Chitralekha Yellewar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATWPlaceData.h"

@interface ATWDataManager : NSObject

- (NSArray *)getPlaceNamesFromUserDefaults;
- (NSArray *)getImagesFromUserDefaults;

- (BOOL)saveDataToUserDefaults;
+ (instancetype)sharedInstance;

- (void)getPlacesNameAndPhotos:(GMSPlaceLikelihoodList *)likelyHoodlist withCompletion:(void (^)(void))completion;
- (void)getImagesForSelectedPlace:(GMSPlace *)place WithCompletion:(void(^)(void))completion;

@end
