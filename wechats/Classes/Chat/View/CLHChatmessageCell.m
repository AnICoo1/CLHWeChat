//
//  CLHChatmessageCell.m
//  wechats
//
//  Created by AnICoo1 on 17/2/22.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHChatmessageCell.h"
#import "CLHMessage.h"
#import "CLHFriendInfomation.h"


@interface CLHChatmessageCell ()

@property (strong, nonatomic)  UIImageView *userImageView;
@property (strong, nonatomic)  UILabel *userTextLabel;
@property(strong, nonatomic) UIImageView *chatBackground;

@property (nonatomic, strong) NSMutableArray *emojiArray;

@end


@implementation CLHChatmessageCell

#pragma mark - 懒加载

- (NSMutableArray *)emojiArray{
    
    if(!_emojiArray){
        _emojiArray = [NSMutableArray array];
    }
    return _emojiArray;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.userImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.userImageView];
        
        self.chatBackground = [[UIImageView alloc] init];
        [self.contentView addSubview:self.chatBackground];
        
        self.userTextLabel = [[UILabel alloc] init];
        self.userTextLabel.numberOfLines = 0;
        self.userTextLabel.font = [UIFont systemFontOfSize:17.0f];
        [self.chatBackground addSubview:self.userTextLabel];
        
    }
    return self;
}


- (void)refreshCell:(CLHMessage *)message{
    [self.emojiArray removeAllObjects];
    //self.rightUserTextLabel.autoresizingMask = UIViewAutoresizingNone;
    // 计算文本宽度和高度
    CGRect rec = [message.messageText boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    CGRect userFrame = CGRectZero;
    CGRect chatBackgroundFrame = CGRectZero;
    UIImage *backgroudImage = nil;
    if(message.isYouself){
        userFrame = CGRectMake(self.width - 5 - 50, 5, 50, 50);
        chatBackgroundFrame = CGRectMake(self.width - 10 - 50 - rec.size.width - 20, 10, rec.size.width + 20, rec.size.height + 20);
        self.userImageView.image = [[UIImage imageNamed:self.friendInfo.meIcon] circleImage];
        backgroudImage = [UIImage imageNamed:@"SenderTextNodeBkg"];
    } else{
        userFrame = CGRectMake(5, 5, 50, 50);
        chatBackgroundFrame = CGRectMake(10 + 50, 10, rec.size.width + 20, rec.size.height + 20);
        self.userImageView.image = [[UIImage imageNamed:self.friendInfo.friendIcon] circleImage];
        backgroudImage = [UIImage imageNamed:@"ReceiverTextNodeBkgHL"];
    }
   // backgroudImage = [backgroudImage stretchableImageWithLeftCapWidth:backgroudImage.size.width / 2 topCapHeight:backgroudImage.size.height / 2];
    backgroudImage = [backgroudImage resizableImageWithCapInsets:UIEdgeInsetsMake(backgroudImage.size.height / 2 - 1, backgroudImage.size.width / 2 - 1, backgroudImage.size.height / 2 - 1, backgroudImage.size.width / 2 - 1)];
    
    self.userImageView.frame = userFrame;
    self.chatBackground.frame = chatBackgroundFrame;
    self.chatBackground.image = backgroudImage;
    
    self.userTextLabel.frame = CGRectMake(message.isYouself ? 11 : 11, 5, rec.size.width, rec.size.height);
    //self.userTextLabel.contentEdgeInsets = UIEdgeInsetsMake(TEXT_INSET, TEXT_INSET, TEXT_INSET, TEXT_INSET);
    self.userTextLabel.attributedText = [self attributedString:message.messageText];
    
}


- (NSAttributedString *)attributedString:(NSString *)text{
    //正则表达式
    NSString *emojiRegex = @"\\[[^\\[\\]]*\\]";
    //根据正则表达式生成的限制
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:emojiRegex options:NSRegularExpressionCaseInsensitive error:nil];
    //将符合的结果范围存入数组
    NSArray *result = [re matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    
    for (NSInteger i = 0; i  < result.count; ++i) {
        //判断匹配的范围
        NSTextCheckingResult *resu = result[i];
        NSRange range =  [resu range];
        //生成字典
        NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
        //截取范围内的字符串
        NSString *subStr = [text substringWithRange:range];
        //生成富文本
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        NSString *str = [subStr substringWithRange:NSMakeRange(1, subStr.length - 2)];
        attch.image = [UIImage imageNamed:str];
        attch.bounds = CGRectMake(0, 0, 32, 32);
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        //将需要的属性加入字典
        [imageDic setObject:imageStr forKey:@"image"];
        [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
        [self.emojiArray addObject:imageDic];
    }
    //初始化可变富文本
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    for (NSInteger i = self.emojiArray.count - 1; i >= 0; i--) {
        NSDictionary *dic = self.emojiArray[i];
        NSRange range = [dic[@"range"] rangeValue];
        //替换表情
        [attributeString replaceCharactersInRange:range withAttributedString:dic[@"image"]];
    }
    return attributeString;
}

@end
