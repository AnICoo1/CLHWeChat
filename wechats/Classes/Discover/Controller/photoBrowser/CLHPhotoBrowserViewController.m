//
//  CLHPhotoBrowserViewController.m
//  wechats
//
//  Created by AnICoo1 on 2017/3/22.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHPhotoBrowserViewController.h"
#import "CLHPhotoCell.h"


@interface CLHPhotoBrowserViewController () <photoCellDelegate,UICollectionViewDataSource>

@end

static NSString *ID = @"cell";

@implementation CLHPhotoBrowserViewController
{
    UICollectionView *_collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpAll];
    //跳转到指定页
    [_collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition: UICollectionViewScrollPositionLeft animated:NO];
//    NSLog(@"%zd",self.indexPath.row);
    
}

- (void)setUpAll{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(screenW, screenH);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_collectionView registerClass:[CLHPhotoCell class] forCellWithReuseIdentifier:ID];
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.frame = self.view.bounds;
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CLHPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.imageArray[indexPath.row]]];
    cell.delegate = self;
    return cell;
}
- (void)imageViewDidClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - photoBrowserAnimatorDismissDelegate

- (NSInteger)indexForDismissView{
    CLHPhotoCell *cell = [_collectionView visibleCells].firstObject;
    return [_collectionView indexPathForCell:cell].row;
}

- (UIImageView *)imageViewForDismissView{
    UIImageView *imageView = [[UIImageView alloc] init];
    CLHPhotoCell *cell = [_collectionView visibleCells].firstObject;
    imageView.image = cell.imageView.image;
    imageView.frame = cell.imageView.frame;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.clipsToBounds = YES;
    return imageView;
    
}

@end
