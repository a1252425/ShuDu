//
//  SDHomeViewController.m
//  ShuDu
//
//  Created by 邵帅 on 2017/11/17.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDHomeViewController.h"
#import "SDFileManager.h"

@interface SDHomeViewController ()

@end

@implementation SDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
//    [[SDFileManager sharedInstance] component:[[SDFileManager sharedInstance] rootComponent] addFile:[[NSBundle mainBundle] pathForResource:@"火影" ofType:@"txt"] error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
