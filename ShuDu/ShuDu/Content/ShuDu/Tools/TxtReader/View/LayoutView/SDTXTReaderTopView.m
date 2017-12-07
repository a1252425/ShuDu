//
//  SDTXTReaderTopView.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/6.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderTopView.h"

#import "UIView+Line.h"
#import "SDImage.h"

#import "SDTXTConfigModel.h"
#import "SDTXTReaderMarkModel.h"
#import "SDTXTRecordModel.h"

#define kSDTXTReaderTopViewHeight   44.f

extern CGFloat const kSDTXTReaderLayoutAnimateDuration;

@interface SDTXTReaderTopView ()
{
    UIButton *_storeBt;
    SDTXTRecordModel *_recordModel;
}

@end

@implementation SDTXTReaderTopView

@synthesize recordModel = _recordModel;

- (instancetype)initWithRecord:(SDTXTRecordModel *)recordModel
{
    self = [super init];
    if (self) {
        
        _recordModel = recordModel;
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.1;
        self.layer.shadowOffset = CGSizeMake(0, 0.1);
        self.backgroundColor = [SDTXTConfigModel sharedInstance].themeColor;
        
        UIButton *closeBt = [[UIButton alloc] init];
        [closeBt setImage:[SDImage closeImage] forState:UIControlStateNormal];
        [closeBt addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBt];
        
        [closeBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(8);
            make.bottom.equalTo(self);
            make.width.height.mas_equalTo(kSDTXTReaderTopViewHeight);
        }];
        
        [self showLine:SSLinePositionBottom];
        
        _storeBt = [[UIButton alloc] init];
        [_storeBt setImage:[SDImage storeImage] forState:UIControlStateNormal];
        [_storeBt setImage:[SDImage storedImage] forState:UIControlStateSelected];
        [_storeBt addTarget:self action:@selector(store:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_storeBt];
        
        [_storeBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self);
            make.width.height.mas_equalTo(kSDTXTReaderTopViewHeight);
        }];
        
        _storeBt.selected = [self hadMarked];
    }
    return self;
}

- (CGFloat)height {
    if (_height == 0) {
        _height = [UIApplication sharedApplication].statusBarFrame.size.height + kSDTXTReaderTopViewHeight;
    }
    return _height;
}

- (void)close {
    if ([self.delegate respondsToSelector:@selector(close)]) {
        [self.delegate close];
    }
}

- (void)store:(UIButton *)button {
    button.selected = !button.selected;
    
    if (button.selected) {
        [_recordModel addBookmark];
    }else
        [_recordModel deleteBookmark];
}

- (void)show {
    [UIView animateWithDuration:kSDTXTReaderLayoutAnimateDuration animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
    _storeBt.selected = [self hadMarked];
}

- (void)dismiss {
    [UIView animateWithDuration:kSDTXTReaderLayoutAnimateDuration animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformMakeTranslation(0, -self.height);
    }];
}

- (BOOL)hadMarked {
    return [_recordModel currentBookMark];
}

@end
