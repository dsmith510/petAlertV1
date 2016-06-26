//
//  SearchTableViewCell.h
//  petAlertV1
//
//  Created by Danielle Smith on 6/26/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface SearchTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet PFImageView *animalImageView;
@property (weak, nonatomic) IBOutlet UILabel *animalStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *animalDescriptionTextView;

@end
