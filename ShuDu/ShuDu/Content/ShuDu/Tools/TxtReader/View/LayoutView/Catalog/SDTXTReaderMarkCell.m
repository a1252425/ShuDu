//
//  SDTXTReaderMarkCell.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/8.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderMarkCell.h"
#import "SDTXTReaderMarkModel.h"
#import "UIView+Line.h"

@interface SDTXTReaderMarkCell ()
{
    UILabel *_markLabel, *_chapterLabel, *_timeLabel;
}

@end

@implementation SDTXTReaderMarkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(12);
            make.bottom.equalTo(self).offset(-12);
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
        }];
        
        [contentView showLine:SSLinePositionBottom];
        
        _chapterLabel = [[UILabel alloc] init];
        _chapterLabel.font = [UIFont systemFontOfSize:12];
        _chapterLabel.textColor = [UIColor lightGrayColor];
        [contentView addSubview:_chapterLabel];
        
        [_chapterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(contentView);
        }];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor lightGrayColor];
        [contentView addSubview:_timeLabel];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(contentView);
        }];
        
        _markLabel = [[UILabel alloc] init];
        _markLabel.font = [UIFont systemFontOfSize:14];
        _markLabel.textColor = [UIColor darkGrayColor];
        _markLabel.numberOfLines = 2;
        [contentView addSubview:_markLabel];
        
        [_markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(contentView);
            make.top.equalTo(_chapterLabel.mas_bottom).offset(12);
        }];
    }
    return self;
}

- (void)setMark:(SDTXTReaderMarkModel *)mark {
    _mark = mark;
    
    _chapterLabel.text = _mark.title;
    _markLabel.text = _mark.content;
    _timeLabel.text = [self dateToTimeString:_mark.date];
}

- (NSString *)dateToTimeString:(NSDate *)date {
    NSTimeInterval seconds = [[NSDate date] timeIntervalSinceDate:date];
    
    if (seconds < 60) {
        return @"一分钟内";
    }
    
    if (seconds < 60 * 60) {
        NSInteger minutes = seconds / 60;
        return [NSString stringWithFormat:@"%@分钟前", @(minutes)];
    }
    
    if (seconds < 60 * 60 * 24) {
        NSInteger hours = seconds / 3600;
        return [NSString stringWithFormat:@"%@小时前", @(hours)];
    }
    
    if (seconds < 60 * 60 * 24 * 30) {
        NSInteger days = seconds / (60 * 60 * 24 * 30);
        return [NSString stringWithFormat:@"%@天前", @(days)];
    }
    
    if (seconds < 60 * 60 * 24 * 30 * 365) {
        NSInteger months = seconds / (60 * 60 * 24 * 30 * 365);
        return [NSString stringWithFormat:@"%@月前", @(months)];
    }
    
    return @"很久前";
}

@end

