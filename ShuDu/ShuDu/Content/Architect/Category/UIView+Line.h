//
//  UIView+Line.h
//  CourseStudy-Master
//
//  Created by 邵帅 on 2017/8/1.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, SSLinePosition) {
    SSLinePositionAll       = 0,
    SSLinePositionLeft      = 1 << 0,
    SSLinePositionTop       = 1 << 1,
    SSLinePositionRight     = 1 << 2,
    SSLinePositionBottom    = 1 << 3
};

@interface UIView (Line)

- (void)showLine:(SSLinePosition)position;
- (void)showLine:(SSLinePosition)position lineWidth:(CGFloat)width;
- (void)showLine:(SSLinePosition)position lineColor:(UIColor *)color;
- (void)showLine:(SSLinePosition)position lineColor:(UIColor *)color lineWidth:(CGFloat)width;

@end
