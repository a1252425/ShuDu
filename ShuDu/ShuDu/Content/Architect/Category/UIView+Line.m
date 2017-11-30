//
//  UIView+Line.m
//  CourseStudy-Master
//
//  Created by 邵帅 on 2017/8/1.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "UIView+Line.h"

#define kLineColor          UIRGBColor(227, 227, 227)
#define kLineWidth          0.5f

@implementation UIView (Line)

- (void)showLine:(SSLinePosition)position {
    [self showLine:position lineColor:kLineColor];
}

- (void)showLine:(SSLinePosition)position lineColor:(UIColor *)color {
    [self showLine:position lineColor:color lineWidth:kLineWidth];
}

- (void)showLine:(SSLinePosition)position lineWidth:(CGFloat)width {
    [self showLine:position lineColor:kLineColor lineWidth:width];
}

- (void)showLine:(SSLinePosition)position lineColor:(UIColor *)color lineWidth:(CGFloat)width{
    if (position == SSLinePositionAll) {
        self.layer.borderColor = color.CGColor;
        self.layer.borderWidth = width;
        return;
    }
    
    if (position & SSLinePositionLeft) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = color;
        [self addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.width.mas_equalTo(kLineWidth);
        }];
    }
    
    if (position & SSLinePositionTop) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = color;
        [self addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(width);
        }];
    }
    
    if (position & SSLinePositionRight) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = color;
        [self addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.right.equalTo(self);
            make.width.mas_equalTo(width);
        }];
    }
    
    if (position & SSLinePositionBottom) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = color;
        [self addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.height.mas_equalTo(width);
        }];
    }
}

@end
