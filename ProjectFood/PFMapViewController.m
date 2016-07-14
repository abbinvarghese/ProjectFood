//
//  PFMapViewController.m
//  ProjectFood
//
//  Created by Abbin Varghese on 13/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PFMapViewController.h"
#import <MapKit/MapKit.h>

@interface PFMapViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL oneTimeLocationUpdate;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) CLLocation *userLoc;

@end

@implementation PFMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    self.title = @"Add location";
    

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    
    _geocoder = [[CLGeocoder alloc] init];
    
    _mapView.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    [self.locationManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    _userLoc = newLocation;
    [self.locationManager stopUpdatingLocation];
    if (!_oneTimeLocationUpdate) {
        _oneTimeLocationUpdate = YES;
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 500, 500);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    }
}

- (IBAction)currentLocation:(id)sender {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(_userLoc.coordinate, 500, 500);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

- (IBAction)didLongPressMap:(UILongPressGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateBegan){
        NSLog(@"Bang!!");
        CGPoint touchLocation = [sender locationInView:_mapView];
        
        CLLocationCoordinate2D coordinate;
        coordinate = [_mapView convertPoint:touchLocation toCoordinateFromView:_mapView];
        
//        CLLocation *selectedLocation = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//        
//        [_geocoder reverseGeocodeLocation:selectedLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//            if (error == nil && [placemarks count] > 0) {
//                CLPlacemark *placemark = [placemarks lastObject];
//                NSLog(@"%@", placemark.location);
//                NSLog(@"%@", placemark.region);
//                NSLog(@"%@", placemark.timeZone);
//                NSLog(@"%@", placemark.addressDictionary);
//                NSLog(@"%@", placemark.name);
//                NSLog(@"%@", placemark.thoroughfare);
//                NSLog(@"%@", placemark.subThoroughfare);
//                NSLog(@"%@", placemark.locality);
//                NSLog(@"%@", placemark.subLocality);
//                NSLog(@"%@", placemark.administrativeArea);
//                NSLog(@"%@", placemark.subAdministrativeArea);
//                NSLog(@"%@", placemark.postalCode);
//                NSLog(@"%@", placemark.ISOcountryCode);
//                NSLog(@"%@", placemark.country);
//                NSLog(@"%@", placemark.inlandWater);
//                NSLog(@"%@", placemark.ocean);
//                NSLog(@"%@", placemark.areasOfInterest);
//            } else {
//                NSLog(@"%@", error.debugDescription);
//            }
//        } ];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=100&key=AIzaSyBD4bIjdmZIvFC_HjOdnH8aOEGrUNozMAs",coordinate.latitude,coordinate.longitude];
            NSURL *googleRequestURL=[NSURL URLWithString:url];
            NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
            
            NSError* error;
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  
                                  options:kNilOptions
                                  error:&error];
            
            NSArray* places = [json objectForKey:@"results"];
    
            NSLog(@"Google Data: %@", places);
        });
        
        sender.enabled = NO;
    }
}

-(void)done:(id)sender{
    
}

-(void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
