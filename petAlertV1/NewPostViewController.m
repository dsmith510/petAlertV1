//
//  NewPostViewController.m
//  petAlertV1
//
//  Created by Danielle Smith on 1/29/16.
//  Copyright © 2016 Danielle Smith. All rights reserved.
//

#import "NewPostViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "NewPostViewController.h"
#import "Post.h"
#import "User.h"
#import <Social/Social.h>
#import "LocationViewController.h"


@interface NewPostViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UIActionSheetDelegate,SelectedLocationDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSegmentedControl;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextView *contactPhoneTextView;
@property (weak, nonatomic) IBOutlet UIButton *sharePostButton;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;


// Properties
@property UIImage *postImage;
@property User *currentUser;
@property PFGeoPoint *locationSelectedByUser;
@property NSString *locationAddress;
@end

@implementation NewPostViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
// change the appearance of the navigation bar
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:144.0 / 255.0 green:216.0 / 255.0 blue:194.0 / 255.0 alpha:1.0];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.title = @"Post";
    self.currentUser = [User currentUser];
    self.sharePostButton.enabled = NO;
    self.sharePostButton.alpha = 0.3;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self setTextViewPlaceHolderText];
    [self.view addGestureRecognizer:tapGesture];

}

-(void)viewDidAppear:(BOOL)animated {

    
    
//change button to location address selected by user
    
    if (self.locationAddress != nil) {
           [self.locationButton setTitle:self.locationAddress forState:UIControlStateNormal];
    }
    else
    {
        [self.locationButton setTitle:@"Select a location" forState:UIControlStateNormal];
    }
 
    
//    LocationViewController *vc = [[LocationViewController alloc] init];
//    vc.delegate = self;
}

-(void)setTextViewPlaceHolderText{
   
    self.descriptionTextView.text = @"Add a description e.g. color, breed, sex, distinguishing marks, etc.";
    self.descriptionTextView.textColor = [UIColor grayColor];
    self.descriptionTextView.tintColor = [UIColor grayColor];
    [self.descriptionTextView resignFirstResponder];
    
    [self.contactPhoneTextView resignFirstResponder];
    self.contactPhoneTextView.text = @"Add a phone number";
    self.contactPhoneTextView.textColor = [UIColor grayColor];
    self.contactPhoneTextView.tintColor = [UIColor blackColor];
    
}
-(void)refreshNewPostTab { 
    [self setTextViewPlaceHolderText];
    self.locationAddress = nil;
    [self.photoButton setBackgroundImage:nil forState:UIControlStateNormal];
    [self.photoButton setTitle:@"Select Photo" forState:UIControlStateNormal];
    [self.statusSegmentedControl setSelectedSegmentIndex:0];
    
}
-(void)dismissKeyboard:(id)sender {
    [self.view endEditing:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    if([textView.text isEqualToString:@"Add a description e.g. color, breed, sex, distinguishing marks, etc."])
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.tintColor = [UIColor blackColor];
        
    } else if ([textView.text isEqualToString:@"Add a phone number"]) {
        
        textView.text= @"";
        textView.textColor = [UIColor blackColor];
    }
    
    [textView becomeFirstResponder];
}
-(void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView.tag == 1 && [textView.text isEqualToString:@""]){
        textView.text = @"Add a description e.g. color, breed, sex, distinguishing marks, etc.";
        textView.textColor = [UIColor lightGrayColor];
    } else if (textView.tag == 2 && [textView.text isEqualToString:@""]) {

        textView.text = @"Add a phone number";
        textView.textColor = [UIColor lightGrayColor];
    }
    
    // Dismiss keyboard
    
    [textView resignFirstResponder];
}

-(void)didSelectLocation:(CLLocation *)selectedLocation {
    
    PFGeoPoint *point = [PFGeoPoint geoPointWithLocation:selectedLocation];
     ;
    self.locationSelectedByUser = point;
//    self.locationButton.titleLabel =
    
}

-(void)didSelectAddress:(NSString *)selectedAddress {
    self.locationAddress = selectedAddress;
    
}
- (IBAction)onSelectPhotoButtonTapped:(id)sender {
    
    UIAlertController *Photo = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *selectPhoto = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
// Making an Instance of UIImagePickerController
        UIImagePickerController *pickerController = [UIImagePickerController new];
        
// Setting its delegate
        pickerController.delegate = self;
        
// Setting the sourcetype to the user's photo library
        pickerController.allowsEditing = YES;
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
// Presenting the controller
        [self presentViewController:pickerController animated:YES completion:nil];
        

        
    }];
    
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
// Making an instance of UIImagePickerController
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        
// Setting its delegate
        pickerController.delegate = self;
        
