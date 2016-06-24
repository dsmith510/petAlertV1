//
//  SearchViewController.m
//  petAlertV1
//
//  Created by Danielle Smith on 1/29/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//
#import "Animals.h"
#import "Animal.h"
#import "SearchViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>




@interface SearchViewController ()<UISearchBarDelegate,UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *locationTextField;

@property UISearchController *searchController;
@property UISearchBar *searchBar;
@property UITableView *tableView;
@property NSMutableArray *animalPostArray;
@property NSString *one;
@property NSString *two;
@property NSString *three;
@property NSString *four;
@property NSString *five;
@property double lat;
@property double longitude;
@property CLLocation *petSearchLocation;
@property CLLocationCoordinate2D coordinate;
@property Animals *animals;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Animals *animals = [Animals new];
//    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self];
//    self.searchController.searchResultsUpdater = self;
//    self.searchController.dimsBackgroundDuringPresentation = false;
//    self.definesPresentationContext = true;
//    self.searchController.searchBar.delegate = self;
//    self.navigationItem.titleView = self.searchController.searchBar;
//    
//    self.lat = [self.latTextField.text doubleValue];
//    self.longitude = [self.longTextfield.text doubleValue];
//    self.petSearchLocation = [[CLLocation alloc] initWithLatitude:_lat longitude:_longitude];
//    self.coordinate = CLLocationCoordinate2DMake(_lat, _longitude);
//    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
//   [animals queryForAnimalPostsNearUser:geoPoint WithCompletion:^(NSMutableArray *animalPosts) {
//       [self.tableView reloadData];
//   }];
    
    
    
//    
//    self.one = @"Friendly female Brown dog with blue eyes";
//    self.two = @"Timid White cat with green eyes";
//    self.three = @"Sweet yellow cat with white stomach";
//    self.four = @"Female Black dog with purple collar";
//    self.five = @"Beige male Rabbit with black spots";
//    self.tempArray = [[NSArray alloc] initWithObjects: self.one, self.two, self.three, self.four, self.five, nil];
    
    
    
    
    
    
// change the appearance of the navigation bar
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:144.0 / 255.0 green:216.0 / 255.0 blue:194.0 / 255.0 alpha:1.0];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
}


- (IBAction)onSearchButtonTapped:(id)sender
{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    NSString *location = self.locationTextField.text;
    [geocoder geocodeAddressString:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error)
    {
        if (error)
        {
            NSLog(@"Error!");
        }
        else
        {
            if (placemarks && placemarks.count > 0)
            {
                CLPlacemark *placemark = placemarks[0];
                CLLocation *petSearchLocation = placemark.location;
                PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:petSearchLocation.coordinate.latitude longitude:petSearchLocation.coordinate.longitude];
                [self.animals queryForAnimalPostsNearUser:geoPoint WithCompletion:^(NSMutableArray *array)
                {
                    [self.tableView reloadData];
                }];
            }
        }
    }];
//    self.lat = [self.latTextField.text doubleValue];
//    self.longitude = [self.longTextfield.text doubleValue];
//    self.petSearchLocation = [[CLLocation alloc] initWithLatitude:_lat longitude:_longitude];
//    self.coordinate = CLLocationCoordinate2DMake(_lat, _longitude);
//    
//    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
//    Animals *animals = [Animals new];
//    [animals queryForAnimalPostsNearUser:geoPoint WithCompletion:^(NSMutableArray *animalPosts) {
//        [self.tableView reloadData];
//    }];

    
    NSLog(@"button pressed");
}

# pragma mark - UITableView Delegate Methods

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.animals.animalArray.count;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    Animal *animal = self.animals.animalArray[indexPath.row];
    cell.textLabel.text = animal.caption;
    [animal.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error)
    {
        cell.imageView.image = [UIImage imageWithData:data];
    }];

    
    return cell;
}

#pragma mark - UISearchResultsUpdating Delegate Methods
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
      
}





@end
