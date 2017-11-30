//
//  SDImage.m
//  SuperWatch
//
//  Created by 邵帅 on 2017/8/22.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDImage.h"
#import "SDImageStorage.h"
#import "SDImageUtils.h"

@implementation SDImage

#pragma mark -- root_tab_bar_item --

+ (UIImage *)root_tab_bar_item0 {
    NSString *imageName = @"root_tab_bar_item0";
    NSData *imageData = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (imageData) {
        return [UIImage imageWithData:imageData scale:kSDImageScale];
    }
    
    CGFloat SD = 30, sH = 30;
    CGFloat allDat = 3;
    CGFloat width = 12, height = 15;//l:4 u: 6
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    UIColor *color = kSDImageDefaultColor;
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    CGFloat sX = (SD - width - allDat)/2, sY = (sH - height - allDat)/2;
    CGContextMoveToPoint(currentContext, sX + width, sY + allDat);
    CGContextAddLineToPoint(currentContext, sX + width, sY);
    CGContextAddLineToPoint(currentContext, sX, sY);
    CGContextAddLineToPoint(currentContext, sX, sY + height);
    CGContextAddLineToPoint(currentContext, sX + allDat, sY + height);
    CGContextAddRect(currentContext, CGRectMake(sX + allDat, sY + allDat, width, height));
    
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)root_tab_bar_item1 {
    NSString *imageName = @"root_tab_bar_item1";
    NSData *imageData = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (imageData) {
        return [UIImage imageWithData:imageData scale:kSDImageScale];
    }
    
    CGFloat SD = 30, sH = 30;
    CGFloat allDat = 3.5;
    CGFloat r = 15;
    CGFloat cx = SD/2,cy = (sH - r)/2 + r;
    CGFloat angle = M_PI * 5 / 12;
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    UIColor *color = kSDImageDefaultColor;
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    CGContextAddArc(currentContext, cx, cy, r, M_PI * 3 / 2 - angle/2, M_PI * 3 / 2 + angle/2, NO);
    CGContextDrawPath(currentContext, kCGPathStroke);
    r -= allDat;
    CGContextAddArc(currentContext, cx, cy, r, M_PI * 3 / 2 - angle/2, M_PI * 3 / 2 + angle/2, NO);
    CGContextDrawPath(currentContext, kCGPathStroke);
    r -= allDat;
    CGContextAddArc(currentContext, cx, cy, r, M_PI * 3 / 2 - angle/2, M_PI * 3 / 2 + angle/2, NO);
    CGContextDrawPath(currentContext, kCGPathStroke);
    r -= allDat;
    CGContextFillEllipseInRect(currentContext, CGRectMake(cx - r/2, cy - r, r, r));
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)root_tab_bar_item2 {
    NSString *imageName = @"root_tab_bar_item2";
    NSData *imageData = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (imageData) {
        return [UIImage imageWithData:imageData scale:kSDImageScale];
    }
    
    CGFloat size = 22;
    CGFloat SD = size, sH = size;
    
    CGSize doubleSize = CGSizeMake(SD+kSDImageDefaultLineWidth*2, sH+kSDImageDefaultLineWidth*2);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    UIColor *color = kSDImageDefaultColor;
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    CGFloat a2 = M_PI_4/2.f, a3 = M_PI/15.f;
    CGFloat r1 = size*0.16, r2 = size*0.35, r3 = size/cosf(a3/2.f)/2;
    
    CGPoint point1 = CGPointMake(size/2.f - r3*sinf(a3/2.f)+kSDImageDefaultLineWidth, kSDImageDefaultLineWidth);
    CGPoint point2 = CGPointMake(size/2.f + r3*sinf(a3/2.f)+kSDImageDefaultLineWidth, kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, point1.x, point1.y);
    CGContextAddLineToPoint(currentContext, point2.x, point2.y);
    CGContextAddArc(currentContext, size/2+kSDImageDefaultLineWidth, size/2+kSDImageDefaultLineWidth, r2, -M_PI_2+a2/2.f, -M_PI_2+a2/2+a2, NO);
    
    CGPoint point3 = CGPointMake(size/2.f + r3*sinf(M_PI_4 - a3/2.f)+kSDImageDefaultLineWidth, size/2.f - r3*cosf(M_PI_4-a3/2.f)+kSDImageDefaultLineWidth);
    CGPoint point4 = CGPointMake(size/2.f + r3*sinf(M_PI_4 + a3/2.f)+kSDImageDefaultLineWidth, size/2.f - r3*cosf(M_PI_4+a3/2.f)+kSDImageDefaultLineWidth);
    
    CGContextAddLineToPoint(currentContext, point3.x, point3.y);
    CGContextAddLineToPoint(currentContext, point4.x, point4.y);
    CGContextAddArc(currentContext, size/2+kSDImageDefaultLineWidth, size/2+kSDImageDefaultLineWidth, r2, -M_PI_4+a2/2.f, -M_PI_4+a2/2+a2, NO);
    
    CGPoint point5 = CGPointMake(size+kSDImageDefaultLineWidth, size/2.f - r3*sinf(a3/2.f)+kSDImageDefaultLineWidth);
    CGPoint point6 = CGPointMake(size+kSDImageDefaultLineWidth, size/2.f + r3*sinf(a3/2.f)+kSDImageDefaultLineWidth);
    
    CGContextAddLineToPoint(currentContext, point5.x, point5.y);
    CGContextAddLineToPoint(currentContext, point6.x, point6.y);
    CGContextAddArc(currentContext, size/2+kSDImageDefaultLineWidth, size/2+kSDImageDefaultLineWidth, r2, a2/2.f, a2/2+a2, NO);
    
    CGPoint point7 = CGPointMake(size/2.f+r3*cosf(M_PI_4-a3/2.f)+kSDImageDefaultLineWidth, size/2.f + r3*sinf(M_PI_4-a3/2.f)+kSDImageDefaultLineWidth);
    CGPoint point8 = CGPointMake(size/2.f+r3*cosf(M_PI_4+a3/2.f)+kSDImageDefaultLineWidth, size/2.f + r3*sinf(M_PI_4+a3/2.f)+kSDImageDefaultLineWidth);
    
    CGContextAddLineToPoint(currentContext, point7.x, point7.y);
    CGContextAddLineToPoint(currentContext, point8.x, point8.y);
    CGContextAddArc(currentContext, size/2+kSDImageDefaultLineWidth, size/2+kSDImageDefaultLineWidth, r2, M_PI_4+a2/2.f, M_PI_4+a2/2+a2, NO);

    CGPoint point9 = CGPointMake(size/2 + r3*sinf(a3/2.f)+kSDImageDefaultLineWidth, size+kSDImageDefaultLineWidth);
    CGPoint point10 = CGPointMake(size/2 - r3*sinf(a3/2.f)+kSDImageDefaultLineWidth, size+kSDImageDefaultLineWidth);
    
    CGContextAddLineToPoint(currentContext, point9.x, point9.y);
    CGContextAddLineToPoint(currentContext, point10.x, point10.y);
    CGContextAddArc(currentContext, size/2+kSDImageDefaultLineWidth, size/2+kSDImageDefaultLineWidth, r2, M_PI_2+a2/2.f, M_PI_2+a2/2+a2, NO);
    
    CGPoint point11 = CGPointMake(size/2 - r3*sinf(M_PI_4-a3/2.f)+kSDImageDefaultLineWidth, size/2.f + r3*cosf(M_PI_4-a3/2.f)+kSDImageDefaultLineWidth);
    CGPoint point12 = CGPointMake(size/2 - r3*sinf(M_PI_4+a3/2.f)+kSDImageDefaultLineWidth, size/2.f + r3*cosf(M_PI_4+a3/2.f)+kSDImageDefaultLineWidth);
    
    CGContextAddLineToPoint(currentContext, point11.x, point11.y);
    CGContextAddLineToPoint(currentContext, point12.x, point12.y);
    CGContextAddArc(currentContext, size/2+kSDImageDefaultLineWidth, size/2+kSDImageDefaultLineWidth, r2, M_PI_2+M_PI_4+a2/2.f, M_PI_2+M_PI_4+a2/2+a2, NO);
    
    CGPoint point13 = CGPointMake(kSDImageDefaultLineWidth, size/2.f + r3*sinf(a3/2.f)+kSDImageDefaultLineWidth);
    CGPoint point14 = CGPointMake(kSDImageDefaultLineWidth, size/2.f - r3*sinf(a3/2.f)+kSDImageDefaultLineWidth);
    
    CGContextAddLineToPoint(currentContext, point13.x, point13.y);
    CGContextAddLineToPoint(currentContext, point14.x, point14.y);
    CGContextAddArc(currentContext, size/2+kSDImageDefaultLineWidth, size/2+kSDImageDefaultLineWidth, r2, M_PI+a2/2.f, M_PI+a2/2+a2, NO);
    
    CGPoint point15 = CGPointMake(size/2.f - r3*cosf(M_PI_4-a3/2.f)+kSDImageDefaultLineWidth, size/2.f - r3*sinf(M_PI_4-a3/2.f)+kSDImageDefaultLineWidth);
    CGPoint point16 = CGPointMake(size/2.f - r3*cosf(M_PI_4+a3/2.f)+kSDImageDefaultLineWidth, size/2.f - r3*sinf(M_PI_4+a3/2.f)+kSDImageDefaultLineWidth);
    
    CGContextAddLineToPoint(currentContext, point15.x, point15.y);
    CGContextAddLineToPoint(currentContext, point16.x, point16.y);
    CGContextAddArc(currentContext, size/2+kSDImageDefaultLineWidth, size/2+kSDImageDefaultLineWidth, r2, M_PI+M_PI_4+a2/2.f, M_PI+M_PI_4+a2/2+a2, NO);
    CGContextClosePath(currentContext);
    
    CGContextAddEllipseInRect(currentContext, CGRectMake(size/2-r1+kSDImageDefaultLineWidth, size/2-r1+kSDImageDefaultLineWidth, r1*2, r1*2));
    
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)root_tab_bar_item3 {
    NSString *imageName = @"root_tab_bar_item0";
    NSData *imageData = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (imageData) {
        return [UIImage imageWithData:imageData scale:kSDImageScale];
    }
    
    CGFloat SD = 44, sH = 44;
    CGFloat R = 2.5;
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(currentContext, [UIColor whiteColor].CGColor);
    
    CGContextFillEllipseInRect(currentContext, CGRectMake(SD/4 - R, sH/2 - R, R * 2, R * 2));
    CGContextFillEllipseInRect(currentContext, CGRectMake(SD/2 - R, sH/2 - R, R * 2, R * 2));
    CGContextFillEllipseInRect(currentContext, CGRectMake(SD*3/4 - R, sH/2 - R, R * 2, R * 2));
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)root_tab_bar_item4 {
    NSString *imageName = @"root_tab_bar_item0";
    NSData *imageData = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (imageData) {
        return [UIImage imageWithData:imageData scale:kSDImageScale];
    }
    
    CGFloat SD = 44, sH = 44;
    CGFloat allDat = 3;
    CGFloat width = 16, height = 20;//l:4 u: 6
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    UIColor *color = kSDImageDefaultColor;
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    CGFloat sX = (SD - width - allDat)/2, sY = (sH - height - allDat)/2;
    CGContextMoveToPoint(currentContext, sX + width, sY + allDat);
    CGContextAddLineToPoint(currentContext, sX + width, sY);
    CGContextAddLineToPoint(currentContext, sX, sY);
    CGContextAddLineToPoint(currentContext, sX, sY + height);
    CGContextAddLineToPoint(currentContext, sX + allDat, sY + height);
    CGContextAddRect(currentContext, CGRectMake(sX + allDat, sY + allDat, width, height));
    
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

#pragma mark -- FunctionView --

+ (UIImage *)folderImage
{
    NSString *imageName = @"folderImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    CGFloat SD = 88, sH = 88;
    CGFloat R = 10, r = 8;
    CGFloat maxWidth = R + r*2 + R + R*2 + R;
    CGFloat maxHeight = R + R + (maxWidth - R -r);
    CGFloat cx = (SD - maxWidth)/2 + R,cy = (sH - maxHeight)/2 + R;
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    UIColor *color = kSDImageDefaultColor;
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    //外圆弧
    CGContextAddArc(currentContext, cx, cy, R, M_PI, M_PI + M_PI_2, NO);
    CGContextAddArc(currentContext, cx + r * 2, cy, R, M_PI + M_PI_2, M_PI*2, NO);
    CGContextAddArc(currentContext, cx + maxWidth - R*2, cy + R, R, M_PI_2 + M_PI, M_PI * 2, NO);
    CGContextAddArc(currentContext, cx + maxWidth - R*2, cy + maxHeight - R*2, R, 0, M_PI_2, NO);
    CGContextAddArc(currentContext, cx, cy + maxHeight - R*2, R, M_PI_2, M_PI, NO);
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    //内圆弧
    CGContextAddArc(currentContext, cx, cy + maxHeight - R - r, r, 0, M_PI_2, NO);
    CGContextMoveToPoint(currentContext, cx + r, cy + maxHeight - R - r);
    CGContextAddLineToPoint(currentContext, cx + r, cy + R + r);
    CGContextDrawPath(currentContext, kCGPathStroke);
    CGContextAddArc(currentContext, cx + r*2, cy + R + r, r, M_PI, M_PI + M_PI_2, NO);
    CGContextAddArc(currentContext, cx + maxWidth - R - r, cy + R + r, r, M_PI + M_PI_2, 0, NO);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)albumImage
{
    NSString *imageName = @"albumImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    CGFloat SD = 88, sH = 88;
    CGFloat R = 10, r = 8;
    CGFloat maxWidth = R + r*2 + R + R*2 + R;
    CGFloat maxHeight = R + R + (maxWidth - R -r);
    CGFloat cx = (SD - maxWidth)/2 + R,cy = (sH - maxHeight)/2 + R;
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    UIColor *color = kSDImageDefaultColor;
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    //外圆弧
    CGContextAddArc(currentContext, cx, cy, R, M_PI, M_PI + M_PI_2, NO);
    CGContextAddArc(currentContext, cx + maxWidth - 2*R, cy, R, M_PI + M_PI_2, M_PI*2, NO);
    CGContextAddArc(currentContext, cx + maxWidth - R*2, cy + maxHeight - R*2, R, 0, M_PI_2, NO);
    CGContextAddArc(currentContext, cx, cy + maxHeight - R*2, R, M_PI_2, M_PI, NO);
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    //内圆弧
    CGContextAddEllipseInRect(currentContext, CGRectMake(cx, cy, R, R));
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    const CGPoint points[8] = {
        CGPointMake(cx - R, cy + maxHeight*3/4 - R),
        CGPointMake(cx + r, cy + maxHeight/2 - R),
        
        CGPointMake(cx + r, cy + maxHeight/2 - R),
        CGPointMake(cx + maxWidth/2, cy + maxHeight - R),
        
        CGPointMake(cx + r + (maxWidth/2 - r)/3, cy + maxHeight*2/3 - R),
        CGPointMake(cx + maxWidth*3/4 - R, cy + maxHeight/3 - R),
        
        CGPointMake(cx + maxWidth*3/4 - R, cy + maxHeight/3 - R),
        CGPointMake(cx + maxWidth - R, cy + maxHeight/2)
    };
    CGContextStrokeLineSegments(currentContext, points, 8);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)shootImage
{
    NSString *imageName = @"shootImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    CGFloat SD = 88, sH = 88;
    CGFloat R = 12, r = 6;
    CGFloat maxWidth = 70;
    CGFloat maxHeight = 60;
    CGFloat cx = (SD - maxWidth)/2 + maxWidth - R,cy = (sH - maxHeight)/2 + R;
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    UIColor *color = kSDImageDefaultColor;
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    //外框
    CGContextAddArc(currentContext, cx, cy, R, -M_PI_2, 0, NO);
    CGContextAddLineToPoint(currentContext, cx + R, cy + maxHeight - R);
    CGContextAddLineToPoint(currentContext, cx - maxWidth + R, cy + maxHeight - R);
    CGContextAddLineToPoint(currentContext, cx - maxWidth + R, cy);
    CGContextAddLineToPoint(currentContext, cx - maxWidth/2 + R, cy);
    CGContextAddLineToPoint(currentContext, cx - maxWidth/2 + R, cy - R);
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    //按钮
    CGFloat bx = cx - maxWidth + R + maxWidth/12;
    CGContextMoveToPoint(currentContext, bx, cy);
    CGContextAddLineToPoint(currentContext, bx, cy - R + r);
    CGContextAddArc(currentContext, bx + r, cy - R  + r, r, M_PI, M_PI_2 + M_PI, NO);
    CGContextAddArc(currentContext, bx + maxWidth/3 - r, cy - R + r, r, - M_PI_2, 0, NO);
    CGContextAddLineToPoint(currentContext, bx + maxWidth/3, cy);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    //摄像头
    CGFloat px = (SD - maxWidth)/2 + maxWidth/4 + R/2, py = (sH - maxHeight)/2 + R + (maxHeight - R)/2;
    CGContextAddArc(currentContext, px, py, maxWidth/12, 0, M_PI * 2, NO);
    CGContextDrawPath(currentContext, kCGPathStroke);
    CGContextAddArc(currentContext, px, py, maxWidth/6, 0, M_PI * 2, NO);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    //闪光灯
    const CGPoint points[6] = {
        CGPointMake(cx, cy),
        CGPointMake(cx - maxWidth/6, cy),
        CGPointMake(cx, cy + r),
        CGPointMake(cx - maxWidth/6, cy + r),
        CGPointMake(cx + R, cy + R),
        CGPointMake(cx + R - maxWidth/2, cy + R)
    };
    CGContextStrokeLineSegments(currentContext, points, 6);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)musicImage
{
    NSString *imageName = @"musicImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    CGFloat SD = 88, sH = 88;
    CGFloat R = 10;
    CGFloat maxWidth = 66;
    CGFloat maxHeight = 66;
    CGFloat cx = (SD - maxWidth)/2 + R,cy = (sH - maxHeight)/2 + R;
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    UIColor *color = kSDImageDefaultColor;
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    //外框
    CGContextAddArc(currentContext, cx, cy, R, M_PI, M_PI + M_PI_2, NO);
    CGContextAddArc(currentContext, cx + maxWidth - R*2, cy, R, -M_PI_2, 0, NO);
    CGContextAddArc(currentContext, cx + maxWidth - R*2, cy + maxHeight - R*2, R, 0, M_PI_2, NO);
    CGContextAddArc(currentContext, cx, cy + maxHeight - R*2, R, M_PI_2, M_PI, NO);
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    //影带
    const CGPoint points[8] = {
        CGPointMake(cx, cy + R),
        CGPointMake(cx + maxWidth/4, cy + R),
        CGPointMake(cx, cy + R*2),
        CGPointMake(cx + maxWidth/4, cy + R*2),
        CGPointMake(cx + maxWidth - R*2, cy + maxHeight - R*2),
        CGPointMake(cx + maxWidth - R*2 - maxWidth/4, cy + maxHeight - R*2),
        CGPointMake(cx + maxWidth - R*2, cy + maxHeight - R*3),
        CGPointMake(cx + maxWidth - R*2 - maxWidth/4, cy + maxHeight - R*3)
    };
    CGContextStrokeLineSegments(currentContext, points, 8);
    
    //音乐
    
    CGContextMoveToPoint(currentContext, SD/2, sH/2 - maxHeight/4);
    CGContextAddLineToPoint(currentContext, SD/2 + maxWidth/4, sH/2 - maxHeight/4 - maxHeight/12);
    CGContextAddLineToPoint(currentContext, SD/2 + maxWidth/4, sH/2 - maxHeight/4 + maxHeight/12);
    CGContextAddLineToPoint(currentContext, SD/2, sH/2 - maxHeight/4 + maxHeight/6);
    CGContextMoveToPoint(currentContext, SD/2, sH/2 - maxHeight/4);
    CGContextAddLineToPoint(currentContext, SD/2, sH/2 + maxHeight/4);
    
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(SD/2 - maxWidth/4, sH/2 + maxHeight/4 - maxHeight/16, maxWidth/4, maxHeight/8));
    CGContextAddPath(currentContext, path);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGPathRelease(path);
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)downloadImage
{
    NSString *imageName = @"downloadImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    CGFloat SD = 88, sH = 88;
    CGFloat R = 14, r = 12;
    CGFloat maxWidth = R + r*4 + R;
    CGFloat maxHeight = R*2 + r*2;
    CGFloat cx = (SD - maxWidth)/2 + R + r * 2, cy = (sH - maxHeight)/2 + r*2;
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    UIColor *color = kSDImageDefaultColor;
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    //外框
    CGContextAddArc(currentContext, cx, cy, r*2, -M_PI_2 - M_PI/8, 0, NO);
    CGContextAddArc(currentContext, cx + r*2, cy + R, R, -M_PI_2, M_PI_2, NO);
    CGContextAddArc(currentContext, cx - r*2, cy + R, R, M_PI_2, M_PI_2 + M_PI, NO);
    CGContextAddArc(currentContext, cx - r, cy, r, M_PI, M_PI*2, NO);
    CGContextAddLineToPoint(currentContext, SD/2, sH/2 + maxHeight/4);
    CGContextMoveToPoint(currentContext, SD/2 - r/2, sH/2 + maxHeight/4 - r/2);
    CGContextAddLineToPoint(currentContext, SD/2, sH/2 + maxHeight/4);
    CGContextAddLineToPoint(currentContext, SD/2 + r/2, sH/2 + maxHeight/4 - r/2);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}


