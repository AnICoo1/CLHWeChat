//
//  CLHFriendSpaceViewController.m
//  wechats
//
//  Created by AnICoo1 on 17/2/23.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

/*
 
 尚未实现: 1.点赞和评论功能✅(点赞功能实现)
          2.点击图片查看功能  ✅
          3.顶部刷新和底部刷新 ✅ (顶部刷新可能存在小问题)
          4.界面逻辑细节(点击tableView取消各种弹窗)✅
 
 */
#import "CLHFriendSpaceViewController.h"
#import "MJRefresh.h"

#import "CLHFriendCircleModel.h"
#import "CLHFriendCircleCell.h"
#import "CLHLikeModel.h"
#import "CLHCommentModel.h"
#import "CLHHeadView.h"
#import <SVProgressHUD.h>

@interface CLHFriendSpaceViewController () <UITableViewDelegate, CLHFriendCircleCellDelegate, UITextFieldDelegate>


@property(nonatomic, strong) NSMutableArray *friendItems;

@end

static NSString * const friendSpaceID = @"friendSpace";

@implementation CLHFriendSpaceViewController

- (NSMutableArray *)friendItems{
    if(!_friendItems){
        _friendItems = [NSMutableArray array];
        CLHFriendCircleModel *item = ({
            CLHFriendCircleModel *item = [[CLHFriendCircleModel alloc] init];
            item.name = @"hello";
            item.iconName = @"26";
            item.contentText = @"hello everone,\n this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a test";
            item.photoNamesArray = [NSArray arrayWithObjects:@"1", @"2", @"yunmo", @"19", nil];
            
            CLHLikeModel *like = [[CLHLikeModel alloc] init];
            like.name = @"no.1";
            CLHLikeModel *like1= [[CLHLikeModel alloc] init];
            like1.name = @"gaiwiahahtuiahitahtiuaghitiagwiutiwu";
            CLHLikeModel *like2 = [[CLHLikeModel alloc] init];
            like2.name = @"AnICoqtTwtewrwQErqro1";
            
            CLHCommentModel *comment = [[CLHCommentModel alloc] init];
            comment.name = @"AnICoo1";
            comment.text = @"this is a test";
            CLHCommentModel *comment2 = [[CLHCommentModel alloc] init];
            comment2.name = @"AnICoo2";
            comment2.text = @"this is a test too";
            
            item.commentArray = [NSMutableArray arrayWithObjects:comment, comment2, nil];
            item.likeArray = [NSMutableArray arrayWithObjects:like,like1, like2, nil];
            item.like = NO;
            item;
        });
        CLHFriendCircleModel *item2 = ({
            CLHFriendCircleModel *item = [[CLHFriendCircleModel alloc] init];
            item.name = @"hello";
            item.iconName = @"26";
            item.contentText = @"hello everone,\n this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a test";
            item.photoNamesArray = [NSArray arrayWithObjects:@"4", @"9", @"2", @"6", nil];
            
            CLHLikeModel *like = [[CLHLikeModel alloc] init];
            like.name = @"no.1";
            CLHLikeModel *like1= [[CLHLikeModel alloc] init];
            like1.name = @"gaiwiahahtuiahitahtiuaghitiagwiutiwu";
            CLHLikeModel *like2 = [[CLHLikeModel alloc] init];
            like2.name = @"AnICoqtTwtewrwQErqro1";
            
            CLHCommentModel *comment = [[CLHCommentModel alloc] init];
            comment.name = @"AnICoo1";
            comment.text = @"this is a test";
            CLHCommentModel *comment2 = [[CLHCommentModel alloc] init];
            comment2.name = @"AnICoo2";
            comment2.text = @"this is a test too";
            
            item.commentArray = [NSMutableArray arrayWithObjects:comment, comment2, nil];
            item.likeArray = [NSMutableArray arrayWithObjects:like,like1, like2, nil];
            item.like = NO;
            item;
        });
        CLHFriendCircleModel *item3 = ({
            CLHFriendCircleModel *item = [[CLHFriendCircleModel alloc] init];
            item.name = @"hello";
            item.iconName = @"26";
            item.contentText = @"hello everone,\n this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a testhello everone, this is a test";
            item.photoNamesArray = [NSArray arrayWithObjects:@"24", @"12", @"22", @"16", nil];
            
            CLHLikeModel *like = [[CLHLikeModel alloc] init];
            like.name = @"no.1";
            CLHLikeModel *like1= [[CLHLikeModel alloc] init];
            like1.name = @"gaiwiahahtuiahitahtiuaghitiagwiutiwu";
            CLHLikeModel *like2 = [[CLHLikeModel alloc] init];
            like2.name = @"AnICoqtTwtewrwQErqro1";
            
            CLHCommentModel *comment = [[CLHCommentModel alloc] init];
            comment.name = @"AnICoo1";
            comment.text = @"this is a test";
            CLHCommentModel *comment2 = [[CLHCommentModel alloc] init];
            comment2.name = @"AnICoo2";
            comment2.text = @"this is a test too";
            
            item.commentArray = [NSMutableArray arrayWithObjects:comment, comment2, nil];
            item.likeArray = [NSMutableArray arrayWithObjects:like,like1, like2, nil];
            item.like = NO;
            item;
        });

        [_friendItems addObject:item];
        [_friendItems addObject:item2];
        [_friendItems addObject:item3];

    }
    return _friendItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    // 注册键盘的通知hide or show
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(click:) name:@"tableViewDidClickNotification" object:nil];
}

