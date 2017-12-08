//
//  SDTXTReaderNormalProgressView.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/7.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderNormalProgressView.h"

#import "SDTXTReader.h"
#import "SDTXTReaderLayoutProtocol.h"
#import "SDTXTRecordModel.h"

@interface SDTXTReaderNormalProgressView ()
{
    UIButton *_lastChapterBt, *_nextChapterBt;
    UIView *_totalView, *_progressView, *_dragView;
    CGFloat _dragSize;
}

@end

@implementation SDTXTReaderNormalProgressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _total = [SDTXTReader sharedInstance].recordModel.chapterCount;
        _index = [SDTXTReader sharedInstance].recordModel.chapter;
        
        _lastChapterBt = [[UIButton alloc] init];
        _lastChapterBt.titleLabel.font = [UIFont systemFontOfSize:14];
        [_lastChapterBt setTitle:SD(@"上一章") forState:UIControlStateNormal];
        [_lastChapterBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_lastChapterBt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_lastChapterBt addTarget:self action:@selector(lastChapter) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_lastChapterBt];
        
        [_lastChapterBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(12);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(self.mas_height);
        }];
        
        _nextChapterBt = [[UIButton alloc] init];
        _nextChapterBt.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextChapterBt setTitle:SD(@"下一章") forState:UIControlStateNormal];
        [_nextChapterBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_nextChapterBt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_nextChapterBt addTarget:self action:@selector(nextChapter) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nextChapterBt];
        
        [_nextChapterBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(self).offset(-12);
            make.width.mas_equalTo(self.mas_height);
        }];
        
        //  进度
        
        _dragSize = 8.f;
        
        _totalView = [[UIView alloc] init];
        _totalView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_totalView];
        
        [_totalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_lastChapterBt.mas_right).offset(8+_dragSize/2);
            make.right.equalTo(_nextChapterBt.mas_left).offset(-8-_dragSize/2);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(1.5);
        }];
        
        _progressView = [[UIView alloc] init];
        _progressView.backgroundColor = [UIColor blackColor];
        [self addSubview:_progressView];
        
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.height.equalTo(_totalView);
            make.right.lessThanOrEqualTo(_totalView);
        }];
        
        _dragView = [[UIView alloc] init];
        _dragView.backgroundColor = [UIColor lightGrayColor];;
        _dragView.layer.borderColor = [UIColor blackColor].CGColor;
        _dragView.layer.borderWidth = 0.5;
        _dragView.layer.cornerRadius = _dragSize/2;
        [self addSubview:_dragView];
        
        [_dragView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_totalView).offset(-_dragSize/2);
            make.centerY.equalTo(_totalView);
            make.width.height.mas_equalTo(_dragSize);
        }];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
        [_dragView addGestureRecognizer:pan];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
        [_totalView addGestureRecognizer:tap];
    }
    return self;
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    
    [self setIndex:_index];
}

- (void)lastChapter {
    [[SDTXTReader sharedInstance].layoutView resumeSomething];
    [[SDTXTReader sharedInstance].layoutView last];
    [[SDTXTReader sharedInstance].layoutView continueSomething];
    self.index -= 1;
}

- (void)nextChapter {
    [[SDTXTReader sharedInstance].layoutView resumeSomething];
    [[SDTXTReader sharedInstance].layoutView next];
    [[SDTXTReader sharedInstance].layoutView continueSomething];
    self.index += 1;
}

- (void)setIndex:(NSInteger)index {
    if (index < 0 || index >= _total) {
        return;
    }
    _index = index;
    if (_total <= 0) {
        return;
    }
    CGFloat x = ((CGFloat)_index+1.f)/((CGFloat)_total) * CGRectGetWidth(_totalView.frame);
    if (x <= 0) {
        return;
    }
    _dragView.transform = CGAffineTransformMakeTranslation(x, 0);
    
    [_progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(x);
    }];
}

#pragma mark - gesture -

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect expandArea = CGRectInset(_dragView.frame, -20, -20);
    if (CGRectContainsPoint(expandArea, point)) {
        return _dragView;
    }
    expandArea = CGRectInset(_totalView.frame, 0, -20);
    if (CGRectContainsPoint(expandArea, point)) {
        return _totalView;
    }
    return [super hitTest:point withEvent:event];
}

- (void)panHandler:(UIPanGestureRecognizer *)gesture {
    UIGestureRecognizerState state = gesture.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:
            [[SDTXTReader sharedInstance].layoutView resumeSomething];
            break;
            
        case UIGestureRecognizerStateChanged:
            [self positionChange:[gesture locationInView:_totalView]];
            break;
            
        default:
            [[SDTXTReader sharedInstance].layoutView continueSomething];
            break;
    }
}

- (void)tapHandler:(UITapGestureRecognizer *)gesture {
    [[SDTXTReader sharedInstance].layoutView resumeSomething];
    [self positionChange:[gesture locationInView:_totalView]];
    [[SDTXTReader sharedInstance].layoutView continueSomething];
}

- (void)positionChange:(CGPoint)point {
    if (point.x < 0 || point.x > CGRectGetWidth(_totalView.frame)) {
        return;
    }
    
    CGFloat progress = point.x/CGRectGetWidth(_totalView.frame) * _total;  //  获取页码大致位置
    NSInteger index = progress; //  页码整数化
    if (progress - index >= 0.5 && index + 1 < _total) index += 1;    //  页码小数位大于0.5，为下一页
    NSLog(@"%@", @(index));
    if (_index != index) {
        self.index = index;
        [[SDTXTReader sharedInstance].layoutView index:index];
    }
}

@end
