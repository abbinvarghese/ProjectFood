//
//  PFImagePreviewCell.m
//  ProjectFood
//
//  Created by Abbin Varghese on 08/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import "PFImagePreviewCell.h"
#import "PFImagePreviewCollectionViewCell.h"

@implementation PFImagePreviewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PFImagePreviewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PFImagePreviewCollectionViewCell" forIndexPath:indexPath];
    cell.cellImage = [_images objectAtIndex:indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    UIImage *image = _images[indexPath.row];
    return CGSizeMake(collectionView.frame.size.height * image.size.width/image.size.height, collectionView.frame.size.height);
}

@end
