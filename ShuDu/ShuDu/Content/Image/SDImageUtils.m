//
//  SDImageUtils.m
//  SuperWatch
//
//  Created by 邵帅 on 2017/8/30.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDImageUtils.h"

@implementation SDImageUtils

+ (void)starPathContext:(CGContextRef)context R:(CGFloat)R {
    CGFloat L = R/sinf(0.7*M_PI)*sinf(0.2*M_PI);
    
    CGFloat SD = (L+L*sinf(0.1*M_PI))*2, sH = R+R*cosf(0.2*M_PI);
    CGSize doubleSize = CGSizeMake(SD+kSDImageDefaultLineWidth*2, sH+kSDImageDefaultLineWidth*2);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, kSDImageDefaultColor.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    CGPoint point1 = CGPointMake(SD/2+kSDImageDefaultLineWidth, kSDImageDefaultLineWidth);
    CGContextMoveToPoint(currentContext, point1.x, point1.y);
    
    CGPoint point2 = CGPointMake(SD/2+L*sinf(0.1*M_PI)+kSDImageDefaultLineWidth, L*cosf(0.1*M_PI)+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, point2.x, point2.y);
    
    CGPoint point3 = CGPointMake(SD+kSDImageDefaultLineWidth, L*cos(0.1*M_PI)+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, point3.x, point3.y);
    
    CGPoint point4 = CGPointMake(SD/2+R*cosf(0.1*M_PI)-L*cosf(0.2*M_PI)+kSDImageDefaultLineWidth, R+L*sinf(0.2*M_PI)-R*sinf(0.1*M_PI)+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, point4.x, point4.y);
    
    CGPoint point5 = CGPointMake(SD/2+R*sinf(0.2*M_PI)+kSDImageDefaultLineWidth, sH+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, point5.x, point5.y);
    
    CGPoint point6 = CGPointMake(SD/2+kSDImageDefaultLineWidth, R*cosf(0.2*M_PI)-L*sinf(0.2*M_PI)+R+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, point6.x, point6.y);
    
    CGPoint point7 = CGPointMake(SD/2-R*sinf(0.2*M_PI)+kSDImageDefaultLineWidth, sH+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, point7.x, point7.y);
    
    CGPoint point8 = CGPointMake(SD/2-(R*cosf(0.1*M_PI)-L*cosf(0.2*M_PI))+kSDImageDefaultLineWidth, L*sinf(0.2*M_PI)-R*sinf(0.1*M_PI)+R+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, point8.x, point8.y);
    
    CGPoint point9 = CGPointMake(kSDImageDefaultLineWidth, R-R*sinf(0.1*M_PI)+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, point9.x, point9.y);
    
    CGPoint point10 = CGPointMake(L+kSDImageDefaultLineWidth, L*cosf(0.1*M_PI)+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, point10.x, point10.y);
    
    CGContextClosePath(currentContext);
}

@end
