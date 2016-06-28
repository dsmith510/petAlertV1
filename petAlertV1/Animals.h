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
#import "PostTableViewCell.h"


@interface Animals : NSObject

@property NSMutableArray *animalArray;
@property NSMutableArray *commentArray;
@property PFGeoPoint *usersLocation;
@property User *currentUser;

-(void) getCommentsforAnimal: (Animal *)animalPost WithCompletion:(void(^)(NSMutableArray *))complete;
-(void)queryForAnimalPostsNearUser:(PFGeoPoint *)usersLocation WithCompletion:(void (^)(NSMutableArray *))complete;

-(void)deleteComment: (Comment *)comment fromAnimalPost: (Animal *)animalPost atIndexPath:(NSIndexPath *)indexPath inArray:(NSMutableArray *)commentsArray WithCompletion:(void (^)())complete;

-(void)addComment:(Comment *)newComment fromTextField: (UITextField *)commentTextField byUser :(User *)currentUser toAnimalPost:(Animal *)animalPost inArray:(NSMutableArray *)commentsArray withCompletion:(void (^)())complete;

-(void)deleteAnimalPostfromArray: (NSMutableArray *)animalPostArray atIndex:(PostTableViewCell *)selectedIndexPath withCompletion:(void (^) ())complete;
@end
