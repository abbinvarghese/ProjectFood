//
//  PFTextFieldCell.m
//  ProjectFood
//
//  Created by Abbin Varghese on 08/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PFTextFieldCell.h"

@interface PFTextFieldCell ()

@end

@implementation PFTextFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)shakeCell{
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.05];
    [animation setRepeatCount:3];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake([self.cellImageView center].x - 5.0f, [self.cellImageView center].y)]];
    [animation setToValue:[NSValue valueWithCGPoint:
                           CGPointMake([self.cellImageView center].x + 5.0f, [self.cellImageView center].y)]];
    [[self.cellImageView layer] addAnimation:animation forKey:@"position"];
}

@end
