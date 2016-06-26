//
//  Animals.m
//  petAlertV1
//
//  Created by Danielle Smith on 6/2/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import "Animals.h"
#import "Comment.h"
#import "HomeViewController.h"

@implementation Animals

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
            complete(self.animalArray);
        }
    }];
    
    return;
}

-(void)getCommentsforAnimal:(Animal *)animalPost WithCompletion:(void (^)(NSMutableArray *))complete
{
    
    PFRelation *relation = [animalPost relationForKey:@"commentsRelation"];
    PFQuery *query = [relation query];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Comment Error: %@", error.localizedDescription);
        }
        
        else
        {
            for (Comment *comment in objects)
            {
                [self.commentArray addObject:comment];
            }
            complete(self.commentArray);
        }
    }];
    
}

-(void)deleteComment: (Comment *)comment fromAnimalPost: (Animal *)animalPost atIndexPath:(NSIndexPath *)indexPath inArray:(NSMutableArray *)commentsArray WithCompletion:(void (^)())complete
{
    PFRelation *relation = [animalPost relationForKey:@"commentsRelation"];
    [relation removeObject:comment];
    [animalPost saveInBackground];
    
    [commentsArray removeObjectAtIndex:indexPath.row];
    complete();
}

-(void)addComment:(Comment *)newComment fromTextField: (UITextField *)commentTextField byUser :(User *)currentUser toAnimalPost:(Animal *)animalPost inArray:(NSMutableArray *)commentsArray withCompletion:(void (^)())complete
{
    newComment.user = self.currentUser;
    newComment.text = commentTextField.text;
    [newComment saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error)
    {
        [commentsArray addObject:newComment];
        if (succeeded)
        {
            NSLog(@"comment saved");
        }
        
        animalPost.numberOfComments = @(animalPost.numberOfComments.integerValue +1);
        PFRelation *relation = [animalPost relationForKey:@"commentsRelation"];
        [relation addObject:newComment];
        [animalPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error)
        {
            if (succeeded)
            {
                NSLog(@"animal post saved");
            }
        }];
        
        complete();
    }];
    
}
@end
