//
//  PFImagePreviewCollectionViewCell.m
//  ProjectFood
//
//  Created by Abbin Varghese on 08/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PFImagePreviewCollectionViewCell.h"

@interface PFImagePreviewCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

@end

@implementation PFImagePreviewCollectionViewCell

-(void)setCellImage:(UIImage *)cellImage{
    _cellImage = cellImage;
    _cellImageView.image = cellImage;
}

@end
