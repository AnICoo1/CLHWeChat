//
//  CLHLikeAndCommentView.m
//  wechats
//
//  Created by AnICoo1 on 17/2/25.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHLikeAndCommentView.h"

@implementation CLHLikeAndCommentView
{
    UIButton *_likeButton;
    UIButton *_commentButton;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setUpButton];
    }
    return self;
}

- (void)setUpButton{
    self.clipsToBounds = YES;
    self.backgroundColor = CLHRGBColor(69, 74, 76);
    
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeButton setTitle:@"赞" forState:UIControlStateNormal];
    [_likeButton setImage:[UIImage imageNamed:@"AlbumLike"] forState:UIControlStateNormal];
    [_likeButton setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    _likeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_likeButton addTarget:self action:@selector(likeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentButton setTitle:@"评论" forState:UIControlStateNormal];
    [_commentButton setImage:[UIImage imageNamed:@"AlbumComment"] forState:UIControlStateNormal];
    [_commentButton setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    _commentButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_commentButton addTarget:self action:@selector(commentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *centerLine = [UIView new];
    centerLine.backgroundColor = [UIColor grayColor];
    
    [self addSubview:_likeButton];
    [self addSubview:_commentButton];
    [self addSubview:centerLine];
    
    _likeButton.sd_layout
    .leftSpaceToView(self, 5)
    .topEqualToView(self)
    .bottomEqualToView(self)
    .widthIs(80);
    
    centerLine.sd_layout
    .leftSpaceToView(_likeButton, 5)
    .topSpaceToView(self, 5)
    .bottomSpaceToView(self, 5)
    .widthIs(1);
    
    _commentButton.sd_layout
    .leftSpaceToView(centerLine, 5)
    .topEqualToView(_likeButton)
    .bottomEqualToView(_likeButton)
    .widthRatioToView(_likeButton, 1);
    
    
}


- (void)setShow:(BOOL)show{
    _show = show;
    [UIView animateWithDuration:0.2 animations:^{
        if(show){
            self.fixedWidth = nil;
            [self setupAutoWidthWithRightView:_commentButton rightMargin:5];
        } else{
            [self clearAutoWidthSettings];
            self.sd_layout
            .widthIs(0);
        }
        [self updateLayoutWithCellContentView:self.superview];
    }];
    
}

#pragma mark -点击按钮

- (void)likeButtonClick:(UIButton *)button{
    if(self.likeButtonClickBlock){
        self.likeButtonClickBlock();
    }
}

- (void)commentButtonClick:(UIButton *)button{
    if(self.commentbuttonClickBlock){
        self.commentbuttonClickBlock();
    }
}
@end
