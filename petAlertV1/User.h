//
//  User.h
//  petAlertV1
//
//  Created by Danielle Smith on 1/29/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import <Parse/Parse.h>

@class Post;

@interface User : PFUser <PFSubclassing>

@property (nonatomic) NSString *fullName;
@property (nonatomic) PFRelation *postsRelation;
@property (nonatomic) PFRelation *locationRelation;

@end
