//
//  SDTXTReaderLayoutView.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/6.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderLayoutView.h"

#import "SDTXTReaderTopView.h"
#import "SDTXTReaderBottomView.h"
#import "SDTXTReaderMenuView.h"

CGFloat const kSDTXTReaderLayoutAnimateDuration = 0.3f;
CGFloat const kSDTXTReaderLayoutDismissDaly = 3.8f;

@interface SDTXTReaderLayoutView ()

@property (nonatomic, strong) SDTXTReaderTopView *topView;
@property (nonatomic, strong) SDTXTReaderBottomView *bottomView;
@property (nonatomic, strong) SDTXTReaderMenuView *menuView;

@end

@implementation SDTXTReaderLayoutView

- (BOOL)status {
    if ([UIApplication sharedApplication].statusBarFrame.size.height > 20) {
        return NO;
    }
    return _status;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.topView];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo([UIApplication sharedApplication].statusBarFrame.size.height + 44);
        }];
        
        [self addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.height.mas_equalTo(self.bottomView.extensionHeight);
        }];
        
        [self addSubview:self.menuView];
        [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (SDTXTReaderTopView *)topView {
    if (!_topView) {
        _topView = [[SDTXTReaderTopView alloc] init];
    }
    return _topView;
}

- (SDTXTReaderBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[SDTXTReaderBottomView alloc] init];
    }
    return _bottomView;
}

- (SDTXTReaderMenuView *)menuView {
    if (!_menuView) {
        _menuView = [[SDTXTReaderMenuView alloc] init];
    }
    return _menuView;
}

- (void)hide:(id)hidden {
    [self setHidden:[hidden boolValue]];
}

#pragma mark - SDTXTReaderLayoutProtocol -

- (void)close {
    [self.delegate close];
}

- (void)updateAppearance {
    [self resumeSomething];
    if (_status) {
        [self.topView show];
        [self.bottomView show];
    }else {
        [self.topView dismiss];
        [self.bottomView dismiss];
    }
    _status = !_status;
    [self continueSomething];
    
    [self.delegate updateAppearance];
}

- (void)resumeSomething {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)continueSomething {
    if (!_status) {
        self.hidden = _status;
        [self performSelector:@selector(updateAppearance) withObject:nil afterDelay:kSDTXTReaderLayoutDismissDaly];
    }else{
        [self performSelector:@selector(hide:) withObject:@(YES) afterDelay:kSDTXTReaderLayoutAnimateDuration];
    }
}

- (void)next {
    [self.delegate next];
}

- (void)last {
    [self.delegate last];
}

- (void)index:(NSInteger)index {
    [self.delegate index:index];
}

- (void)showCatalog {
    [self.menuView show];
    [self updateAppearance];
    [self resumeSomething];
}

- (void)mark:(NSInteger)chapter offset:(NSInteger)offset {
    [self.delegate mark:chapter offset:offset];
}

@end
