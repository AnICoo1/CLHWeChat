//
//  CLHCommentView.m
//  wechats
//
//  Created by AnICoo1 on 17/2/25.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//


/*
 
 
 尚未完成：富文本链接属性
 
 
 
 */


#import "CLHCommentView.h"
#import "CLHFriendCircleModel.h"
#import "CLHLikeModel.h"
#import "CLHCommentModel.h"
#import "CLHBaseModel.h"

@implementation CLHCommentView
{
    UILabel *_likeLabel;
    UILabel *_commentLabel;
    CGFloat _Height;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setUpAll];
    }
    return self;
}

- (void)setUpAll{
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    
    _likeLabel = [[UILabel alloc] init];
    _likeLabel.font = [UIFont systemFontOfSize:14];
    _likeLabel.numberOfLines = 0;
    _likeLabel.isAttributedContent = YES;
    _likeLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    UIView *middleLine = [[UIView alloc] init];
    middleLine.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    
    _commentLabel = [[UILabel alloc] init];
    _commentLabel.font = [UIFont systemFontOfSize:14];
    _commentLabel.textColor = [UIColor blackColor];
    _commentLabel.numberOfLines = 0;
    _commentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    [self addSubview:_likeLabel];
    [self addSubview:middleLine];
    [self addSubview:_commentLabel];
    
    _likeLabel.sd_layout
    .topSpaceToView(self, 5)
    .leftSpaceToView(self, 5)
    .rightSpaceToView(self, 5)
    .autoHeightRatio(0);//不可少
     
    middleLine.sd_layout
    .topSpaceToView(_likeLabel, 5)
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .heightIs(1);
    
    _commentLabel.sd_layout
    .topSpaceToView(middleLine, 5)
    .leftSpaceToView(self, 5)
    .rightSpaceToView(self, 5)
    .autoHeightRatio(0);//不可少
    
}

- (void)setBaseModel:(CLHBaseModel *)baseModel{
    _baseModel = baseModel;
    
    if(baseModel.likeArray.count == 0 && baseModel.commentArray.count == 0){
        self.height = 0;
        self.fixedHeight = @(0);
        return ;
    }
    [self setLikeModel];
    [self setCommentModel];
    
    //当一个View使用SDAutoLayout的时候，如果其含有子控件且需要自适应高度，那么我们需要根据最底部的子控件来自动算出View高度.
    [self setupAutoHeightWithBottomView:_commentLabel bottomMargin:6];
    
}

- (void)setLikeModel{
    
    NSArray *likeArray = _baseModel.likeArray;
    
    //图文混排，添加开头的心形图片
    NSTextAttachment *attach = [NSTextAttachment new];
    attach.image = [UIImage imageNamed:@"Like"];
    attach.bounds = CGRectMake(0, -3, 16, 16);
    NSAttributedString *likeIcon = [NSAttributedString attributedStringWithAttachment:attach];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:likeIcon];
    
    for(NSInteger i = 0 ;i < likeArray.count;i++){
        CLHLikeModel *like = likeArray[i];
        if (i > 0) {
            [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"，"]];
        }
        if (!like.attributedContent) {
            like.attributedContent = [self generateAttributedStringWithLikeItemModel:like];
        }
        [attributedText appendAttributedString:like.attributedContent];
    }
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"觉得很赞。"]];
    
    _likeLabel.attributedText = attributedText;

}

/*
- (void)setLikeModel2{
    
    NSArray *likeArray = _baseModel.likeArray;
    
    NSString *text = @"~";
    for(NSInteger i = 0 ;i < likeArray.count;i++){
        CLHLikeModel *like = likeArray[i];
        if (i > 0) {
            text = [text stringByAppendingString:@"，"];
        }
        text = [text stringByAppendingString:like.name];
    }
    text = [text stringByAppendingString:@"觉得很赞。"];
    
    _likeLabel.text = text;
    CGRect rec = [_likeLabel.text boundingRectWithSize:CGSizeMake(self.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
    NSLog(@"be   %f",rec.size.height);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"af    %f",rec.size.height);
    });
    _Height += rec.size.height + 5;
    
}
*/

- (void)setCommentModel{
    NSArray *commentArray = _baseModel.commentArray;
    
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    for(NSInteger i = 0 ;i < _baseModel.commentArray.count;i++){
        if (i > 0) {
            [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n"]]];
        }
        CLHCommentModel *comment = commentArray[i];
        if (!comment.attributedContent) {
            comment.attributedContent = [self generateAttributedStringWithCommentItemModel:comment];
            //NSLog(@"%@",comment.name);
        }
        [attributedText appendAttributedString:comment.attributedContent];
        [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@":%@",comment.text]]];
        
    }
    _commentLabel.attributedText = attributedText;
}
/*
- (void)setCommentModel2{
    NSArray *commentArray = _baseModel.commentArray;
    NSString *text = @"";
    
    for(NSInteger i = 0 ;i < commentArray.count;i++){
        if (i > 0) {
            text = [text stringByAppendingString:@"\n"];
        }
        CLHCommentModel *comment = commentArray[i];
        text = [text stringByAppendingString:comment.name];
        text = [text stringByAppendingString:[NSString stringWithFormat:@":%@",comment.text]];
    }
    
    _commentLabel.text = text;
    CGRect rec = [_commentLabel.text boundingRectWithSize:CGSizeMake(self.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
    
    _Height += rec.size.height + 5;
}
*/
#pragma mark - label富文本设置
//点赞富文本
- (NSMutableAttributedString *)generateAttributedStringWithLikeItemModel:(CLHLikeModel *)model
{
    NSString *text = model.name;
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    UIColor *highLightColor = CLHRGBColor(92, 140, 193);
    [attString setAttributes:@{NSForegroundColorAttributeName : highLightColor,NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone)} range:[text rangeOfString:model.name]];
    return attString;
}
//评论富文本
- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(CLHCommentModel *)model
{
    NSString *text = model.name;
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    UIColor *highLightColor = CLHRGBColor(92, 140, 193);
    [attString setAttributes:@{NSForegroundColorAttributeName : highLightColor,NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone)} range:[text rangeOfString:model.name]];
    return attString;
}

@end
