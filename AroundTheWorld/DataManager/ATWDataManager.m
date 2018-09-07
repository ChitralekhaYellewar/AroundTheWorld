//
//  ATWDataManager.m
//  AroundTheWorld
//
//  Created by Chitralekha Yellewar on 07/09/18.
//  Copyright © 2018 Chitralekha Yellewar. All rights reserved.
//

#import "ATWDataManager.h"

@interface ATWDataManager(){
    ATWPlaceData *data;
    NSMutableArray *PlacesResultsArray;
    NSMutableArray *PhotosResultsArray;
}
@end

@implementation ATWDataManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static ATWDataManager *dataManager = nil ;
    dispatch_once(&onceToken, ^{
        dataManager = [[ATWDataManager alloc] init];
    });
    return dataManager;
}

- (void)initializeArrays {
    data = [[ATWPlaceData alloc] init];
    PlacesResultsArray = [[NSMutableArray alloc] init];
    PhotosResultsArray = [[NSMutableArray alloc] init];
}

- (void)getPlacesNameAndPhotos:(GMSPlaceLikelihoodList *)likelyHoodlist withCompletion:(void (^)(void))completion {
    [self initializeArrays];
    NSLog(@"likelyHoodlist.likelihoods.count %lu",(unsigned long)likelyHoodlist.likelihoods.count);
    
    for (int like = 0; like < likelyHoodlist.likelihoods.count ; like ++) {
        GMSPlace *place = [likelyHoodlist.likelihoods[like] place];
        [[GMSPlacesClient sharedClient]
         lookUpPhotosForPlaceID:place.placeID
         callback:^(GMSPlacePhotoMetadataList *_Nullable photos,
                    NSError *_Nullable error) {
             if (error) {
                 // TODO: handle the error.
                 NSLog(@"Error while loading photo for places: %@", [error description]);
             } else {
                 if (photos.results.count > 0) {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         for(int i = 0 ; i< photos.results.count; i++) {
                             //[PlacesResultsArray addObject:place.name];
                             [data.ATWPlaceNames addObject:place.name];
                         }
                     });
                     [PhotosResultsArray addObjectsFromArray:photos.results];
                 }
             }
             
             if (like == likelyHoodlist.likelihoods.count - 1 ) {
                 [self loadImageForMetadata:PhotosResultsArray withCompletion:^{
                     NSLog(@"after saving in userdefaults ");
                     completion();
                 }];
             }
         }];
    }
}

- (void)getImagesForSelectedPlace:(GMSPlace *)place WithCompletion:(void(^)(void))completion {
    [self resetUserDefaults];
    [data removeAll];
    
    [[GMSPlacesClient sharedClient]lookUpPhotosForPlaceID:place.placeID callback:^(GMSPlacePhotoMetadataList * _Nullable photos, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error while getting image for selected place %@",error.localizedDescription);
        } else {
            if (photos.results.count > 0) {
                for (int image = 0; image < photos.results.count; image++) {
                    [data.ATWPlaceNames addObject:place.name];
                    NSLog(@"after saving in userdefaults ");
                    if (image == photos.results.count -1) {
                        [self loadImageForMetadata:photos.results withCompletion:^{
                            completion();
                        }];
                    }
                }
            }
        }
    }];
}

- (void)loadImageForMetadata:(NSArray *)photoMetadata withCompletion:(void (^)(void))completion {
    for (int i = 0; i < photoMetadata.count; i ++) {
        [[GMSPlacesClient sharedClient] loadPlacePhoto:photoMetadata[i] callback:^(UIImage * _Nullable photo, NSError * _Nullable error) {
            if (photo != nil) {
                [data.ATWPlaceImages addObject:photo];
                if (i == photoMetadata.count - 1) {
                    NSLog(@"final array images %@", data.ATWPlaceImages);
                    if ([self saveDataToUserDefaults]) {
                        NSLog(@"saved final array in userdefaults ");
                        completion();
                    }
                }
            }
            NSLog(@"self placesImages get here %@", data.ATWPlaceImages);
        }];
        
    }
}

- (void)resetUserDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"PlacesImageArray"];
    [userDefaults removeObjectForKey:@"PlacesNameArray"];
    [userDefaults synchronize];
}

- (NSArray *)getImagesFromUserDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *imageData = [userDefaults objectForKey:@"PlacesImageArray"];
    NSArray *images = [NSKeyedUnarchiver unarchiveObjectWithData:imageData];
    return images;
}

- (NSArray *)getPlaceNamesFromUserDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *placesData = [userDefaults objectForKey:@"PlacesNameArray"];
    NSArray *placeNames = [NSKeyedUnarchiver unarchiveObjectWithData:placesData];
    return placeNames;
}

- (BOOL)saveDataToUserDefaults {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    // save images to user defaults.
    NSArray *toBeArchiveArray = [data.ATWPlaceImages mutableCopy];
    NSData *dataPlacesImages = [NSKeyedArchiver archivedDataWithRootObject:toBeArchiveArray];
    [userDefaults setObject:dataPlacesImages forKey:@"PlacesImageArray"];
    
    NSArray *placestoBeArchiveArray = [data.ATWPlaceNames mutableCopy];
    NSData *dataPlacesNames = [NSKeyedArchiver archivedDataWithRootObject:placestoBeArchiveArray];
    [userDefaults setObject:dataPlacesNames forKey:@"PlacesNameArray"];
    
    return [userDefaults synchronize];
}

@end