// Setting the sourcetype to camera
        pickerController.allowsEditing = YES;
        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
// Presenting the controller
        
        [self presentViewController:pickerController animated:YES completion:nil];
        
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    
    [Photo addAction:selectPhoto];
    [Photo addAction:takePhoto];
    [Photo addAction:cancel];
    
    [self presentViewController:Photo animated:YES completion:nil];
    
}

#pragma  mark - UIImagePicker Delegate Methods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

// Setting the userimage property to the image selected by the user
    self.postImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
//     Setting the profile image to the image selected by the user
//    self.postImageView.image = self.postImage;
    [self.photoButton setBackgroundImage:self.postImage forState:UIControlStateNormal];
    [self.photoButton setTitle:@"" forState:UIControlStateNormal];

    // Dismissing the Controller
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.sharePostButton.enabled = YES;
    self.sharePostButton.alpha = 1.0;

    
}

- (IBAction)onLocationButtonTapped:(id)sender {
}
- (IBAction)onShareOnSocialMediaButtonTapped:(id)sender {  UIAlertController *shareAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *twitter = [UIAlertAction actionWithTitle:@"Twitter" style:UIAlertActionStyleDefault handler:
                              ^(UIAlertAction * _Nonnull action) {
                                  
                                  // Check if sharing on twitter is possible
                                  if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                                      // Initialize default view controller for sharing the post
                                      
                                      SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                                      // Set the note text as the default post message
                                      
                                      if (self.descriptionTextView.text.length <= 140) {
                                          
                                          [tweet setInitialText:self.descriptionTextView.text];
                                          //[tweet addImage:self.postImage.image];
                                          
                                      } else {
                                          
                                          NSString *index = [self.descriptionTextView.text  substringFromIndex:(140)];
                                          [tweet setInitialText:index];
                                          //[tweet addImage:self.postImageView.image];
                                          
                                          
                                      }
                                      
                                  } else {
                                      [self showAlertMessage];
                                  }
                                  
                              }];
    
    UIAlertAction *facebook = [UIAlertAction actionWithTitle:@"Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewController *composeFacebookPost = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [composeFacebookPost setInitialText:self.descriptionTextView.text];
            //[composeFacebookPost addImage:self.postImageView.image];
            
        } else {
            
            [self showAlertMessage];
        }
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       
                                                   }];
    
    
    [shareAlert addAction:twitter];
    [shareAlert addAction:facebook];
    [shareAlert addAction:cancel];
    
    [self presentViewController:shareAlert animated:YES completion:nil];}
- (void) showAlertMessage {
    
    UIAlertController *Error = [UIAlertController alertControllerWithTitle:nil message:@"Please sign into your account and try again." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Okay = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
     
    }];
    
    [Error addAction:Okay];
    [self presentViewController:Error animated:YES completion:nil];

    
}
- (IBAction)onPostButtonTapped:(id)sender {
    
    Post *newPost = [Post object];
    NSData *data = UIImagePNGRepresentation(self.postImage);
    PFFile *file = [PFFile fileWithName:@"image.png" data:data];
    newPost.image = file;
    newPost.createdBy = self.currentUser;
    newPost.username = self.currentUser.username;
    newPost.caption = self.descriptionTextView.text;
    newPost.phoneNumber = self.contactPhoneTextView.text;
    newPost.numberOfComments = @0;
    newPost.location = self.locationSelectedByUser;
    
    if (self.statusSegmentedControl.selectedSegmentIndex == 0) {
        
        newPost.petStatus = @"Found";
        
    } else if (self.statusSegmentedControl.selectedSegmentIndex == 1) {
        
        newPost.petStatus = @"Spotted";
        
    } else {
        
        newPost.petStatus = @"Missing";
        
    }
    
    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if (succeeded) {
            NSLog(@"yes");
        }
    }];
    
    
    [self refreshNewPostTab];
    [self.tabBarController setSelectedIndex:0];
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    LocationViewController *vc = segue.destinationViewController;
    vc.hidesBottomBarWhenPushed = YES;
    vc.delegate = self;
} 
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    
}


@end
