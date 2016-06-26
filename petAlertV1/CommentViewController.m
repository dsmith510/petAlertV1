//
//  CommentViewController.m
//  petAlertV1
//
//  Created by Danielle Smith on 6/24/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <UIKit/UIKit.h>
#import "CommentViewController.h"
#import "CommentTableViewCell.h"
#import "User.h"
#import "Post.h"
#import "Comment.h"
#import "HomeViewController.h"
#import "Animals.h"

@interface CommentViewController ()<UITableViewDelegate, UITableViewDataSource>

// Properties

@property User *currentUser;
@property NSMutableArray *comments;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addCommentBarButton;
@property Animals *animals;


@end

@implementation CommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentUser = [User currentUser];
    self.animals = [Animals new];
    self.comments = [NSMutableArray new];
    self.tableView.delegate = self;
    
    [self.animals getCommentsforAnimal:self.animal WithCompletion:^(NSMutableArray *array)
    {
        self.comments = array;
        [self.tableView reloadData];
    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comments.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    Comment *comment = self.comments[indexPath.row];
    NSLog(@"comment: %@", comment);
    commentCell.usernameLabel.text = comment.user.username;
    commentCell.commentTextView.text = comment.text;
    commentCell.timeStampLabel.text = [self formatCommentTimeStamp:comment];
    return commentCell;
}

//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    Comment *comment = self.comments[indexPath.row];
//    if (comment.user.objectId == self.currentUser.objectId)
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//}

//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    Comment *comment = self.comments[indexPath.row];
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        self.animal.numberOfComments = @(self.animal.numberOfComments.integerValue - 1);
//       [self.animals deleteComment:comment fromAnimalPost:self.animal atIndexPath:indexPath inArray: self.comments WithCompletion:^{
//           [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
//       }];
//        
//    }
//}


- (IBAction)onAddCommentButtonTapped:(UIBarButtonItem *)sender
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add a comment" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField)
    {
        
    }];
    
    UIAlertAction *post = [UIAlertAction actionWithTitle:@"Post" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        UITextField *textField = alert.textFields.firstObject;
        
        if (textField.text.length >= 1)
        {
            Comment *newComment = [Comment object];
           [self.animals addComment:newComment fromTextField:textField byUser:self.currentUser toAnimalPost:self.animal inArray:self.comments withCompletion:^
           {
               [self.tableView reloadData];
           }];
            
        
        }
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
    {
        
    }];
    
    [alert addAction:post];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}



-(NSString *)formatCommentTimeStamp: (Comment *)comment
{
    NSString *timeStamp;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    NSDate *datePosted = comment.createdAt;
    
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:datePosted toDate:currentDate options:0];
    NSInteger time = components.hour;
    
    if (time < 1)
    {
        NSDateComponents *components = [calendar components:NSCalendarUnitMinute fromDate:datePosted toDate:currentDate options:0];
        NSInteger time = components.minute;
        timeStamp = [NSString stringWithFormat:@"%lum", time];
    }
    else
    {
        timeStamp = [NSString stringWithFormat:@"%luh", time];
    }
    
    return timeStamp;
}
@end
