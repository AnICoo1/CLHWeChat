//
//  CLHLikeAndCommentView.h
//  wechats
//
//  Created by AnICoo1 on 17/2/25.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLHLikeAndCommentView : UIView

@property (nonatomic,assign,getter=isShow) BOOL show;

@property (nonatomic, copy) void (^likeButtonClickBlock)();

@property (nonatomic, copy) void (^commentbuttonClickBlock)();
@end
