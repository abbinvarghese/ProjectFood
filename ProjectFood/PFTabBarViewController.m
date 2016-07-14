//
//  PFTabBarViewController.m
//  ProjectFood
//
//  Created by Abbin Varghese on 07/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PFTabBarViewController.h"
#import "PFConstants.h"
#import "PFManager.h"

@import Firebase;

@interface PFTabBarViewController ()

@end

@implementation PFTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    if ([FIRAuth auth].currentUser == nil) {
//        [self performSegueWithIdentifier:signInSegueKey sender:self];
//    }
//    else if (![PFManager isUserLocationSet]) {
//        [self performSegueWithIdentifier:directLocationSegueKey sender:self];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
