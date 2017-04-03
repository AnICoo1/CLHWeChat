//
//  CLHTabBarViewController.m
//  wechats
//
//  Created by AnICoo1 on 17/2/21.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHTabBarViewController.h"


#import "CLHChatViewController.h"
#import "CLHContactsViewController.h"
#import "CLHDiscoverViewController.h"
#import "CLHMeViewController.h"
#import "CLHNavigationController.h"

@interface CLHTabBarViewController ()

@end

@implementation CLHTabBarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化子控制器
    [self setUpChildViewController];
    //设置子控制器对应的图标
    [self setUpTitleAndImageOfChildViewController];
    
    self.tabBar.tintColor = CLHRGBColor(9, 187, 7);
    
}

- (void)setUpChildViewController{
    //微信
    CLHChatViewController *chatVC = [[CLHChatViewController alloc] init];
    CLHNavigationController *nav = [[CLHNavigationController alloc] initWithRootViewController:chatVC];
    [self addChildViewController:nav];
    //通讯录
    CLHContactsViewController *contactsVC = [[CLHContactsViewController alloc] init];
    CLHNavigationController *nav1 = [[CLHNavigationController alloc] initWithRootViewController:contactsVC];
    [self addChildViewController:nav1];
    //发现
    CLHDiscoverViewController *discoverVC = [[CLHDiscoverViewController alloc] init];
    CLHNavigationController *nav2 = [[CLHNavigationController alloc] initWithRootViewController:discoverVC];
    [self addChildViewController:nav2];
    //我
    CLHMeViewController *meVC = [[CLHMeViewController alloc] init];
    CLHNavigationController *nav3 = [[CLHNavigationController alloc] initWithRootViewController:meVC];
    [self addChildViewController:nav3];
}

- (void)setUpTitleAndImageOfChildViewController{
    //微信
    CLHNavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"微信";
    nav.tabBarItem.image = [UIImage renderOrigenImageWithImageName:@"tabbar_mainframe"];
    nav.tabBarItem.selectedImage = [UIImage renderOrigenImageWithImageName:@"tabbar_mainframeHL"];
    //通讯录
    CLHNavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"通讯录";
    nav1.tabBarItem.image = [UIImage renderOrigenImageWithImageName:@"tabbar_contacts"];
    nav1.tabBarItem.selectedImage = [UIImage renderOrigenImageWithImageName:@"tabbar_contactsHL"];
    //发现
    CLHNavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"发现";
    nav2.tabBarItem.image = [UIImage renderOrigenImageWithImageName:@"tabbar_discover"];
    nav2.tabBarItem.selectedImage = [UIImage renderOrigenImageWithImageName:@"tabbar_discoverHL"];
    //我
    CLHNavigationController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"我";
    nav3.tabBarItem.image = [UIImage renderOrigenImageWithImageName:@"tabbar_me"];
    nav3.tabBarItem.selectedImage = [UIImage renderOrigenImageWithImageName:@"tabbar_meHL"];
    
}

@end
