//
//  SDFileAddCell.m
//  ShuDu
//
//  Created by 邵帅 on 2017/11/22.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDFileAddCell.h"
#import "SDFileAddItemModel.h"

@interface SDFileAddCell ()
{
    UILabel *_titleLabel;
    UIImageView *_imageView;
}

@end

@implementation SDFileAddCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(4);
            make.right.equalTo(self).offset(-4);
            make.bottom.equalTo(self).offset(-28);
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(_imageView.mas_bottom);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}

- (void)setItemModel:(SDFileAddItemModel *)itemModel {
//    _itemModel = itemModel;
    _imageView.image = itemModel.image;
    _titleLabel.text = itemModel.title;
}

@end
