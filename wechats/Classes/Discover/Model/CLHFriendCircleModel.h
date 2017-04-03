//
//  CLHFriendCircleModel.h
//  wechats
//
//  Created by AnICoo1 on 17/2/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLHLikeModel,CLHCommentModel;
//cell模型
@interface CLHFriendCircleModel : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic,copy) NSString *contentText;
@property (nonatomic,assign, getter=isOpen) BOOL open;
@property (nonatomic,assign, getter=isShouldOpen) BOOL shouldOpen;
@property (nonatomic, strong) NSArray *photoNamesArray;

@property (nonatomic, assign, getter=isLike) BOOL like;

@property (nonatomic,strong) NSMutableArray <CLHLikeModel *>*likeArray;
@property (nonatomic,strong) NSMutableArray <CLHCommentModel *> *commentArray;



@end



