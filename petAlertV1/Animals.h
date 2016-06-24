//
//  Animals.h
//  petAlertV1
//
//  Created by Danielle Smith on 6/2/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "User.h"
#import "Animal.h"
#import "Comment.h"
#import "HomeViewController.h"


@interface Animals : NSObject

@property NSMutableArray *animalArray;
@property PFGeoPoint *usersLocation;
@property User *currentUser;

-(void) getUsersLocationWithCompletion:(void(^)(NSMutableArray *))complete;
-(void)queryForAnimalPostsNearUser:(PFGeoPoint *)usersLocation WithCompletion:(void (^)(NSMutableArray *))complete;
@end