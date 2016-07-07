//
//  PFLocationViewController.m
//  ProjectFood
//
//  Created by Abbin Varghese on 07/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PFLocationViewController.h"
#import "NSMutableDictionary+TFALocation.h"
#import "PFConstants.h"
#import "PFLocationPicker.h"

@import GoogleMaps;

@interface PFLocationViewController ()<PFLocationPickerDelegate>

@end

@implementation PFLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)detectLocation:(id)sender {
    [[GMSPlacesClient sharedClient] currentPlaceWithCallback:^(GMSPlaceLikelihoodList * _Nullable likelihoodList, NSError * _Nullable error) {
        if (error == nil) {
            GMSPlaceLikelihood *likelihood = [likelihoodList.likelihoods objectAtIndex:0];
            GMSPlace* place = likelihood.place;
            NSMutableDictionary *obj = [[NSMutableDictionary alloc]initWithGMSPlace:place];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:obj forKey:userLocationKey];
            [defaults setBool:YES forKey:firstLaunchKey];
            [defaults synchronize];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else{
            
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to get your current location" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:locationPickerSegueKey]) {
        PFLocationPicker *picker = segue.destinationViewController;
        picker.delegate = self;
    }
}

-(void)PFLocationPicker:(PFLocationPicker *)picker didCompleteWithLocation:(NSMutableDictionary *)location{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:location forKey:userLocationKey];
    [defaults setBool:YES forKey:firstLaunchKey];
    [defaults synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
