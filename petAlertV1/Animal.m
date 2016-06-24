//
//  Animal.m
//  petAlertV1
//
//  Created by Danielle Smith on 6/2/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import "Animal.h"
#import <Parse/PFObject+Subclass.h>
#import "User.h"
#import "Comment.h"

@implementation Animal

@dynamic createdBy;
@dynamic username;
@dynamic numberOfComments;
@dynamic image;
@dynamic location;
@dynamic locationAddress;
@dynamic commentsRelation;
@dynamic filter;
@dynamic caption;
@dynamic phoneNumber;
@dynamic petStatus;
@dynamic createdAt;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Animal";
}

-(void)generateNewPost
{
    
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if (succeeded) {
            NSLog(@"yes");
        }
    }];
    

}

@end
