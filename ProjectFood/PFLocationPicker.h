//
//  PFLocationPicker.h
//  ProjectFood
//
//  Created by Abbin Varghese on 07/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFLocationPicker;
@protocol PFLocationPickerDelegate <NSObject>

-(void)PFLocationPicker:(PFLocationPicker*)picker didCompleteWithLocation:(NSMutableDictionary*)location;

@end

@interface PFLocationPicker : UIViewController

@property (strong, nonatomic) id <PFLocationPickerDelegate> delegate;

@end
