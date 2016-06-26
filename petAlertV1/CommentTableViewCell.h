//
//  CommentTableViewCell.h
//  petAlertV1
//
//  Created by Danielle Smith on 6/25/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <UIKit/UIKit.h>


@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;

@end
