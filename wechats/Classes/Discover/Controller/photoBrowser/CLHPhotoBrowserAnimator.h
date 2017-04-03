//
//  CLHPhotoBrowserAnimator.h
//  wechats
//
//  Created by AnICoo1 on 2017/3/23.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol photoBrowserAnimatorDelegate <NSObject>

//弹出图片
- (CGRect)startRect:(NSInteger)index;
- (CGRect)endRect:(NSInteger)index;
- (UIImageView *)locImageView:(NSInteger)index;

@end

@protocol photoBrowserAnimatorDismissDelegate <NSObject>

//消失图片
- (NSInteger)indexForDismissView;
- (UIImageView *)imageViewForDismissView;

@end

@interface CLHPhotoBrowserAnimator : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) id<photoBrowserAnimatorDelegate> animationDelegate;

@property (nonatomic, weak) id<photoBrowserAnimatorDismissDelegate> animationDismissDelegate;

@property (nonatomic, assign) NSInteger index;

@end
