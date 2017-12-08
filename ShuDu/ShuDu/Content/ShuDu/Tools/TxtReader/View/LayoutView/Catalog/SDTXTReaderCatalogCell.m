//
//  SDTXTReaderCatalogCell.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/8.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderCatalogCell.h"
#import "SDTXTChapterModel.h"
#import "UIView+Line.h"

@interface SDTXTReaderCatalogCell ()
{
    UILabel *_chapterLabel;
}

@end

@implementation SDTXTReaderCatalogCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
        }];
        
        [contentView showLine:SSLinePositionBottom];
        
        _chapterLabel = [[UILabel alloc] init];
        _chapterLabel.font = [UIFont systemFontOfSize:14];
        _chapterLabel.textColor = [UIColor lightGrayColor];
        [contentView addSubview:_chapterLabel];
        
        [_chapterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.equalTo(contentView);
            make.width.lessThanOrEqualTo(contentView);
        }];
    }
    return self;
}

- (void)setChapter:(SDTXTChapterModel *)chapter {
    _chapter = chapter;
    
    _chapterLabel.text = chapter.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        _chapterLabel.textColor = [UIColor blackColor];
    }else
        _chapterLabel.textColor = [UIColor lightGrayColor];
}

@end
