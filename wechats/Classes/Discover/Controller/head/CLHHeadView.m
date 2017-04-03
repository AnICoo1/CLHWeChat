//
//  CLHHeadView.m
//  wechats
//
//  Created by AnICoo1 on 17/2/26.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHHeadView.h"

@implementation CLHHeadView
{
    UIImageView *_bgImageView;
    UIImageView *_userImageView;
    UILabel *_nameLabel;
    UIImageView *_refreshImageView;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setUpAll];
    }
    return self;
}

- (void)setUpAll{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(friendSpaceRefresh) name:@"FriendSpaceRefreshNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(friendSpaceEndRefresh) name:@"FriendSpaceEndRefreshNotification" object:nil];
    
    _bgImageView = ({
        UIImage *image = [UIImage imageNamed:@"cover"];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenW * image.size.height / image.size.width)];
        imageV.image = image;
        imageV;
    });
    
    self.height = _bgImageView.height + 35;
    
    _userImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"26"]];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:18];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.text = @"AnICoo1";
    
    
    _refreshImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AlbumReflashIcon"]];
    _refreshImageView.hidden = YES;
    
    [self addSubview:_bgImageView];
    [self addSubview:_userImageView];
    [self addSubview:_nameLabel];
    [self addSubview:_refreshImageView];
    
    _userImageView.sd_layout
    .rightSpaceToView(self, 20)
    .bottomSpaceToView(self, 0)
    .widthIs(70)
    .heightIs(70);
    
    _nameLabel.sd_layout
    .rightSpaceToView(_userImageView, 5)
    .bottomSpaceToView(self, 45)
    .widthIs(80)
    .heightIs(18);

    _refreshImageView.sd_layout
    .leftSpaceToView(self, 10)
    .topSpaceToView(self, 64)
    .widthIs(30)
    .heightIs(30);
}

- (void)friendSpaceRefresh{
    _refreshImageView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _refreshImageView.transform = CGAffineTransformRotate(_refreshImageView.transform, M_PI );
    }];
}

- (void)friendSpaceEndRefresh{
    _refreshImageView.hidden = YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
