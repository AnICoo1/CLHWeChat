//
//  CLHFriendCircleCell.m
//  wechats
//
//  Created by AnICoo1 on 17/2/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHFriendCircleCell.h"
#import "SDAutoLayout.h"

#import "CLHFriendCircleModel.h"
#import "CLHWerChatPhotoView.h"
#import "CLHLikeAndCommentView.h"
#import "CLHCommentView.h"
#import "CLHBaseModel.h"

//正文字体大小
const CGFloat contentLabelFontSize = 15;
//正文最大高度
CGFloat maxContentLabelHeight = 0;

@implementation CLHFriendCircleCell
{
    UIImageView *_iconView;
    UILabel *_nameLable;
    UILabel *_contentLabel;
    UIButton *_openOrCloseButton;
    CLHWerChatPhotoView *_photoView;
    UIButton *_commentButton;
    CLHLikeAndCommentView *_commentView;
    CLHCommentView *_otherCommentView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setUpAll];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpAll{
    
    //头像
    _iconView = [[UIImageView alloc] init];
    
    //昵称
    _nameLable = [[UILabel alloc] init];
    _nameLable.font = [UIFont systemFontOfSize:14];
    _nameLable.textColor = CLHRGBColor(54, 71, 121);
    
    //正文
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:contentLabelFontSize];
    _contentLabel.numberOfLines = 0;
    if (maxContentLabelHeight == 0) {
        maxContentLabelHeight = _contentLabel.font.lineHeight * 3;
    }
    //展开按钮
    _openOrCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_openOrCloseButton setTitle:@"全文" forState:UIControlStateNormal];
    [_openOrCloseButton setTitleColor:CLHRGBColor(92, 140, 193) forState:UIControlStateNormal];
    _openOrCloseButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_openOrCloseButton addTarget:self action:@selector(openButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //图片
    _photoView = [[CLHWerChatPhotoView alloc] init];
    
    //评论按钮
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentButton setBackgroundImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
    [_commentButton addTarget:self action:@selector(commentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //点赞评论界面
    _commentView = [[CLHLikeAndCommentView alloc] init];
    __weak typeof(self) weakSelf = self;
    [_commentView setLikeButtonClickBlock:^() {
        if([weakSelf.delegate respondsToSelector:@selector(didClickLikeButtonInCell:)]){
            [weakSelf.delegate didClickLikeButtonInCell:weakSelf];
        }
    }];
    [_commentView setCommentbuttonClickBlock:^{
        if([weakSelf.delegate respondsToSelector:@selector(didClickCommentButtonInCell:)]){
            [weakSelf.delegate didClickCommentButtonInCell:weakSelf];
        }
    }];
    //评论界面
    _otherCommentView = [[CLHCommentView alloc] init];
    
    //添加子控件
    [self.contentView addSubview:_iconView];
    [self.contentView addSubview:_nameLable];
    [self.contentView addSubview:_contentLabel];
    [self.contentView addSubview:_openOrCloseButton];
    [self.contentView addSubview:_photoView];
    [self.contentView addSubview:_commentButton];
    [self.contentView addSubview:_commentView];
    [self.contentView addSubview:_otherCommentView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewClick)];
    [self.contentView addGestureRecognizer:tap];
    //设置约束
    //头像
    _iconView.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 10)
    .widthIs(40)
    .heightIs(40);
    //昵称
    _nameLable.sd_layout
    .leftSpaceToView(_iconView, 10)
    .topSpaceToView(self.contentView, 10)
    .heightIs(18);
    //设置单行label最大宽度
    [_nameLable setSingleLineAutoResizeWithMaxWidth:200];
    //正文
    _contentLabel.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_nameLable, 10)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0);
    //展开按钮
    _openOrCloseButton.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentLabel, 0)
    .widthIs(30);
    //图片
    _photoView.sd_layout
    .leftEqualToView(_contentLabel);
    //评论按钮
    _commentButton.sd_layout
    .topSpaceToView(_photoView,5)
    .rightSpaceToView(self.contentView, 10)
    .widthIs(25)
    .heightIs(25);
    //点赞评论界面
    _commentView.sd_layout
    .topEqualToView(_commentButton)
    .rightSpaceToView(_commentButton, 0)
    .heightIs(36)
    .widthIs(0);
    //评论界面
    _otherCommentView.sd_layout
    .topSpaceToView(_commentButton, 10)
    .leftEqualToView(_contentLabel)
    .rightSpaceToView(self.contentView, 10);
}

- (void)setFriendCircleModel:(CLHFriendCircleModel *)friendCircleModel{
    _friendCircleModel = friendCircleModel;
    
    
    //设置数据
    _iconView.image = [UIImage imageNamed:friendCircleModel.iconName];
    _nameLable.text = friendCircleModel.name;
    _contentLabel.text = friendCircleModel.contentText;
    _photoView.photoArray = friendCircleModel.photoNamesArray;
    
    CLHBaseModel *baseModel = [[CLHBaseModel alloc] init];
    baseModel.likeArray = friendCircleModel.likeArray;
    baseModel.commentArray = friendCircleModel.commentArray;
    _otherCommentView.baseModel = baseModel;
    
    if(friendCircleModel.shouldOpen){//如果应该展开
        _openOrCloseButton.sd_layout.heightIs(20);
        _openOrCloseButton.hidden = NO;
        
        if(friendCircleModel.isOpen){//如果处于已打开
            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
            [_openOrCloseButton setTitle:@"收起" forState:UIControlStateNormal];
        } else{
            _contentLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
            [_openOrCloseButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    } else{
        _openOrCloseButton.sd_layout.heightIs(0);
        _openOrCloseButton.hidden = YES;
    }
    
    CGFloat topMargin = 0;
    if (friendCircleModel.photoNamesArray.count) {
        topMargin = 10;
    }
    _photoView.sd_layout.topSpaceToView(_openOrCloseButton, topMargin);
    //设置最底部的控件的自适应
    UIView *bottonView = _otherCommentView;
    
    [self setupAutoHeightWithBottomView:bottonView bottomMargin:15];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (_commentView.isShow) {
        _commentView.show = NO;
    }
}

#pragma mark - 监听事件

- (void)tableViewClick{
    _commentView.show = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tableViewDidClickNotification" object:nil];
}

#pragma mark - 按钮点击
- (void)openButtonClick:(UIButton *)button{
    if(self.openButtonClickedBlock){
        self.openButtonClickedBlock(self.indexPath);
    }
}

- (void)commentButtonClick:(UIButton *)button{
    _commentView.show = !_commentView.show;
    
}



@end
