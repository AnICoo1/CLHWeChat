//
//  CLHChatViewController.m
//  wechats
//
//  Created by AnICoo1 on 17/2/21.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHChatViewController.h"
#import "CLHChatWithPersonViewController.h"
#import "CLHFriendInfomation.h"
#import "CLHPopViewController.h"




@interface CLHChatViewController () <UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray *nameArray;


@end

static NSString * const chatID = @"chat";

@implementation CLHChatViewController

#pragma mark - 懒加载

- (NSArray *)nameArray{
    if(!_nameArray){
        _nameArray = [NSMutableArray arrayWithObjects:@"乏味的人生ソ", @"爱与你同在", @"花花世界、浪荡人", @"放棄是最好的解脫", @"半樽寒月敬浮生", @"浮夸，乱了遍地流年", @"A bad boy", @"彼岸回忆", @"害怕听到答案",  @"青春败给了时间", nil];
    }
    return _nameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"最近会话";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"转场" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonClick)];
}

- (void)barButtonClick{
    CLHPopViewController *popVC = [[CLHPopViewController alloc] init];
    [self.navigationController presentViewController:popVC animated:YES completion:nil];
}
    
    
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLHFriendInfomation *friendInfo = [[CLHFriendInfomation alloc] init];
    friendInfo.friendIcon = [NSString stringWithFormat:@"%zd",indexPath.row + 1];
    friendInfo.meIcon = @"26";
    friendInfo.name = self.nameArray[indexPath.row];
    
    CLHChatWithPersonViewController *chatPersonVC = [[CLHChatWithPersonViewController alloc] init];
    chatPersonVC.friendInfo = friendInfo;
    [self.navigationController pushViewController:chatPersonVC animated:YES];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:chatID];
    //重绘cell的imageView的image
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd",indexPath.row + 1]];
    CGSize itemSize = CGSizeMake(50, 50);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO ,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //设置标题
    cell.textLabel.text = self.nameArray[indexPath.row];
    cell.detailTextLabel.text = @"这都是什么鬼!!!";
    cell.detailTextLabel.textColor = [UIColor grayColor];
    return cell;
}
@end
