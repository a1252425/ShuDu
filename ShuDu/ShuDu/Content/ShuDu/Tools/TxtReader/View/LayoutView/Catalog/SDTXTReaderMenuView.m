//
//  SDTXTReaderCatalogView.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/8.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderMenuView.h"
#import "SDTXTReaderCatalogView.h"
#import "SDTXTReaderNoteView.h"
#import "SDTXTReaderMarkView.h"
#import "SDTXTReaderMenuContentView.h"

#import "SDTXTConfigModel.h"

@interface SDTXTReaderMenuView ()
{
    UIView *_tapView;
    SDTXTReaderMenuContentView *_contentView;
}

@property (nonatomic, strong) SDTXTReaderCatalogView *catalogView;
@property (nonatomic, strong) SDTXTReaderNoteView *noteView;
@property (nonatomic, strong) SDTXTReaderMarkView *markView;

@end

@implementation SDTXTReaderMenuView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.hidden = YES;
        
        _tapView = [[UIView alloc] init];
        _tapView.backgroundColor = [UIColor blackColor];
        _tapView.layer.opacity = 0;
        [self addSubview:_tapView];
        
        [_tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
        [_tapView addGestureRecognizer:tap];
        
        _contentView = [[SDTXTReaderMenuContentView alloc] initWithViews:@[self.catalogView, self.noteView, self.markView] titles:@[SD(@"目录"), SD(@"笔记"), SD(@"书签")]];
        _contentView.backgroundColor = [SDTXTConfigModel sharedInstance].themeColor;
        _contentView.layer.shadowColor = [UIColor blackColor].CGColor;
        _contentView.layer.shadowOpacity = 0.3;
        _contentView.layer.shadowOffset = CGSizeMake(1, 0);
        [self addSubview:_contentView];
        
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(self.mas_left);
            make.width.equalTo(self).multipliedBy(0.7);
        }];
    }
    return self;
}

- (SDTXTReaderCatalogView *)catalogView {
    if (!_catalogView) {
        _catalogView = [[SDTXTReaderCatalogView alloc] init];
    }
    return _catalogView;
}

- (SDTXTReaderNoteView *)noteView {
    if (!_noteView) {
        _noteView = [[SDTXTReaderNoteView alloc] init];
    }
    return _noteView;
}

- (SDTXTReaderMarkView *)markView {
    if (!_markView) {
        _markView = [[SDTXTReaderMarkView alloc] init];
    }
    return _markView;
}

- (void)tapHandler:(UITapGestureRecognizer *)gesture {
    [self dismiss];
}

#pragma mark - SDTXTReaderAnimatedProtocol -

- (void)show {
    self.hidden = NO;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _contentView.transform = CGAffineTransformMakeTranslation(self.frame.size.width*0.7, 0);
        _tapView.layer.opacity = 0.5;
    } completion:NULL];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _contentView.transform = CGAffineTransformIdentity;
        _tapView.layer.opacity = 0.0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.superview.hidden = YES;
    }];
}

@end
