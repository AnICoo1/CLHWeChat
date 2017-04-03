//
//  CLHPopAnimation.h
//  wechats
//
//  Created by AnICoo1 on 2017/3/11.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLHPopAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, getter=isPresented) BOOL presented;
    
@end
