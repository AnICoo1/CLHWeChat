//
//  CLHFriendCircleModel.m
//  wechats
//
//  Created by AnICoo1 on 17/2/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHFriendCircleModel.h"

extern const CGFloat contentLabelFontSize;
extern CGFloat maxContentLabelHeight;

@implementation CLHFriendCircleModel
{
    CGFloat _lastContentWidth;
}

- (NSString *)contentText{
    
    CGFloat contentW = screenW - 70;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGRect textRect = [_contentText boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentLabelFontSize]} context:nil];
        if (textRect.size.height > maxContentLabelHeight) {
            _shouldOpen = YES;
        } else {
            _shouldOpen = NO;
        }
    }
    return _contentText;
}

- (void)setOpen:(BOOL)open{
    if(_shouldOpen){
        _open = open;
    }else{
        open = NO;
    }
}
@end
