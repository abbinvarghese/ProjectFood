//
//  PFManager.m
//  ProjectFood
//
//  Created by Abbin Varghese on 07/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PFManager.h"
#import "PFConstants.h"

@implementation PFManager

+(BOOL)isUserLocationSet{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:userLocationKey]) {
        return YES;
    }
    else{
        return NO;
    }
}

@end
