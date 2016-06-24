//
//  Animals.m
//  petAlertV1
//
//  Created by Danielle Smith on 6/2/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import "Animals.h"
#import "HomeViewController.h"

@implementation Animals

//-(void)getUsersLocationWithCompletion:(void (^)(NSMutableArray *))complete
//{
//    self.currentUser = [User currentUser];
//    // Find user's current location
//    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint * _Nullable geoPoint, NSError * _Nullable error) {
//        if (!error) {
//            NSLog(@"User is currently at %f, %f", geoPoint.latitude, geoPoint.longitude);
//            self.usersLocation = geoPoint;
//            //            [self loadView];
//            [self queryForAnimalPostsNearUserWithCompletion:^(NSMutableArray *animalPostsArray){
//                self.animalsArray = animalPostsArray;
//            }];
//        }
//        else {
//            NSLog(@"%@", error.localizedDescription);
//        }
//        
//        complete(_animalsArray);
//    }];
//  
//
//}
-(void)queryForAnimalPostsNearUser:(PFGeoPoint *)usersLocation WithCompletion:(void (^)(NSMutableArray *))complete
{    
    if (!usersLocation)
    {
        NSLog(@"error");
        return;
    }
    
    self.animalArray = [NSMutableArray new];
//    PFGeoPoint *userGeopoint = self.usersLocation;
    PFQuery *query = [PFQuery queryWithClassName:@"Animal"];
    [query whereKey:@"location" nearGeoPoint:usersLocation withinMiles:100];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error)
    {
        if (error)
        {
            
            NSLog(@"%@", error.localizedDescription);
        }
        else
        {
            for (Animal *animal in objects)
            {
                [self.animalArray addObject:animal];
            }
            complete(_animalArray);
        }
    }];
    
    return;
}
@end
