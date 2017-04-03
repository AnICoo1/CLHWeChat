//
//  CLHPhotoCell.h
//  wechats
//
//  Created by AnICoo1 on 2017/3/22.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol photoCellDelegate <NSObject>

- (void)imageViewDidClick;

@end

@interface CLHPhotoCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, weak) id<photoCellDelegate> delegate;

@end
