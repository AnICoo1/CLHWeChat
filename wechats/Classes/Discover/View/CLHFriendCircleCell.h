//
//  CLHFriendCircleCell.h
//  wechats
//
//  Created by AnICoo1 on 17/2/24.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CLHFriendCircleCellDelegate <NSObject>

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell;

- (void)didClickCommentButtonInCell:(UITableViewCell *)cell;

@end

@class CLHFriendCircleModel;
@interface CLHFriendCircleCell : UITableViewCell

//当前cell位置
@property (nonatomic, strong) NSIndexPath *indexPath;
//传递点击了全文按钮block
@property (nonatomic, copy) void (^openButtonClickedBlock)(NSIndexPath *indexPath);
//模型数据
@property (nonatomic,strong) CLHFriendCircleModel *friendCircleModel;

@property(nonatomic, weak) id<CLHFriendCircleCellDelegate> delegate;

@end