#pragma mark - 监听事件

- (void)click:(NSNotification *)notification{
    [self.view endEditing:YES];
}

#pragma mark - 键盘监听
- (void)keyBoardShow:(NSNotification *)notification{
    CGRect rec = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 把我们整体的View往上移动
    CGRect tempRec = self.view.frame;
    tempRec.origin.y = - (rec.size.height);
    self.view.frame = tempRec;
    // 由于可见的界面缩小了，TableView也要跟着变化
    //self.tableView.y = - (rec.size.height);
    self.tableView.contentInset = UIEdgeInsetsMake(64 + rec.size.height, 0, 0, 0);
    //需要修改
    if(self.friendItems.count){
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.friendItems.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)keyboardHide:(NSNotification *)notification{
    self.view.frame = CGRectMake(0, 0, screenW, screenH);
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.tableView.contentOffset.y < 0){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FriendSpaceRefreshNotification" object:nil];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(self.tableView.contentOffset.y > 0) return;
    NSLog(@"上拉刷新了");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FriendSpaceEndRefreshNotification" object:nil];
}

#pragma mark - 初始化

- (void)setUpTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH - 64 ) style:UITableViewStylePlain];
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.delegate = self;
    tableV.dataSource = self;
    
    tableV.tableHeaderView = [[CLHHeadView alloc] init];
    
//    tableV.contentInset =UIEdgeInsetsMake(-100, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, 100);
    tableV.showsVerticalScrollIndicator = NO;
    
    tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreNew)];
    
    
    self.tableView = tableV;
    
    
    [tableV registerClass:[CLHFriendCircleCell class] forCellReuseIdentifier:friendSpaceID];
    
}

#pragma  mark - 监听方法
- (void)loadMoreNew{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showInfoWithStatus:@"没有更多数据了"];
        NSLog(@"上拉刷新了");
        [self.tableView.mj_footer endRefreshing];
    });
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id friendCircleModel = self.friendItems[indexPath.row];
    //自动计算cell高度
    return [self.tableView cellHeightForIndexPath:indexPath model:friendCircleModel keyPath:@"friendCircleModel" cellClass:[CLHFriendCircleCell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

#pragma mark - UITableViewDataSource

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friendItems.count;
}

- (CLHFriendCircleCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLHFriendCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:friendSpaceID ];
    cell.indexPath = indexPath;
    
    __weak typeof(self) weakSelf = self;
    //设置展开按钮
    if(!cell.openButtonClickedBlock){
        //设置展开按钮之后的行动block
        [cell setOpenButtonClickedBlock:^(NSIndexPath *indexPath) {
            CLHFriendCircleModel *friendCircleModel = weakSelf.friendItems[indexPath.row];
            friendCircleModel.open = !friendCircleModel.open;
            //刷新当前组
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        cell.delegate = self;
    }
    cell.friendCircleModel = self.friendItems[indexPath.row];
    return cell;
}

#pragma mark - CLHFriendCircleCellDelegate

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    CLHFriendCircleModel *model = self.friendItems[index.row];
    if(model.isLike){
        NSMutableArray *tempArray = model.likeArray;
        for(CLHLikeModel *like in tempArray){
            if([like.name isEqualToString:@"AnICoo1"]){
                [model.likeArray removeObject:like];
                break;
            }
        }
        model.like = NO;
    } else{
        [model.likeArray addObject:[CLHLikeModel likeModelWithName:@"AnICoo1"]];
        model.like = YES;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    });
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

//点击了评论按钮，键盘弹出
- (void)didClickCommentButtonInCell:(UITableViewCell *)cell{
    
}


@end
