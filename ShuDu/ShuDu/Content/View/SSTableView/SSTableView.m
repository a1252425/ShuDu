//
//  SSTableView.m
//  SuperWatch
//
//  Created by 邵帅 on 2017/9/7.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SSTableView.h"

@interface SSTableView ()
{
    CGPoint currentTouchPoint;
    BOOL _deleteShowing;
    BOOL _shouldBegin;
}

@end

@implementation SSTableView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    currentTouchPoint = [touch locationInView:self];
    _shouldBegin = YES;
    _deleteShowing = NO;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if (_shouldBegin) {
        self.scrollEnabled = YES;
        if (fabs(currentTouchPoint.y - point.y) < 3) {
            _deleteShowing = YES;
            self.scrollEnabled = NO;
        }else
            _shouldBegin = NO;
    }
    
    if (_deleteShowing) {
        self.transform = CGAffineTransformTranslate(self.transform, point.x-currentTouchPoint.x, 0);
    }
    currentTouchPoint = point;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    
}

@end
