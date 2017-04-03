//
//  CLHMeViewController.m
//  wechats
//
//  Created by AnICoo1 on 17/2/21.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHMeViewController.h"

@interface CLHMeViewController () <UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray *nameArray;

@property(nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation CLHMeViewController

#pragma mark - 懒加载

- (NSMutableArray *)nameArray{
    if(!_nameArray){
        _nameArray = [NSMutableArray array];
        //第一组
        NSArray *arr1 = [NSArray arrayWithObjects:@"AnICoo1", nil];
        [_nameArray addObject:arr1];
        
        NSArray *arr2 = [NSArray arrayWithObjects:@"相册",@"收藏", nil];
        [_nameArray addObject:arr2];
        
        NSArray *arr3 = [NSArray arrayWithObjects:@"钱包",@"卡包", nil];
        [_nameArray addObject:arr3];
        
        NSArray *arr4 = [NSArray arrayWithObjects:@"表情", nil];
        [_nameArray addObject:arr4];
        
        NSArray *arr5 = [NSArray arrayWithObjects:@"设置", nil];
        [_nameArray addObject:arr5];
    }
    return _nameArray;
}

- (NSMutableArray *)imageArray{
    if(!_imageArray){
        _imageArray = [NSMutableArray array];
        NSArray *arr1 = [NSArray arrayWithObjects:@"26", nil];
        [_imageArray addObject:arr1];
        
        NSArray *arr2 = [NSArray arrayWithObjects:@"MoreMyAlbum",@"MoreMyFavorites", nil];
        [_imageArray addObject:arr2];
        
        NSArray *arr3 = [NSArray arrayWithObjects:@"MoreMyBankCard",@"MyCardPackageIcon", nil];
        [_imageArray addObject:arr3];
        
        NSArray *arr4 = [NSArray arrayWithObjects:@"MoreExpressionShops", nil];
        [_imageArray addObject:arr4];
        
        NSArray *arr5 = [NSArray arrayWithObjects:@"MoreSetting", nil];
        [_imageArray addObject:arr5];
    }
    return _imageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0){
        return 80;
    }
    return 40;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0 || section == 3 || section == 4){
        return 1;
    } else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if(indexPath.section == 0 && indexPath.row == 0){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"meID"];
        cell.textLabel.text = self.nameArray[indexPath.section][indexPath.row];
        //设置标题和副标题
        cell.detailTextLabel.text = @"微信号:AnICoo1";
        cell.detailTextLabel.textColor = [UIColor grayColor];
        
        //重绘cell的imageView的image
        UIImage *image = [UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
        CGSize itemSize = CGSizeMake(70, 70);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO ,0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return cell;
    } else{
        cell = [[UITableViewCell alloc] init];
    }
    cell.textLabel.text = self.nameArray[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"   ";
}

@end
