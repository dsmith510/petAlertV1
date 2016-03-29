//
//  Post.m
//  petAlertV1
//
//  Created by Danielle Smith on 1/29/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import "Post.h"
#import <Parse/PFObject+Subclass.h>
#import "User.h"
#import "Comment.h"

@implementation Post

@dynamic createdBy;
@dynamic username;
@dynamic numberOfComments;
@dynamic image;
@dynamic location;
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
    return @"Post";
}

@end
