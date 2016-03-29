//
//  LocationViewController.h
//  petAlertV1
//
//  Created by Danielle Smith on 1/30/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>


@protocol SelectedLocationDelegate <NSObject>

-(void)didSelectLocation:(CLLocation *)selectedLocation;
  
@end

@interface LocationViewController : UIViewController

@property (nonatomic, assign) id <SelectedLocationDelegate> delegate;
@property CLLocation *selectedLocation;



@end
