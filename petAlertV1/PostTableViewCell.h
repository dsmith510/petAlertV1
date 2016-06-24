//
//  PostTableViewCell.h
//  petAlertV1
//
//  Created by Danielle Smith on 1/29/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//


// Frameworks
#import <UIKit/UIKit.h>
#import <parse/Parse.h>
#import <ParseUI/ParseUI.h>

// Classes
@class User;
@class Post;
@class PostTableViewCell;
@class Animals;
@class Animal;

// Delegate
@protocol PostTableViewCellDelegate <NSObject>

// Delegate Methods
- (void) didTapContactButton: (UIButton *)sender onCell: (PostTableViewCell *)cell;

- (void) didTapCommentButton: (UIButton *)sender onCell: (PostTableViewCell *)cell;

- (void) didTapMoreButton: (UIButton *)sender onCell:(PostTableViewCell *)cell;

@end

@interface PostTableViewCell : UITableViewCell

// Properties
@property (nonatomic, assign) id <PostTableViewCellDelegate> delegate;
@property (nonatomic) User *currentUser;
@property (nonatomic) Animal *animalPost;

// Outlets
@property (weak, nonatomic) IBOutlet PFImageView *animalImageView;
@property (weak, nonatomic) IBOutlet UIButton *contactButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfCommentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;

@end
