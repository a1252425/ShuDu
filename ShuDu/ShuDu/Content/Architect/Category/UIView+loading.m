//
//  UIView+loading.m
//  SuperWatch
//
//  Created by 邵帅 on 2017/9/1.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "UIView+loading.h"
#import <objc/runtime.h>

static char kUIViewAnimatingViewKey;

@implementation UIView (loading)

- (void)setAnimatingView:(UIActivityIndicatorView *)animatingView {
    objc_setAssociatedObject(self, &kUIViewAnimatingViewKey, animatingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIActivityIndicatorView *)animatingView {
    return objc_getAssociatedObject(self, &kUIViewAnimatingViewKey);
}

- (void)startAnimating {
    UIActivityIndicatorView *_view = [self animatingView];
    if (!_view) {
        _view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self setAnimatingView:_view];
    }
    [self addSubview:_view];
    
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [_view startAnimating];
}

- (void)stopAnimating {
    UIActivityIndicatorView *_view = [self animatingView];
    if (!_view) {
        return;
    }
    [_view stopAnimating];
    [_view removeFromSuperview];
}

@end
