//
//  RegistrationViewController.m
//  petAlertV1
//
//  Created by Danielle Smith on 1/29/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import "RegistrationViewController.h"
#import <Parse/Parse.h>
#import "User.h"
#import "AppDelegate.h"

@interface RegistrationViewController ()

// Outlets
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

// Properties
@property AppDelegate *delegate;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
// Set delegate
    self.delegate = [[UIApplication sharedApplication] delegate];
    
}

- (IBAction)onSignUpButtonTapped:(id)sender {
    
// Creating and initializing variables for all fields
    NSString *email = self.emailTextField.text;
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *confirmPassword = self.confirmPasswordTextField.text;
    
// preventing the use of passwords, usernames, and emails less than 4-8 characters in length
    if (username.length < 4 || password.length < 4 || email.length < 8) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Insufficient Username, Password, or Email length" message:@"Please make sure that your username is over 4 characters, your password is over 6 characters, and your email is valid!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Got it" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:okay];
        [self presentViewController:alert animated:YES completion:nil];
        
// Making sure the passwords entered by the user match
    } else if (password != confirmPassword) {
        
// Display Alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Passwords do not match. Please try again." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okayButton = [UIAlertAction actionWithTitle:@"Okay"
                                                             style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                                             }];
        [alert addAction:okayButton];
        [self presentViewController:alert
                           animated:YES
                         completion:nil];
        
        
        
    } else {
        
// If all fields have been correctly completed, initiate signup process in background
        User *newUser = [User new];
        
        newUser.username = username;
        newUser.password = password;
        newUser.email = email;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            
// Alert user if there is an error
            if (error) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okay = [UIAlertAction actionWithTitle:@"Got it" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:okay];
                [self presentViewController:alert animated:YES completion:nil];
                
            } else {
                
// if no error, direct user to homescreen
                NSLog(@"Success");
                self.delegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"main"];
                [self.delegate.window setRootViewController:vc];
                [self.delegate.window makeKeyAndVisible];
                
            }
        }];
        
    }
    
    [self.view endEditing:YES];
    
    
    
    
    
    
}


@end
