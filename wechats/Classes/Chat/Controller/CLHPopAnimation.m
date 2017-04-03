//
//  CLHPopAnimation.m
//  wechats
//
//  Created by AnICoo1 on 2017/3/11.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHPopAnimation.h"
#import "CLHPresentationController.h"

@interface CLHPopAnimation () 

@end

@implementation CLHPopAnimation

    

    
//自定义动画
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}
    
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.isPresented ? [self animationForPresentedView:transitionContext] : [self animationForDismissView:transitionContext];
}
//弹出动画
- (void)animationForPresentedView:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *presentedView = [transitionContext viewForKey:UITransitionContextToViewKey];
    // 将弹出的View添加到containerView中
    [transitionContext.containerView addSubview:presentedView];
    // 执行动画
    presentedView.transform = CGAffineTransformMakeScale(1.0, 0);
    //设置锚点
    presentedView.layer.anchorPoint = CGPointMake(0.5, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]  animations:^{
        presentedView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
}

- (void)animationForDismissView:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *dismissView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//    [transitionContext.containerView addSubview:dismissView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        dismissView.transform = CGAffineTransformMakeScale(1.0, 0.00001);
    } completion:^(BOOL finished) {
        [dismissView removeFromSuperview];
        //告诉上下文动画完成
        [transitionContext completeTransition:YES];
    }];
    
    

}



    
@end
