//
//  PFTextFieldCell.h
//  ProjectFood
//
//  Created by Abbin Varghese on 08/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFAddFirstViewController.h"

@interface PFTextFieldCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *cellTextField;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

-(void)shakeCell;

@end
