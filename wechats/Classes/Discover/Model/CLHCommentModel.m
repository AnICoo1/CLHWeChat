//
//  CLHCommentModel.m
//  wechats
//
//  Created by AnICoo1 on 17/2/25.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHCommentModel.h"

@implementation CLHCommentModel



+ (instancetype)commentModelWithName:(NSString *)name andText:(NSString *)text{
    CLHCommentModel *comment = [[CLHCommentModel alloc] init];
    comment.name = name;
    comment.text = text;
    return comment;
}

@end
