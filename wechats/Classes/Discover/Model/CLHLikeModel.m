//
//  CLHLikeModel.m
//  wechats
//
//  Created by AnICoo1 on 17/2/25.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHLikeModel.h"

@implementation CLHLikeModel


+ (instancetype)likeModelWithName:(NSString *)name{
    CLHLikeModel *like = [[CLHLikeModel alloc] init];
    like.name = name;
    return like;
}

@end
