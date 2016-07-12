//
//  PFItemPicker.h
//  ProjectFood
//
//  Created by Abbin Varghese on 11/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PFPickerModeType){
    PFPickerModeTypeItem,
    PFPickerModeTypeRestaurant
};

@class PFItemPicker;
@protocol PFItemPickerDelegate <NSObject>

-(void)PFItemPicker:(PFItemPicker*)picker didFinishWithExistingItem:(NSDictionary*)item;
-(void)PFItemPicker:(PFItemPicker*)picker didFinishWithNewItem:(NSString*)item;

@end

@interface PFItemPicker : UIViewController

@property (strong, nonatomic) id <PFItemPickerDelegate> delegate;
@property (assign, nonatomic) PFPickerModeType pickerMode;

@end
