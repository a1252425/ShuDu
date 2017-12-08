//
//  SDTXTReaderMenuContentView.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/8.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderMenuContentView.h"
#import "UIView+Line.h"

@interface SDTXTReaderMenuContentView ()
{
    UIView *_movingView;
    UIButton *_button;
    NSArray<UIView *> *_views;
}

@end

@implementation SDTXTReaderMenuContentView

- (instancetype)initWithViews:(NSArray *)views titles:(NSArray *)titles {
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        _views = views;
        
        UIView *segmentView = [[UIView alloc] init];
        [self addSubview:segmentView];
        
        [segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(49);
        }];
        
        [segmentView showLine:SSLinePositionBottom];
        
        __block UIView *lastView;
        for (int i = 0; i < titles.count; i ++) {
            NSString *title = titles[i];
            UIButton *button = [[UIButton alloc] init];
            [button setTag:i];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [segmentView addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(segmentView);
                make.width.equalTo(segmentView).multipliedBy(1.f/3.f);
                if (!lastView) {
                    make.left.equalTo(segmentView);
                    _button = button;
                }
                else{
                    make.left.equalTo(lastView.mas_right);
                    make.width.equalTo(lastView);
                }
                lastView = button;
            }];
        }
        
        _movingView = [[UIView alloc] init];
        _movingView.backgroundColor = [UIColor blackColor];
        [segmentView addSubview:_movingView];
        
        [_movingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(2);
            make.width.equalTo(segmentView).multipliedBy(0.16);
            make.bottom.equalTo(segmentView);
            make.centerX.equalTo(_button);
        }];
        
        for (UIView *view in views) {
            [self addSubview:view];
            view.hidden = YES;
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(self);
                make.top.equalTo(segmentView.mas_bottom);
            }];
        }
        
        [views[_button.tag] setHidden:NO];
    }
    return self;
}

- (void)buttonSelected:(UIButton *)button {
    
    if (_button) {
        _button.selected = NO;
        [_views[_button.tag] setHidden:YES];
    }
    
    button.selected = YES;
    [_views[button.tag] setHidden:NO];
    
    [UIView animateWithDuration:0.3 animations:^{
        _movingView.transform = CGAffineTransformMakeTranslation(button.frame.size.width * button.tag, 0);
    }];
    
    _button = button;
}

@end
