//
//  CLHWerChatPhotoView.m
//  wechats
//
//  Created by AnICoo1 on 17/2/25.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHWerChatPhotoView.h"
#import "CLHSeeBigPhotoViewController.h"
#import "CLHPhotoBrowserViewController.h"
#import "CLHPhotoBrowserAnimator.h"

@interface CLHWerChatPhotoView () <photoBrowserAnimatorDelegate>


@property(nonatomic, strong) CLHPhotoBrowserAnimator *animator;

@end

@implementation CLHWerChatPhotoView

#pragma mark - 懒加载
- (CLHPhotoBrowserAnimator *)animator{
    if(!_animator){
        _animator = [[CLHPhotoBrowserAnimator alloc] init];
    }
    return _animator;
}


- (void)setPhotoArray:(NSArray *)photoArray{
    _photoArray = photoArray;
    
    NSInteger count = photoArray.count;
//    NSLog(@"count = %zd",count);
    if(count == 0){
        self.height = 0;
        self.fixedHeight = @(0);
        return ;
    }
    
    //设置imageView宽高
    CGFloat imageW = [self getWidthOfImageView];
    CGFloat imageH = 0;
    if(count == 1){//只有一张图片
        UIImage *image = [UIImage imageNamed:_photoArray.firstObject];
        if (image.size.width) {
            imageH = image.size.height / image.size.width * imageW;
        }
    } else{
        imageH = imageW;
    }
    
    NSInteger NumberPerRow = [self getNumberOfPerRow];
    
    for(NSInteger i = 0; i < count; i++){
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.userInteractionEnabled = YES;
        imageV.image = [UIImage imageNamed:_photoArray[i]];
        imageV.tag = i;
        NSInteger column = i % NumberPerRow;
        NSInteger row = i / NumberPerRow;
        CGFloat imageX = column * (imageW + 5);
        CGFloat imageY = row * (imageH + 5);
        imageV.frame = CGRectMake(imageX, imageY, imageW, imageH);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [imageV addGestureRecognizer:tap];
        [self addSubview:imageV];
    }
    
    CGFloat w = NumberPerRow * imageW + (NumberPerRow - 1) * 5;
    int columnCount = ceilf(count * 1.0 / NumberPerRow);
    CGFloat h = columnCount * imageH + (columnCount - 1) * 5;
    self.width = w;
    self.height = h;
    
//    NSLog(@"w = %f, h = %f",w,h);
    self.fixedHeight = @(h);
    self.fixedWidth = @(w);
    
}

- (void)click:(UITapGestureRecognizer *)tap{
//    UIView *imageV = tap.view;
//    CLHSeeBigPhotoViewController *seeV = [[CLHSeeBigPhotoViewController alloc] init];
//    seeV.bigPhotoArray = self.photoArray;
//    seeV.index = imageV.tag;
    CLHPhotoBrowserViewController *photoVC = [[CLHPhotoBrowserViewController alloc] init];
    photoVC.imageArray = self.photoArray;
    photoVC.indexPath = [NSIndexPath indexPathForRow:tap.view.tag inSection:0];
    photoVC.modalPresentationStyle = UIModalPresentationCustom;
    photoVC.transitioningDelegate = self.animator;
    self.animator.animationDelegate = self;
    self.animator.index = tap.view.tag;
    self.animator.animationDismissDelegate = photoVC;
    
    [self.window.rootViewController presentViewController:photoVC animated:YES completion:nil];
}

#pragma mark - photoBrowserAnimatorDelegate

- (CGRect)startRect:(NSInteger)index{
    UIImageView *imageView = nil;
    for(NSInteger i = 0; i < self.subviews.count; i++){
        if([self.subviews[i] isKindOfClass:[UIImageView class]]){
            UIImageView *view = self.subviews[i];
            if(view.tag == index){
                imageView = view;
            }
        }
    }
    return [self convertRect:imageView.frame toView:[UIApplication sharedApplication].keyWindow];
}

- (CGRect)endRect:(NSInteger)index{
    UIImage *image = [UIImage imageNamed:self.photoArray[index]];
    //计算imageView的frame
    CGFloat x = 0;
    CGFloat width = screenW;
    CGFloat height = width / image.size.width * image.size.height;
    CGFloat y = 0;
    if(height < screenH){
        y = (screenH - height) * 0.5;
    }
    return CGRectMake(x, y, width, height);
}

- (UIImageView *)locImageView:(NSInteger)index{
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:self.photoArray[index]];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.clipsToBounds = YES;
    return imageView;
}

- (CGFloat)getWidthOfImageView{
    if(self.photoArray.count == 1){
        return 120;
    }else{
        return 80;
    }
}

- (NSInteger)getNumberOfPerRow{
    if (self.photoArray.count < 3) {
        return self.photoArray.count;
    } else if (self.photoArray.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}

@end
