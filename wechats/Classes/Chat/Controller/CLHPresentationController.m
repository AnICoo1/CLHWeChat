//
//  CLHPresentationController.m
//  wechats
//
//  Created by AnICoo1 on 2017/3/11.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHPresentationController.h"

@implementation CLHPresentationController

- (void)containerViewWillLayoutSubviews{
    self.presentedView.frame = CGRectMake(200, 65, 200, 200);
    [self setUpCoverView];
}

- (void)setUpCoverView{
    UIView *coverView = [[UIView alloc] init];
    
    // 1.添加蒙版
    [self.containerView insertSubview:coverView atIndex:0];
    // 2.设置蒙版的属性
    coverView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    coverView.frame = self.containerView.bounds;
    
    // 3.添加手势
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [coverView addGestureRecognizer:tapGes];
}

- (void)back{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
