//
//  CLHCommentModel.h
//  wechats
//
//  Created by AnICoo1 on 17/2/25.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLHCommentModel : NSObject
//评论人
@property (nonatomic,copy) NSString *name;
//评论内容
@property (nonatomic,copy) NSString *text;

@property (nonatomic, copy) NSAttributedString *attributedContent;



+ (instancetype)commentModelWithName:(NSString *)name andText:(NSString *)text;
@end
