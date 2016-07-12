//
//  PFImagePickerCell.m
//  ProjectFood
//
//  Created by Abbin Varghese on 08/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PFImagePickerCell.h"

@interface PFImagePickerCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PFImagePickerCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = nil;
}

- (void)setThumbnailImage:(UIImage *)thumbnailImage {
    _thumbnailImage = thumbnailImage;
    self.imageView.image = thumbnailImage;
}

-(void)selectCell:(BOOL)animated{
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:1
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:(void (^)(void)) ^{
                         _imageView.transform=CGAffineTransformMakeScale(0.9, 0.9);
                         _imageView.layer.cornerRadius = 5;
                         _imageView.layer.masksToBounds = YES;
                         self.backgroundColor = [UIColor redColor];
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(void)deSelectCell:(BOOL)animated{
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:1
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:(void (^)(void)) ^{
                         _imageView.transform=CGAffineTransformMakeScale(1.0, 1.0);
                         _imageView.layer.cornerRadius = 0;
                         _imageView.layer.masksToBounds = YES;
                         self.backgroundColor = [UIColor clearColor];
                     }
                     completion:^(BOOL finished){
                     }];
}

-(void)shakeCell{
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.05];
    [animation setRepeatCount:3];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake([self.imageView center].x - 5.0f, [self.imageView center].y)]];
    [animation setToValue:[NSValue valueWithCGPoint:
                           CGPointMake([self.imageView center].x + 5.0f, [self.imageView center].y)]];
    [[self.imageView layer] addAnimation:animation forKey:@"position"];
}

@end
