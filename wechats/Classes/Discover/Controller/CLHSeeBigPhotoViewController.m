//
//  CLHSeeBigPhotoViewController.m
//  wechats
//
//  Created by AnICoo1 on 17/2/26.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHSeeBigPhotoViewController.h"

@interface CLHSeeBigPhotoViewController () <UIScrollViewDelegate>

@end

@implementation CLHSeeBigPhotoViewController
{
    UIButton *_saveButton;
    UIScrollView *_scrollView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAll];
    
    [self setUpPhoto];
}

- (void)setUpAll{
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_saveButton setBackgroundColor:[UIColor grayColor]];
    [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.view addSubview:_saveButton];
    
    _saveButton.sd_layout
    .rightSpaceToView(self.view, 10)
    .bottomSpaceToView(self.view, 10)
    .widthIs(70)
    .heightIs(30);
}

- (void)setUpPhoto{
    UIScrollView *scrollV = [[UIScrollView alloc] init];
    scrollV.frame = self.view.bounds;
    scrollV.pagingEnabled = YES;
    scrollV.bounces = NO;
    [scrollV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    [self.view insertSubview:scrollV atIndex:0];
    _scrollView = scrollV;
    //把图片显示到scrollView上面
    //加载图片
    for(NSInteger i = 0; i < self.bigPhotoArray.count; i++){
        UIImageView *imageV = [self getFrameOfImageView:i];
        [_scrollView addSubview:imageV];
//        NSLog(@"%@",NSStringFromCGRect(imageV.frame));
        

    }
    scrollV.contentSize = CGSizeMake(screenW * self.bigPhotoArray.count, screenH);
    //设置当前显示图片
    scrollV.contentOffset = CGPointMake(self.index * screenW, scrollV.contentOffset.y);
}

- (UIImageView *)getFrameOfImageView:(NSInteger)index{
    UIImageView *imageV = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:self.bigPhotoArray[index]];
    imageV.image = image;
    //设置图片位置
    imageV.width = _scrollView.width;
    imageV.height = imageV.width * image.size.height / image.size.width;
    imageV.x = 0;
    if (imageV.height > screenH) { // 超过一个屏幕
        imageV.x = screenW * index;
        imageV.y = 0;
    } else {
        imageV.center = CGPointMake(imageV.center.x + screenW * index, _scrollView.height * 0.50);
    }
    return imageV;
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / _scrollView.width;
    UIImageView *imageV = [self getFrameOfImageView:index];
    if (imageV.height > screenH) { // 超过一个屏幕
        _scrollView.contentSize = CGSizeMake(screenW * self.bigPhotoArray.count, imageV.height);
    } else {
        _scrollView.contentSize = CGSizeMake(screenW * self.bigPhotoArray.count, screenH);
    }
}


- (void)back:(UITapGestureRecognizer *)tap{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
