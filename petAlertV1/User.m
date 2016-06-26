//
//  User.m
//  petAlertV1
//
//  Created by Danielle Smith on 1/29/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import "User.h"
#import <parse/PFObject+Subclass.h>
#import "Post.h"

@implementation User

@dynamic username;
@dynamic postsRelation;
@dynamic locationRelation;

+ (void)load {
    
    [self registerSubclass];
    
}

@end
