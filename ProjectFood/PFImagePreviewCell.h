//
//  PFImagePreviewCell.h
//  ProjectFood
//
//  Created by Abbin Varghese on 08/07/16.
//  Copyright © 2016 Abbin Varghese. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFImagePreviewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *images;

@end
