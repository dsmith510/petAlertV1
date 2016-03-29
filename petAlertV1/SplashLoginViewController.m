//
//  SplashLoginViewController.m
//  petAlertV1
//
//  Created by Danielle Smith on 1/29/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import "SplashLoginViewController.h"

@interface SplashLoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registrationButton;

@end

@implementation SplashLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
// change the appearance of the navigation bar
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
// change appearance of login button
    self.loginButton.layer.borderWidth = 2;
    self.loginButton.layer.borderColor = [[UIColor colorWithRed:144.0 / 255.0 green:216.0 / 255.0 blue:194.0 / 255.0 alpha:1.0] CGColor];
    
    
    
}





@end
