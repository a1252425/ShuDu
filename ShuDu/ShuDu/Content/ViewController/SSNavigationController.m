//
//  SSNavigationController.m
//  ShuDu
//
//  Created by 邵帅 on 2017/11/17.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SSNavigationController.h"

@interface SSNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation SSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.tintColor = kDarkColor;
    self.navigationBar.barTintColor = kNormalColor;
    
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

@end
