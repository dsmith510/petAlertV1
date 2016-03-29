//
//  Comment.m
//  petAlertV1
//
//  Created by Danielle Smith on 1/29/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import "Comment.h"
#import <Parse/PFObject+Subclass.h>
#import "User.h"
#import "Post.h"

@implementation Comment

@dynamic user;
@dynamic text;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Comment";
}


@end
