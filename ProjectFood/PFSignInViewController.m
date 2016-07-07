//
//  PFSignInViewController.m
//  ProjectFood
//
//  Created by Abbin Varghese on 07/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PFSignInViewController.h"
#import "PFConstants.h"
#import "PFManager.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@import Firebase;

@interface PFSignInViewController ()<FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *logInbutton;

@end

@implementation PFSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _logInbutton.delegate = self;
    _logInbutton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    if (error == nil && [FBSDKAccessToken currentAccessToken]
        .tokenString){
        self.view.userInteractionEnabled = NO;
        FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                         credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                         .tokenString];
        [[FIRAuth auth] signInWithCredential:credential
                                  completion:^(FIRUser *user, NSError *error) {
                                      
                                      self.view.userInteractionEnabled = YES;
                                      if (error == nil) {
                                          FIRDatabaseReference *ref = [[FIRDatabase database] reference];
                                          NSDictionary *post = @{userIDKey: user.uid,
                                                                 userIsAnonymousKey:[NSNumber numberWithBool:user.isAnonymous]};
                                          NSDictionary *childUpdates = @{[@"/users/" stringByAppendingString:user.uid]: post};
                                          [ref updateChildValues:childUpdates];
                                          if (![PFManager isUserLocationSet]) {
                                              [self performSegueWithIdentifier:locationSegueKey sender:self];
                                          }
                                          else{
                                              [self dismissViewControllerAnimated:YES completion:nil];
                                          }
                                          
                                      }
                                  }];

    }
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    
}

- (IBAction)signInLater:(id)sender {
    if ([FIRAuth auth].currentUser == nil) {
        self.view.userInteractionEnabled = NO;
        [[FIRAuth auth]
         signInAnonymouslyWithCompletion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
             
             self.view.userInteractionEnabled = YES;
             if (error == nil) {
                 FIRDatabaseReference *ref = [[FIRDatabase database] reference];
                 NSDictionary *post = @{userIDKey: user.uid,
                                        userIsAnonymousKey:[NSNumber numberWithBool:user.isAnonymous]};
                 NSDictionary *childUpdates = @{[@"/users/" stringByAppendingString:user.uid]: post};
                 [ref updateChildValues:childUpdates];
                 if (![PFManager isUserLocationSet]) {
                     [self performSegueWithIdentifier:locationSegueKey sender:self];
                 }
                 else{
                     [self dismissViewControllerAnimated:YES completion:nil];
                 }
                 
             }
         }];

    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
