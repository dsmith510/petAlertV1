//
//  LocationViewController.m
//  petAlertV1
//
//  Created by Danielle Smith on 1/30/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import "LocationViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NewPostViewController.h"


@interface LocationViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>

// Outlets
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *locationView;

@property (weak, nonatomic) IBOutlet UILabel *address;
// Properties
//

@property UIImageView *centerAnnotationImageView;
@property UIImage *pinImage;
@property CLLocationManager *locationManager;
@property CLGeocoder *geocoder;
@property NSString *previousAddress;
@property PFGeoPoint *locationSelectedByUser;


@end

@implementation LocationViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mapView.delegate = self;
    NSLog(@"%@",self.delegate);

// Navigation bar appearance
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationItem setTitle:@"Select a Location"];
    self.locationView.layer.cornerRadius = 9;
self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

// Instantiation
    self.locationManager = [CLLocationManager new];
    self.geocoder = [CLGeocoder new];
    
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestLocation];
      self.mapView.showsUserLocation = true;
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.firstObject;
    self.mapView.centerCoordinate = location.coordinate;
    MKCoordinateRegion reg =MKCoordinateRegionMakeWithDistance(location.coordinate, 1500, 1500);
    [self.mapView setRegion:reg animated:true];
  
    [self geoCode:location];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"%@", error);
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
    self.selectedLocation = [CLLocation new];
    self.selectedLocation = location;
    [self geoCode:location];
    
}
-(void)geoCode:(CLLocation *)location{
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {

            CLPlacemark *placemark = [placemarks firstObject];
        NSString *address = [NSString stringWithFormat:@" %@ %@, %@ ",
            placemark.thoroughfare,placemark.locality, placemark.administrativeArea];
        self.address.text = address;
            self.previousAddress = address;
            self.selectedAddress = address;
        }
    }];
    
  
    
}
- (IBAction)onDoneButtonTapped:(UIBarButtonItem *)sender {
    
    [self.delegate didSelectLocation:self.selectedLocation];
    [self.delegate didSelectAddress:self.selectedAddress];
    [self.navigationController popViewControllerAnimated:YES];
}




@end
