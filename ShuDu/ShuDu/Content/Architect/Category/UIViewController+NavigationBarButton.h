//
//  UIViewController+NavigationBarButton.h
//  CourseStudy-Master
//
//  Created by 邵帅 on 2017/8/18.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationBarButton)

- (void)addCommonBackButton;
- (void)addCommonBackButton:(NSString *)backTitle;
- (void)back;
- (void)addLeftBarItem:(UIImage *)image target:(id)target action:(SEL)action;
- (void)addRightBarItem:(UIImage *)image target:(id)target action:(SEL)action;

@end
