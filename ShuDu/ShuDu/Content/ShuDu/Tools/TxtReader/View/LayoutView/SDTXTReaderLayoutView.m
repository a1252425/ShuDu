//
//  SDTXTReaderLayoutView.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/6.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderLayoutView.h"
#import "SDTXTReaderAmiatedProtocol.h"

#import "SDTXTReaderTopView.h"
#import "SDTXTReaderBottomView.h"

CGFloat const kSDTXTReaderLayoutAnimateDuration = 0.4f;

@interface SDTXTReaderLayoutView ()
{
    NSMutableArray<UIView<SDTXTReaderAmiatedProtocol> *> *_views;
    SDTXTRecordModel *_recordModel;
}

@property (nonatomic, strong) SDTXTReaderTopView *topView;
@property (nonatomic, strong) SDTXTReaderBottomView *bottomView;

@end

@implementation SDTXTReaderLayoutView

- (BOOL)status {
    if ([UIApplication sharedApplication].statusBarFrame.size.height > 20) {
        return NO;
    }
    return _status;
}

- (instancetype)initWithRecord:(SDTXTRecordModel *)recordModel
{
    self = [super init];
    if (self) {
        
        _recordModel = recordModel;
        _views = [NSMutableArray array];
        
        [self addSubview:self.topView];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo([UIApplication sharedApplication].statusBarFrame.size.height + 44);
        }];
        
        [_views addObject:self.topView];
    }
    return self;
}

- (SDTXTReaderTopView *)topView {
    if (!_topView) {
        _topView = [[SDTXTReaderTopView alloc] initWithRecord:_recordModel];
        _topView.delegate = self;
    }
    return _topView;
}

- (SDTXTReaderBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[SDTXTReaderBottomView alloc] init];
    }
    return _bottomView;
}

#pragma mark - SDTXTReaderLayoutProtocol -

- (void)close {
    if ([self.delegate respondsToSelector:@selector(close)]) {
        [self.delegate close];
    }
}

- (void)updateAppearance {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    _status = !self.hidden;
    if (self.hidden) {
        self.hidden = NO;
        for (UIView<SDTXTReaderAmiatedProtocol> *view in _views) {
            [view show];
        }
    }
    else {
        for (UIView<SDTXTReaderAmiatedProtocol> *view in _views) {
            [view dismiss];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kSDTXTReaderLayoutAnimateDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.hidden = YES;
        });
    }
    if (!_status) {
        [self performSelector:@selector(updateAppearance) withObject:nil afterDelay:3.8];
    }
    if ([self.delegate respondsToSelector:@selector(updateAppearance)]) {
        [self.delegate updateAppearance];
    }
}

@end