#pragma mark -- unused --

+ (UIImage *)detailImage
{
    NSString *imageName = @"detailImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    CGFloat SD = 12, sH = 20;
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, kSDImageDefaultColor.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    CGContextMoveToPoint(currentContext, 0, kSDImageDefaultLineWidth/2);
    CGContextAddLineToPoint(currentContext, SD-kSDImageDefaultLineWidth*1.414, sH/2);
    CGContextAddLineToPoint(currentContext, 0, sH - kSDImageDefaultLineWidth);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)backImage
{
    NSString *imageName = @"backImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    CGFloat SD = 12, sH = 22;
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, kSDImageDefaultColor.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    CGContextMoveToPoint(currentContext, SD, kSDImageDefaultLineWidth/2);
    CGContextAddLineToPoint(currentContext, kSDImageDefaultLineWidth*1.414, sH/2);
    CGContextAddLineToPoint(currentContext, SD, sH - kSDImageDefaultLineWidth);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)closeImage {
    NSString *imageName = @"closeImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    CGFloat SD = 18, sH = 18;
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, kSDImageDefaultColor.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    CGContextMoveToPoint(currentContext, kSDImageDefaultLineWidth, kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD - kSDImageDefaultLineWidth*2, sH - kSDImageDefaultLineWidth*2);
    CGContextDrawPath(currentContext, kCGPathStroke);
    CGContextMoveToPoint(currentContext, SD - kSDImageDefaultLineWidth*2, kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, kSDImageDefaultLineWidth, sH - kSDImageDefaultLineWidth*2);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)doneImage {
    NSString *imageName = @"doneImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    CGFloat SD = 24, sH = 16;
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, kSDImageDefaultColor.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    CGContextMoveToPoint(currentContext, kSDImageDefaultLineWidth, kSDImageDefaultLineWidth + 0.3 * sH);
    CGContextAddLineToPoint(currentContext, kSDImageDefaultLineWidth + SD * 0.34, sH - kSDImageDefaultLineWidth*2);
    CGContextAddLineToPoint(currentContext, SD - kSDImageDefaultLineWidth*2, kSDImageDefaultLineWidth);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)moreImage {
    NSString *imageName = @"moreImage";
    NSData *imageData = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (imageData) {
        return [UIImage imageWithData:imageData scale:kSDImageScale];
    }
    
    CGFloat SD = 30, sH = 30;
    CGFloat R = 2.5;
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(currentContext, [UIColor whiteColor].CGColor);
    
    CGContextFillEllipseInRect(currentContext, CGRectMake(SD/4 - R, sH/2 - R, R * 2, R * 2));
    CGContextFillEllipseInRect(currentContext, CGRectMake(SD/2 - R, sH/2 - R, R * 2, R * 2));
    CGContextFillEllipseInRect(currentContext, CGRectMake(SD*3/4 - R, sH/2 - R, R * 2, R * 2));
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)storeImage {
    NSString *imageName = @"storeImage";
    NSData *imageData = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (imageData) {
        return [UIImage imageWithData:imageData scale:kSDImageScale];
    }
    
    CGFloat R = 13;
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
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)storedImage {
    NSString *imageName = @"storedImage";
    NSData *imageData = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (imageData) {
        return [UIImage imageWithData:imageData scale:kSDImageScale];
    }
    
    CGFloat R = 13;
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
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)headPhoneImage {
    NSString *imageName = @"headPhoneImage";
    NSData *imageData = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (imageData) {
        return [UIImage imageWithData:imageData scale:kSDImageScale];
    }
    
    CGFloat R = 10, r = 2, w = 2, space = 1;
    CGFloat SD = R+R+r+r, sH = R+R;
    CGSize doubleSize = CGSizeMake(SD+kSDImageDefaultLineWidth*2, sH+kSDImageDefaultLineWidth*2);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(currentContext, kSDImageDefaultColor.CGColor);
    
    CGContextAddArc(currentContext, r+kSDImageDefaultLineWidth, sH-r+kSDImageDefaultLineWidth, r, M_PI_2, M_PI, NO);
    CGContextAddArc(currentContext, r+kSDImageDefaultLineWidth, R+r+kSDImageDefaultLineWidth, r, M_PI, M_PI+M_PI_2, NO);
    CGContextAddArc(currentContext, SD/2+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth, R, -M_PI, 0, NO);
    CGContextAddArc(currentContext, SD/2+R+kSDImageDefaultLineWidth, R+r+kSDImageDefaultLineWidth, r, -M_PI_2, 0, NO);
    CGContextAddArc(currentContext, SD/2+R+kSDImageDefaultLineWidth, sH-r+kSDImageDefaultLineWidth, r, 0, M_PI_2, NO);
    CGContextAddLineToPoint(currentContext, SD-r-w+kSDImageDefaultLineWidth, sH+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD-r-w+kSDImageDefaultLineWidth, R+kSDImageDefaultLineWidth);
    CGContextAddArcToPoint(currentContext, SD-r-w+kSDImageDefaultLineWidth, w+kSDImageDefaultLineWidth, SD/2+kSDImageDefaultLineWidth, w+kSDImageDefaultLineWidth, R-w);
    CGContextAddArcToPoint(currentContext, r+w+kSDImageDefaultLineWidth, w+kSDImageDefaultLineWidth, r+w+kSDImageDefaultLineWidth, R+kSDImageDefaultLineWidth, R-w);
    CGContextAddLineToPoint(currentContext, r+w+kSDImageDefaultLineWidth, sH+kSDImageDefaultLineWidth);
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathFill);
    
    CGContextSetLineWidth(currentContext, space*2);
    CGContextSetStrokeColorWithColor(currentContext, kSDImageDefaultColor.CGColor);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    
    CGContextMoveToPoint(currentContext, r+w+space*2+kSDImageDefaultLineWidth, sH-space+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, r+w+space*2+kSDImageDefaultLineWidth, sH/2+space+kSDImageDefaultLineWidth);
    CGContextMoveToPoint(currentContext, SD-(r+w+space*2)+kSDImageDefaultLineWidth, sH-space+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD-(r+w+space*2)+kSDImageDefaultLineWidth, sH/2+space+kSDImageDefaultLineWidth);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

