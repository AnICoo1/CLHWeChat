//
//  CLHDiscoverViewController.m
//  wechats
//
//  Created by AnICoo1 on 17/2/21.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHDiscoverViewController.h"
#import "CLHFriendSpaceViewController.h"
#import "CLHWebViewController.h"
#import "CLHShakeOffViewController.h"

@interface CLHDiscoverViewController () <UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray *nameArray;

@property(nonatomic, strong) NSMutableArray *imageArray;


@end


@implementation CLHDiscoverViewController

#pragma mark - 懒加载

- (NSMutableArray *)nameArray{
    if(!_nameArray){
        _nameArray = [NSMutableArray array];
        //第一组
        NSArray *arr1 = [NSArray arrayWithObjects:@"朋友圈", nil];
        [_nameArray addObject:arr1];
        NSArray *arr2 = [NSArray arrayWithObjects:@"扫一扫",@"摇一摇", nil];
        [_nameArray addObject:arr2];
        NSArray *arr3 = [NSArray arrayWithObjects:@"附近的人",@"漂流瓶", nil];
        [_nameArray addObject:arr3];
        NSArray *arr4 = [NSArray arrayWithObjects:@"购物",@"游戏", nil];
        [_nameArray addObject:arr4];
    }
    return _nameArray;
}

- (NSMutableArray *)imageArray{
    if(!_imageArray){
        _imageArray = [NSMutableArray array];
        NSArray *arr1 = [NSArray arrayWithObjects:@"ff_IconShowAlbum", nil];
        [_imageArray addObject:arr1];
        NSArray *arr2 = [NSArray arrayWithObjects:@"ff_IconQRCode",@"ff_IconShake", nil];
        [_imageArray addObject:arr2];
        NSArray *arr3 = [NSArray arrayWithObjects:@"ff_IconLocationService",@"ff_IconBottle", nil];
        [_imageArray addObject:arr3];
        NSArray *arr4 = [NSArray arrayWithObjects:@"found_shop",@"MoreGame", nil];
        [_imageArray addObject:arr4];
    }
    return _imageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发现";
    
    [self setUpTableView];
    
    
    
}

- (void)setUpTableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0 && indexPath.row == 0){//朋友圈
        CLHFriendSpaceViewController *friendSpaceVC = [[CLHFriendSpaceViewController alloc] init];
        [self.navigationController pushViewController:friendSpaceVC animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 1){//摇一摇
        CLHShakeOffViewController *shakeVC = [[CLHShakeOffViewController alloc] init];
        [self.navigationController pushViewController:shakeVC animated:YES];
        
    } else if(indexPath.section == 3 && indexPath.row == 0){//购物
        CLHWebViewController *webVC = [[CLHWebViewController alloc] init];
        webVC.url = @"http://www.taobao.com/";
        [self.navigationController pushViewController:webVC animated:YES];
    } else if(indexPath.section == 3 && indexPath.row == 1){//游戏
        CLHWebViewController *webVC = [[CLHWebViewController alloc] init];
        webVC.url = @"http://www.4399.com/";
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    } else{
       return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = self.nameArray[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"   ";
}

@end
