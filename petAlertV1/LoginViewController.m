//
//  LoginViewController.m
//  petAlertV1
//
//  Created by Danielle Smith on 1/29/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import "LoginViewController.h"
#import <parse/Parse.h>
#import "User.h"
#import "AppDelegate.h"

@interface LoginViewController ()

// Outlets
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

// Properties
@property AppDelegate *delegate;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
// Set delegate
    self.delegate = [[UIApplication sharedApplication] delegate];
    
// Change appearance of Navigation Bar
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:144.0 / 255.0 green:216.0 / 255.0 blue:194.0 / 255.0 alpha:1.0];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (IBAction)onLoginButtonTapped:(id)sender {
// Creating and initializing variables for all fields
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
// Dismiss keyboard
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
// prevent the use of passwords or usernames that are less than four characters in length
    if (username.length < 4 || password.length < 4) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Insufficient Username or Password length" message:@"Please make sure your username is over 4 characters and your password is over 6 characters!" preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:okay];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        
// If all fields are completed correctly, initiate login process in background
        [User logInWithUsernameInBackground:username password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
            
// If user is valid, complete login process and direct them to homescreen
            if (user != nil){
                
                NSLog(@"successful login");
                self.delegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"main"];
                [self.delegate.window setRootViewController:vc];
                [self.delegate.window makeKeyAndVisible];
            } else {
// If user is invalid, display an error message
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Got it" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:okay];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }

}



@end
