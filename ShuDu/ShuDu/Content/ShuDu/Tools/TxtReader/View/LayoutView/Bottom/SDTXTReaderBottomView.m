//
//  SDTXTReaderBottomView.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/6.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderBottomView.h"

#import "SDTXTReaderNormalView.h"

@interface SDTXTReaderBottomView ()
{
    UIView<SDTXTReaderAnimatedProtocol> *_view;
}

@property (nonatomic, strong) SDTXTReaderNormalView *normalView;;

@end

@implementation SDTXTReaderBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _extensionHeight = 190.f;
        
        [self addSubview:self.normalView];
        [self.normalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.height.mas_equalTo(self.normalView.height);
        }];
        
        _view = self.normalView;
    }
    return self;
}

- (SDTXTReaderNormalView *)normalView {
    if (!_normalView) {
        _normalView = [[SDTXTReaderNormalView alloc] init];
    }
    return _normalView;
}

#pragma mark - SDTXTReaderAnimatedProtocol -

- (void)show {
    [_view show];
}

- (void)dismiss {
    [_view dismiss];
}

@end