#pragma mark -- File Image --

+ (UIImage *)defaultFileImage
{
    NSString *imageName = @"defaultFileImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    CGFloat SD = 88, sH = 88;
    CGFloat R = 6;
    CGFloat maxWidth = 60;
    CGFloat maxHeight = 68;
    CGFloat curvedLength = maxWidth/3;
    CGFloat cx = (SD - maxWidth)/2 + maxWidth - R, cy = (sH - maxHeight)/2 + maxHeight - R;
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    UIColor *color = [UIColor lightGrayColor];
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    //外框
    CGContextAddArc(currentContext, cx, cy, R, 0, M_PI_2, NO);
    CGContextAddArc(currentContext, cx - maxWidth + R*2, cy , R, M_PI_2, M_PI, NO);
    CGContextAddArc(currentContext, cx - maxWidth + R*2, cy - maxHeight + R*2, R, M_PI, M_PI_2 + M_PI, NO);
    CGContextAddLineToPoint(currentContext, SD/2 + maxWidth/2 - curvedLength, sH/2 - maxHeight/2);
    CGContextAddLineToPoint(currentContext, SD/2 + maxWidth/2, sH/2 - maxHeight/2 + curvedLength);
    CGContextAddArc(currentContext, SD/2 + maxWidth/2 - curvedLength + R, sH/2 - maxHeight/2 + curvedLength - R, R, M_PI_2, M_PI, NO);
    CGContextAddLineToPoint(currentContext, SD/2 + maxWidth/2 - curvedLength, sH/2 - maxHeight/2);
    CGContextMoveToPoint(currentContext, SD/2 + maxWidth/2, sH/2 - maxHeight/2 + curvedLength);
    CGContextAddLineToPoint(currentContext, SD/2 + maxWidth/2, sH/2 + maxHeight/2 - R);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)directoryImage {
    NSString *imageName = @"directoryImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    CGFloat SD = 20, sH = 25, dW = 2.5, dH = 3;
    
    CGSize doubleSize = CGSizeMake(SD+kSDImageDefaultLineWidth*2, sH+kSDImageDefaultLineWidth*2);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, kDarkColor.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    CGContextMoveToPoint(currentContext, kSDImageDefaultLineWidth, dH + kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD-dW + kSDImageDefaultLineWidth, dH + kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD-dW+kSDImageDefaultLineWidth, sH+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, kSDImageDefaultLineWidth, sH+kSDImageDefaultLineWidth);
    CGContextClosePath(currentContext);
    
    CGContextMoveToPoint(currentContext, dW+kSDImageDefaultLineWidth, dH+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, dW+kSDImageDefaultLineWidth, kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD+kSDImageDefaultLineWidth, kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD+kSDImageDefaultLineWidth, sH-dH+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD-dW+kSDImageDefaultLineWidth, sH-dH+kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, dW+kSDImageDefaultLineWidth, (sH-dH)/5.f+dH+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD-dW*2+kSDImageDefaultLineWidth, (sH-dH)/5.f+dH+kSDImageDefaultLineWidth);
    CGContextMoveToPoint(currentContext, dW+kSDImageDefaultLineWidth, (sH-dH)*2.f/5.f+dH+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD-dW*2+kSDImageDefaultLineWidth, (sH-dH)*2.f/5.f+dH+kSDImageDefaultLineWidth);
    CGContextMoveToPoint(currentContext, dW+kSDImageDefaultLineWidth, (sH-dH)*3.f/5.f+dH+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD-dW*2+kSDImageDefaultLineWidth, (sH-dH)*3.f/5.f+dH+kSDImageDefaultLineWidth);
    CGContextMoveToPoint(currentContext, dW+kSDImageDefaultLineWidth, (sH-dH)*4.f/5.f+dH+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD-dW*2+kSDImageDefaultLineWidth, (sH-dH)*4.f/5.f+dH+kSDImageDefaultLineWidth);
    
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)fileTypeImage:(NSString *)fileTypeName
{
    CGFloat SD = 88, sH = 88;
    CGFloat R = 6;
    CGFloat maxWidth = 60;
    CGFloat maxHeight = 68;
    CGFloat curvedLength = maxWidth/3;
    CGFloat cx = (SD - maxWidth)/2 + maxWidth - R, cy = (sH - maxHeight)/2 + maxHeight - R;
    CGFloat fileNameHeight = 14.f;
    CGFloat fileNameWidth = 0;
    
    NSDictionary *attr = @{
                           NSFontAttributeName: [UIFont systemFontOfSize:10],
                           NSForegroundColorAttributeName: [UIColor magentaColor],
                           NSKernAttributeName: @(1)
                           };
    fileNameWidth = [fileTypeName boundingRectWithSize:CGSizeMake(MAXFLOAT, fileNameHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:NULL].size.width;
    if (fileNameWidth > maxWidth) {
        fileNameWidth = maxWidth;
    }
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    UIColor *color = [UIColor lightGrayColor];
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    //外框
    CGContextAddArc(currentContext, cx, cy, R, 0, M_PI_2, NO);
    CGContextAddArc(currentContext, cx - maxWidth + R*2, cy , R, M_PI_2, M_PI, NO);
    CGContextAddArc(currentContext, cx - maxWidth + R*2, cy - maxHeight + R*2, R, M_PI, M_PI_2 + M_PI, NO);
    CGContextAddLineToPoint(currentContext, SD/2 + maxWidth/2 - curvedLength, sH/2 - maxHeight/2);
    CGContextAddLineToPoint(currentContext, SD/2 + maxWidth/2, sH/2 - maxHeight/2 + curvedLength);
    CGContextAddArc(currentContext, SD/2 + maxWidth/2 - curvedLength + R, sH/2 - maxHeight/2 + curvedLength - R, R, M_PI_2, M_PI, NO);
    CGContextAddLineToPoint(currentContext, SD/2 + maxWidth/2 - curvedLength, sH/2 - maxHeight/2);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    //文字
    CGContextSetLineWidth(currentContext, 1.5);
    CGFloat leftX = (SD - maxWidth)/2 + R, leftY = (sH - maxHeight)/2 + R + R/2;
    const CGPoint points[6] = {
        CGPointMake(leftX, leftY),
        CGPointMake(leftX + maxWidth - R*2 - curvedLength, leftY),
        CGPointMake(leftX, leftY + R + R/2),
        CGPointMake(leftX + maxWidth - R*2 - curvedLength, leftY + R + R/2),
        CGPointMake(leftX , leftY + R*3),
        CGPointMake(leftX + maxWidth - R*2 - curvedLength, leftY + R*3)
    };
    CGContextStrokeLineSegments(currentContext, points, 6);
    CGContextSetLineWidth(currentContext, 1);
    
    cx = cx + R*2;
    cy = cy - R*2;
    
    CGContextAddArc(currentContext, cx, cy, R, 0, M_PI_2, NO);
    CGContextAddArc(currentContext, cx - fileNameWidth, cy, R, M_PI_2, M_PI, NO);
    CGContextAddArc(currentContext, cx - fileNameWidth , cy - fileNameHeight + R*2, R, M_PI, M_PI+M_PI_2, NO);
    CGContextAddArc(currentContext, cx, cy - fileNameHeight + R*2, R, -M_PI_2, 0, NO);
    CGContextClosePath(currentContext);
    CGContextMoveToPoint(currentContext, SD/2 + maxWidth/2, sH/2 - maxHeight/2 + curvedLength);
    CGContextAddLineToPoint(currentContext, SD/2 + maxWidth/2, cy - fileNameHeight + R);
    CGContextMoveToPoint(currentContext, SD/2 + maxWidth/2, cy + R);
    CGContextAddLineToPoint(currentContext, SD/2 + maxWidth/2, cy + R*2);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    CGContextSetTextDrawingMode(currentContext, kCGTextFill);
    [fileTypeName drawInRect:CGRectMake(cx - fileNameWidth + 1, cy - fileNameHeight + R, fileNameWidth, fileNameHeight)
              withAttributes:attr];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)txtFileImage
{
    NSString *imageName = @"txtFileImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    UIImage *newImage = [self fileTypeImage:@"TXT"];
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    return newImage;
}

+ (UIImage *)wordFileImage
{
    NSString *imageName = @"wordFileImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    UIImage *newImage = [self fileTypeImage:@"WORD"];
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    return newImage;
}

+ (UIImage *)pptFileImage
{
    NSString *imageName = @"pptFileImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    UIImage *newImage = [self fileTypeImage:@"PPT"];
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    return newImage;
}

+ (UIImage *)excelFileImage
{
    NSString *imageName = @"excelFileImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    UIImage *newImage = [self fileTypeImage:@"EXCEL"];
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    return newImage;
}

+ (UIImage *)videoImage
{
    NSString *imageName = @"videoImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data];
    }
    
    CGFloat SD = 88, sH = 88;
    CGFloat R = 12, r = 6;
    CGFloat maxWidth = 70;
    CGFloat maxHeight = 60;
    CGFloat cx = (SD - maxWidth)/2 + maxWidth - R,cy = (sH - maxHeight)/2 + R;
    
    CGSize doubleSize = CGSizeMake(SD, sH);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    UIColor *color = kSDImageDefaultColor;
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    //外框
    CGContextAddArc(currentContext, cx, cy, R, -M_PI_2, 0, NO);
    CGContextAddLineToPoint(currentContext, cx + R, cy + maxHeight - R);
    CGContextAddLineToPoint(currentContext, cx - maxWidth + R, cy + maxHeight - R);
    CGContextAddLineToPoint(currentContext, cx - maxWidth + R, cy);
    CGContextAddLineToPoint(currentContext, cx - maxWidth/2 + R, cy);
    CGContextAddLineToPoint(currentContext, cx - maxWidth/2 + R, cy - R);
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    //按钮
    CGFloat bx = cx - maxWidth + R + maxWidth/12;
    CGContextMoveToPoint(currentContext, bx, cy);
    CGContextAddLineToPoint(currentContext, bx, cy - R + r);
    CGContextAddArc(currentContext, bx + r, cy - R  + r, r, M_PI, M_PI_2 + M_PI, NO);
    CGContextAddArc(currentContext, bx + maxWidth/3 - r, cy - R + r, r, - M_PI_2, 0, NO);
    CGContextAddLineToPoint(currentContext, bx + maxWidth/3, cy);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    //摄像头
    CGFloat px = (SD - maxWidth)/2 + maxWidth/4 + R/2, py = (sH - maxHeight)/2 + R + (maxHeight - R)/2;
    CGContextAddArc(currentContext, px, py, maxWidth/12, 0, M_PI * 2, NO);
    CGContextDrawPath(currentContext, kCGPathStroke);
    CGContextAddArc(currentContext, px, py, maxWidth/6, 0, M_PI * 2, NO);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    //闪光灯
    const CGPoint points[6] = {
        CGPointMake(cx, cy),
        CGPointMake(cx - maxWidth/6, cy),
        CGPointMake(cx, cy + r),
        CGPointMake(cx - maxWidth/6, cy + r),
        CGPointMake(cx + R, cy + R),
        CGPointMake(cx + R - maxWidth/2, cy + R)
    };
    CGContextStrokeLineSegments(currentContext, points, 6);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)menuImage {
    NSString *imageName = @"menuImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    CGFloat SD = 22, sH = 20;
    CGFloat space = 2;
    
    CGSize doubleSize = CGSizeMake(SD+kSDImageDefaultLineWidth*2, sH+kSDImageDefaultLineWidth*2);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, kSDImageDefaultColor.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    
    CGContextMoveToPoint(currentContext, space+kSDImageDefaultLineWidth, space+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, space+kSDImageDefaultLineWidth*3, space+kSDImageDefaultLineWidth);
    CGContextMoveToPoint(currentContext, space+kSDImageDefaultLineWidth*5, space+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD-space+kSDImageDefaultLineWidth, space+kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, space+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, space+kSDImageDefaultLineWidth*3, sH/2+kSDImageDefaultLineWidth);
    CGContextMoveToPoint(currentContext, space+kSDImageDefaultLineWidth*5, sH/2+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD-space+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, space+kSDImageDefaultLineWidth, sH-space+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, space+kSDImageDefaultLineWidth*3, sH-space+kSDImageDefaultLineWidth);
    CGContextMoveToPoint(currentContext, space+kSDImageDefaultLineWidth*5, sH-space+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD-space+kSDImageDefaultLineWidth, sH-space+kSDImageDefaultLineWidth);
    
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)nightImage {
    NSString *imageName = @"nightImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    CGFloat R = 10;
    CGFloat SD = R*2, sH = R*2;
    
    CGSize doubleSize = CGSizeMake(SD+kSDImageDefaultLineWidth*2, sH+kSDImageDefaultLineWidth*2);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, kSDImageDefaultColor.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineJoin(currentContext, kCGLineJoinRound);
    
    CGContextMoveToPoint(currentContext, SD/2+kSDImageDefaultLineWidth, sH+kSDImageDefaultLineWidth);
    CGContextAddArc(currentContext, SD/2+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth, R, -M_PI_2, M_PI_2, NO);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    
    CGContextMoveToPoint(currentContext, SD/2+kSDImageDefaultLineWidth, sH+kSDImageDefaultLineWidth);
    CGContextAddArc(currentContext, SD/2+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth, R, M_PI_2, -M_PI_2, NO);
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)brightnessMinImage {
    NSString *imageName = @"brightnessMinImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    CGFloat R = 3, space = 2, line = 2;
    CGFloat SD = (R+kSDImageDefaultLineWidth+space+line)*2, sH = SD;
    
    CGFloat a = R+space, b = a+line;
    CGFloat c = (R+space)*cosf(M_PI_4), d = (a+line)*cosf(M_PI_4);
    
    CGSize doubleSize = CGSizeMake(SD+kSDImageDefaultLineWidth*2, sH+kSDImageDefaultLineWidth*2);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, kSDImageDefaultColor.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    
    CGContextMoveToPoint(currentContext, SD/2-R+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth);
    CGContextAddArc(currentContext, SD/2+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth, R, -M_PI, M_PI, NO);
    
    CGContextMoveToPoint(currentContext, SD/2+kSDImageDefaultLineWidth, sH/2-a+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD/2+kSDImageDefaultLineWidth, sH/2-b+kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, SD/2+c+kSDImageDefaultLineWidth, sH/2-c+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD/2+d+kSDImageDefaultLineWidth, sH/2-d+kSDImageDefaultLineWidth);

    CGContextMoveToPoint(currentContext, SD/2+a+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD/2+a+line+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, SD/2+c+kSDImageDefaultLineWidth, sH/2+c+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD/2+d+kSDImageDefaultLineWidth, sH/2+d+kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, SD/2+kSDImageDefaultLineWidth, sH/2+a+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD/2+kSDImageDefaultLineWidth, sH/2+a+line+kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, SD/2-c+kSDImageDefaultLineWidth, sH/2+c+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD/2-d+kSDImageDefaultLineWidth, sH/2+d+kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, SD/2-a+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD/2-a-line+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, SD/2-c+kSDImageDefaultLineWidth, sH/2-c+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD/2-d+kSDImageDefaultLineWidth, sH/2-d+kSDImageDefaultLineWidth);

    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

+ (UIImage *)brightnessMaxImage {
    NSString *imageName = @"brightnessMaxImage";
    NSData *data = [[SDImageStorage sharedStorage] dataForKey:imageName];
    if (data) {
        return [UIImage imageWithData:data scale:kSDImageScale];
    }
    
    CGFloat R = 5, space = 2, line = 3;
    CGFloat SD = (R+kSDImageDefaultLineWidth+space+line)*2, sH = SD;
    
    CGFloat a = R+space, b = a+line;
    CGFloat c = (R+space)*cosf(M_PI_4), d = (a+line)*cosf(M_PI_4);
    
    CGSize doubleSize = CGSizeMake(SD+kSDImageDefaultLineWidth*2, sH+kSDImageDefaultLineWidth*2);
    
    UIGraphicsBeginImageContextWithOptions(doubleSize, NO, kSDImageScale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, kSDImageDefaultColor.CGColor);
    CGContextSetLineWidth(currentContext, kSDImageDefaultLineWidth);
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    
    CGContextMoveToPoint(currentContext, SD/2-R+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth);
    CGContextAddArc(currentContext, SD/2+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth, R, -M_PI, M_PI, NO);
    
    CGContextMoveToPoint(currentContext, SD/2+kSDImageDefaultLineWidth, sH/2-a+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD/2+kSDImageDefaultLineWidth, sH/2-b+kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, SD/2+c+kSDImageDefaultLineWidth, sH/2-c+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD/2+d+kSDImageDefaultLineWidth, sH/2-d+kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, SD/2+a+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD/2+a+line+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, SD/2+c+kSDImageDefaultLineWidth, sH/2+c+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD/2+d+kSDImageDefaultLineWidth, sH/2+d+kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, SD/2+kSDImageDefaultLineWidth, sH/2+a+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD/2+kSDImageDefaultLineWidth, sH/2+a+line+kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, SD/2-c+kSDImageDefaultLineWidth, sH/2+c+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD/2-d+kSDImageDefaultLineWidth, sH/2+d+kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, SD/2-a+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD/2-a-line+kSDImageDefaultLineWidth, sH/2+kSDImageDefaultLineWidth);
    
    CGContextMoveToPoint(currentContext, SD/2-c+kSDImageDefaultLineWidth, sH/2-c+kSDImageDefaultLineWidth);
    CGContextAddLineToPoint(currentContext, SD/2-d+kSDImageDefaultLineWidth, sH/2-d+kSDImageDefaultLineWidth);
    
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [[SDImageStorage sharedStorage] saveData:UIImagePNGRepresentation(newImage) forKey:imageName];
    
    return newImage;
}

@end
