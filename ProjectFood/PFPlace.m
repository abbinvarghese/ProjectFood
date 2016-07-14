//
//  PFPlace.m
//  ProjectFood
//
//  Created by Abbin Varghese on 14/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PFPlace.h"

@implementation PFPlace

-(instancetype)initWithPlace:(NSDictionary*)place{
    self = [self init];
    if (self != nil){
        self.lat = [[[[place objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"] doubleValue];
        self.lng = [[[[place objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"] doubleValue];
        self.name = [place objectForKey:@"name"];
        self.address = [place objectForKey:@"vicinity"];
    }
    return self;
}

@end
