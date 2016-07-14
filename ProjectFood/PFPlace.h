//
//  PFPlace.h
//  ProjectFood
//
//  Created by Abbin Varghese on 14/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFPlace : NSObject

@property (assign, nonatomic) double lat;
@property (assign, nonatomic) double lng;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;

-(instancetype)initWithPlace:(NSDictionary*)place;

@end
