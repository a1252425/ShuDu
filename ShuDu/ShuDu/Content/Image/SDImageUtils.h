//
//  SDImageUtils.h
//  SuperWatch
//
//  Created by 邵帅 on 2017/8/30.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSDImageScale  2.f
#define kSDImageDefaultLineWidth    1.f
#define kSDImageDefaultColor        [UIColor blackColor]

@interface SDImageUtils : NSObject

+ (void)starPathContext:(CGContextRef)context R:(CGFloat)R;

@end
