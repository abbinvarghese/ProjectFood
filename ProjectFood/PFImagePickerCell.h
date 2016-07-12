//
//  PFImagePickerCell.h
//  ProjectFood
//
//  Created by Abbin Varghese on 08/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFImagePickerCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, copy) NSString *representedAssetIdentifier;

-(void)selectCell:(BOOL)animated;
-(void)deSelectCell:(BOOL)animated;
-(void)shakeCell;
@end
