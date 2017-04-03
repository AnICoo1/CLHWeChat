//
//  CLHChatmessageCell.h
//  wechats
//
//  Created by AnICoo1 on 17/2/22.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLHMessage,CLHFriendInfomation;
@interface CLHChatmessageCell : UITableViewCell

@property (nonatomic,strong) CLHFriendInfomation *friendInfo;
@property (nonatomic, strong) UIViewController *superVC;

- (void)refreshCell:(CLHMessage *)message;

@end
