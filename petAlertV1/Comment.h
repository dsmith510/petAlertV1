//
//  Comment.h
//  petAlertV1
//
//  Created by Danielle Smith on 1/29/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import <Parse/Parse.h>

@class User;
@class Post;

@interface Comment : PFObject <PFSubclassing>

@property (nonatomic) User *user;
@property (nonatomic) NSString *text;

+ (NSString *) parseClassName;

@end
