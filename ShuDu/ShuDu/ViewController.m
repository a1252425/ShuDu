//
//  ViewController.m
//  ShuDu
//
//  Created by 邵帅 on 2017/11/17.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "ViewController.h"
#import "SDTabBarController.h"

@interface ViewController ()

@property (nonatomic, strong) SDTabBarController *tabBarController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tabBarController = [[SDTabBarController alloc] init];
    _tabBarController.view.frame = self.view.bounds;
    [self.view addSubview:_tabBarController.view];
    [self addChildViewController:_tabBarController];
}

@end
