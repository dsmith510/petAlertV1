//
//  Post.h
//  petAlertV1
//
//  Created by Danielle Smith on 1/29/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "Comment.h"

@class User;

@interface Post : PFObject <PFSubclassing>

@property (nonatomic) User *createdBy;
@property (nonatomic) NSString *username;
@property (nonatomic) NSNumber *numberOfComments;
@property (nonatomic) PFFile *image;
@property (nonatomic) PFGeoPoint *location;
@property (nonatomic) PFRelation *commentsRelation;
@property (nonatomic) NSString *filter;
@property (nonatomic) NSString *caption;
@property (nonatomic) NSString *phoneNumber;
@property (nonatomic) NSString *petStatus;
@property (nonatomic) NSDate *createdAt;

+ (NSString *)parseClassName;


@end
