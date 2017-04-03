//
//  CLHPopViewController.m
//  wechats
//
//  Created by AnICoo1 on 2017/3/11.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHPopViewController.h"
#import "CLHPresentationController.h"
#import "CLHPopAnimation.h"

@interface CLHPopViewController () <UIViewControllerTransitioningDelegate>

@end


@implementation CLHPopViewController

- (instancetype)init{
    if(self = [super init]){
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.view.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [[CLHPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

    

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    CLHPopAnimation *animation = [[CLHPopAnimation alloc] init];
    animation.presented = YES;
    return animation;
}
    
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    CLHPopAnimation *animation = [[CLHPopAnimation alloc] init];
    animation.presented = NO;
    return animation;
}

    
@end
