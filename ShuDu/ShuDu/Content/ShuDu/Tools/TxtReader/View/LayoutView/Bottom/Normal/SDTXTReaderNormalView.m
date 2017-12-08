//
//  SDTXTReaderNormalView.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/7.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderNormalView.h"

#import "SDTXTConfigModel.h"
#import "SDTXTReader.h"
#import "SDImage.h"
#import "UIView+Line.h"
#import "SDTXTReaderLayoutProtocol.h"

#import "SDTXTReaderNormalProgressView.h"

extern CGFloat const kSDTXTReaderLayoutAnimateDuration;

@interface SDTXTReaderNormalView () <SDTXTReaderLayoutProtocol>
{
    SDTXTReaderNormalProgressView *_progressView;
}

@end

@implementation SDTXTReaderNormalView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [SDTXTConfigModel sharedInstance].themeColor;
        self.layer.shadowOffset = CGSizeMake(0, -0.1);
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.1;
        
        _height = 88.f;
        
        _progressView = [[SDTXTReaderNormalProgressView alloc] init];
        [self addSubview:_progressView];
        
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(44.f);
        }];
        
        [_progressView showLine:SSLinePositionBottom];
        
        UIButton *catalogBt = [[UIButton alloc] init];
        [catalogBt setImage:[SDImage menuImage] forState:UIControlStateNormal];
        [catalogBt addTarget:self action:@selector(showCatalog) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:catalogBt];
        
        [catalogBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self);
            make.top.equalTo(_progressView.mas_bottom);
            make.width.equalTo(catalogBt.mas_height);
        }];
        
        UIButton *aloudBt = [[UIButton alloc] init];
        [aloudBt setImage:[SDImage headPhoneImage] forState:UIControlStateNormal];
        [aloudBt addTarget:self action:@selector(aloud) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:aloudBt];
        
        [aloudBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self);
            make.top.equalTo(_progressView.mas_bottom);
            make.width.equalTo(aloudBt.mas_height);
        }];
        
        UIButton *fontBt = [[UIButton alloc] init];
        [fontBt setTitle:@"Aa" forState:UIControlStateNormal];
        [fontBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [fontBt addTarget:self action:@selector(fontSetting) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:fontBt];
        
        [fontBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self);
            make.top.equalTo(_progressView.mas_bottom);
            make.width.equalTo(fontBt.mas_height);
        }];
        
        [self showLine:SSLinePositionTop];
    }
    return self;
}

- (void)showCatalog {
    [[SDTXTReader sharedInstance].layoutView showCatalog];
}

- (void)aloud {
    
}

- (void)fontSetting {
    
}

#pragma mark - SDTXTReaderAnimatedProtocol -

- (void)show {
    [UIView animateWithDuration:kSDTXTReaderLayoutAnimateDuration animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:kSDTXTReaderLayoutAnimateDuration animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformMakeTranslation(0, _height);
    }];
}

#pragma mark - SDTXTReaderLayoutProtocol -

- (void)lastChapter {
    [[SDTXTReader sharedInstance].layoutView last];
}

- (void)nextChapter {
    [[SDTXTReader sharedInstance].layoutView next];
}

- (void)gestureStart {
    [[SDTXTReader sharedInstance].layoutView resumeSomething];
}

- (void)gestureEnd {
    [[SDTXTReader sharedInstance].layoutView continueSomething];
}

@end
