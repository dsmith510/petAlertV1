//
//  HomeViewController.m
//  petAlertV1
//
//  Created by Danielle Smith on 1/29/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "User.h"
#import "Post.h"
#import "Comment.h"
#import "PostHeaderTableViewCell.h"
#import "PostTableViewCell.h"
#import <MessageUI/MessageUI.h>

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate, PostTableViewCellDelegate, MFMailComposeViewControllerDelegate>

// Outlets
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// Properties
@property (nonatomic) User *currentUser;
@property (nonatomic) NSMutableArray *posts;
@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) MFMailComposeViewController *mc;
@property (nonatomic, strong) PFGeoPoint *usersLocation;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
// Set delegate
    self.tableView.delegate = self;
    
// change the appearance of the navigation bar
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:144.0 / 255.0 green:216.0 / 255.0 blue:194.0 / 255.0 alpha:1.0];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.title = @"Home";

// Initialize Current User
    self.currentUser = [User currentUser];
    
// Instantiate array
    self.posts = [NSMutableArray new];


// Find user's current location
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint * _Nullable geoPoint, NSError * _Nullable error) {
        if (!error) {
            self.usersLocation = geoPoint;
            [self loadView];
        }
    }];
    
    [self queryForPostsNearUser];
    
}

-(void) loadRefreshControl {
    self.refreshControl = [UIRefreshControl new];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.refreshControl addTarget:self action:@selector(refreshControl) forControlEvents:UIControlEventValueChanged];
    //asyncDataLoad
    [self.tableView addSubview:self.refreshControl];
    self.tableView.alwaysBounceVertical = YES;
}

-(void)refreshControlAction {
    [self.refreshControl beginRefreshing];
}

-(PFQuery *) queryForPostsNearUser {
    if (!self.usersLocation) {
        return nil;
    }
    PFGeoPoint *userGeopoint = self.usersLocation;
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"geoPoint" nearGeoPoint:userGeopoint withinMiles:100];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        for (Post *post in objects) {
            [self.posts addObject:post];
        }
    }];
    
    return query;
}

#pragma mark - PostTableview Delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.posts.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.posts[indexPath.section];
    cell.delegate = self;
    
    cell.post = post;
    cell.postImageView.file = post.image;
    [cell.postImageView loadInBackground];
    cell.numberOfCommentsLabel.text = [NSString stringWithFormat:@"%@",[post.numberOfComments stringValue]];
    cell.captionTextView.text = post.caption;
    
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PostHeaderTableViewCell *postHeaderCell = [tableView dequeueReusableCellWithIdentifier:@"PostHeaderCell"];
    Post *post = self.posts[section];
    postHeaderCell.alertLabel.text = post.petStatus;
    postHeaderCell.dateLabel.text = [NSString stringWithFormat:@ "%@", post.createdAt];
    
    
    //    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    //    [dateFormatter setDateFormat:@"MMM dd"];
    //    //    [dateFormatter setTimeStyle:NSDateIntervalFormatterNoStyle];
    //    NSString *formattedDateString = [dateFormatter stringFromDate:activity.date];
    //   postHeaderCell.dateLabel.text = [NSString stringWithFormat:@"%@",formattedDateString];
    return postHeaderCell;
}

    


@end