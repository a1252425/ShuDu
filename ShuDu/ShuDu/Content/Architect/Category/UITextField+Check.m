//
//  UITextField+Check.m
//  SuperWatch
//
//  Created by 邵帅 on 2017/8/25.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "UITextField+Check.h"

@implementation UITextField (Check)

- (void)emptyShake {
    CGPoint center = self.center;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(center.x - 4, center.y)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(center.x + 3, center.y)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(center.x - 2, center.y)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(center.x + 1, center.y)];
    animation.values = @[value1, value2, value3, value4];
    animation.duration = 0.4;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:@"kEmptyShake"];
}

@end
