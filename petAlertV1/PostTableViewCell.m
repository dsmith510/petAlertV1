//
//  PostTableViewCell.m
//  petAlertV1
//
//  Created by Danielle Smith on 1/29/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import "PostTableViewCell.h"
#import <parse/Parse.h>
#import "User.h"
#import "Post.h"
#import "Comment.h"

@implementation PostTableViewCell

- (void)awakeFromNib {
    self.currentUser = [User currentUser];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (IBAction)onCommentButtonTapped:(UIButton *)sender {
    [self.delegate didTapCommentButton:sender onCell:self];
    
        [UIView animateWithDuration:0.1f animations:^{
            CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
          [UIView animateWithDuration:0.1f animations:^{
              self.commentButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
          }];
        }];
        
}

- (IBAction)onContactButtonTapped:(UIButton *)sender {
    
    [self.delegate didTapContactButton:sender onCell:self];
    
        [UIView animateWithDuration:0.1f animations:^{
            self.contactButton.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:
         ^(BOOL finished) {
             [UIView animateWithDuration:0.1f animations:^{
                 self.contactButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
             }];
         }];  

    
    
}


- (IBAction)onShareButtonTapped:(UIButton *)sender
{
    
    [self.delegate didTapShareButton:sender onCell:self];
    
        [UIView animateWithDuration:0.1f animations:^{
            self.shareButton.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:
         ^(BOOL finished) {
             [UIView animateWithDuration:0.1f animations:^{
                 self.shareButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
             }];
         }];
    
}

- (IBAction)onMoreButtonTapped:(UIButton *)sender
{
    [self.delegate didTapMoreButton:sender onCell:self];
    
        [UIView animateWithDuration:0.1f animations:^{
            self.moreButton.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:
         ^(BOOL finished) {
             [UIView animateWithDuration:0.1f animations:^{
                 self.moreButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
             }];
         }];
}
 

- (IBAction)onLocationButtonTapped:(UIButton *)sender
{
    [self.delegate didTapLocationButton:sender onCell:self];
}

@end
