//
//  PFTagTableViewCell.h
//  ProjectFood
//
//  Created by Abbin Varghese on 11/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLTagsControl.h"

@interface PFTagTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet TLTagsControl *cellTagView;

@end
