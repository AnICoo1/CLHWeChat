//
//  CLHShakeOffViewController.m
//  wechats
//
//  Created by AnICoo1 on 2017/3/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHShakeOffViewController.h"
#import <SVProgressHUD.h>

@interface CLHShakeOffViewController ()

@end

@implementation CLHShakeOffViewController
{
    UIImageView *_imageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    _imageView.frame = CGRectMake(200, 200, 100, 100);
    [self.view addSubview:_imageView];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 200) radius:30 startAngle:M_PI_2 endAngle:M_PI clockwise:NO];
    anim.keyPath = @"position";
    anim.path = path.CGPath;
    anim.duration = 2.0;
    [_imageView.layer addAnimation:anim forKey:nil];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"cancelled");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [SVProgressHUD showSuccessWithStatus:@"你摇完了,然而什么都没有发生"];
    
}

@end
