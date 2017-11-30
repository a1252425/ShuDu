//
//  SDTabBarController.m
//  ShuDu
//
//  Created by 邵帅 on 2017/11/17.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTabBarController.h"

#import "SSNavigationController.h"
#import "SDHomeViewController.h"
#import "SDTransferViewController.h"
#import "SDSettingViewController.h"

#import "SDImage.h"

@interface SDTabBarController ()

@end

@implementation SDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray<NSString *> *titles = @[SD(@"舒读"), SD(@"传输"), SD(@"设置")];
    
    SDHomeViewController *homeViewController = [[SDHomeViewController alloc] init];
    SSNavigationController *homeController = [[SSNavigationController alloc] initWithRootViewController:homeViewController];
    homeController.tabBarItem = [[UITabBarItem alloc] initWithTitle:titles[0] image:[SDImage root_tab_bar_item0] tag:0];
    
    SDTransferViewController *transferViewController = [[SDTransferViewController alloc] init];
    SSNavigationController *transferController = [[SSNavigationController alloc] initWithRootViewController:transferViewController];
    transferController.tabBarItem = [[UITabBarItem alloc] initWithTitle:titles[1] image:[SDImage root_tab_bar_item0] tag:1];
    
    SDSettingViewController *settingViewController = [[SDSettingViewController alloc] init];
    SSNavigationController *settingController = [[SSNavigationController alloc] initWithRootViewController:settingViewController];
    settingController.tabBarItem = [[UITabBarItem alloc] initWithTitle:titles[2] image:[SDImage root_tab_bar_item0] tag:2];
    
    self.viewControllers = @[homeController, transferController, settingController];
    
    self.tabBar.tintColor = kDarkColor;
    self.tabBar.barTintColor = kNormalColor;
}

@end
