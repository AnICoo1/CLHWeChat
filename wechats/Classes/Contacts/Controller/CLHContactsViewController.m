//
//  CLHContactsViewController.m
//  wechats
//
//  Created by AnICoo1 on 17/2/21.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHContactsViewController.h"
#import "MJExtension.h"

#import "CLHFriend.h"
#import "CLHFriendGroup.h"
#import "CLHFriendInfomation.h"
#import "CLHChatWithPersonViewController.h"


@interface CLHContactsViewController () <UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray *friendGroups;


@end


static NSString * const friendID = @"friend";

@implementation CLHContactsViewController

- (NSMutableArray *)friendGroups{
    if(!_friendGroups){
        
        //模型转换
        [CLHFriendGroup mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"friends" : [CLHFriend class]};
        }];
        
        _friendGroups = [CLHFriendGroup mj_objectArrayWithFilename:@"Friends.plist"];
    }
    return _friendGroups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"通讯录";
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:friendID];
    // 设置索引条的文字颜色
    self.tableView.sectionIndexColor = [UIColor blackColor];
    //设置索引条被点击后的背景颜色
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor lightGrayColor];
}

#pragma mark - UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    CLHFriendGroup *friendGroup = self.friendGroups[section];
    
    return (section && friendGroup.friends.count) ? friendGroup.title : nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //第一组的cell
    if(indexPath.section == 0) return;
    //将当前好友的信息(头像，昵称)传递给聊天控制器
    CLHFriendGroup *friendGroup = self.friendGroups[indexPath.section];
    CLHFriend *friend = friendGroup.friends[indexPath.row];
    
    CLHFriendInfomation *friendInfo = [[CLHFriendInfomation alloc] init];
    friendInfo.friendIcon = friend.icon;
    friendInfo.meIcon = @"26";
    friendInfo.name = friend.name;
    
    CLHChatWithPersonViewController *chatPersonVC = [[CLHChatWithPersonViewController alloc] init];
    chatPersonVC.friendInfo = friendInfo;
    [self.navigationController pushViewController:chatPersonVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.friendGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    CLHFriendGroup *friendGroup = self.friendGroups[section];
    return friendGroup.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:friendID forIndexPath:indexPath];
    CLHFriendGroup *friendGroup = self.friendGroups[indexPath.section];
    CLHFriend *friend = friendGroup.friends[indexPath.row];
    //重绘cell的imageView的image
    UIImage *image = [UIImage imageNamed:friend.icon];
    CGSize itemSize = CGSizeMake(30, 30);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO ,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.textLabel.text = friend.name;
    
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [self.friendGroups valueForKey:@"title"];
}

@end
