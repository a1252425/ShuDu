//
//  SDFileCell.m
//  ShuDu
//
//  Created by 邵帅 on 2017/11/22.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDFileCell.h"
#import "SDFileModel.h"
#import "SDImage.h"

@interface SDFileCell ()
{
    UIImageView *_imageView, *_detailImageView;
    UILabel *_nameLabel;
}

@end

@implementation SDFileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentView];
        
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(8);
            make.right.equalTo(self).offset(-8);
            make.top.equalTo(self).offset(4);
            make.bottom.equalTo(self).offset(-4);
        }];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [contentView addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(12);
            make.top.equalTo(contentView).offset(8);
            make.bottom.equalTo(contentView).offset(-8);
            make.width.equalTo(_imageView.mas_height);
        }];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [contentView addSubview:_nameLabel];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imageView.mas_right).offset(8);
            make.centerY.equalTo(contentView);
        }];
        
        contentView.layer.cornerRadius = 4.f;
        contentView.layer.shadowOffset = CGSizeMake(0, 1);
        contentView.layer.shadowColor = [UIColor blackColor].CGColor;
        contentView.layer.shadowOpacity = 0.1;
        
        _detailImageView = [[UIImageView alloc] init];
        _detailImageView.contentMode = UIViewContentModeScaleAspectFit;
        _detailImageView.image = [SDImage detailImage];
        [contentView addSubview:_detailImageView];
        
        [_detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(contentView);
            make.right.equalTo(contentView).offset(-12);
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(16);
        }];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
        longPress.minimumPressDuration = 0.7;
        [self addGestureRecognizer:longPress];
    }
    return self;
}

- (void)longPressHandler:(UILongPressGestureRecognizer *)gesture {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *openAction = [UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *copyAction = [UIAlertAction actionWithTitle:@"复制" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cutAction = [UIAlertAction actionWithTitle:@"剪切" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *pasteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        if ([_delegate respondsToSelector:@selector(cell:deleteAtIndexPath:)]) {
//            [_delegate cell:self deleteAtIndexPath:_indexPath];
//        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL];
    [alertController addAction:openAction];
    [alertController addAction:copyAction];
    [alertController addAction:cutAction];
    [alertController addAction:pasteAction];
    [alertController addAction:cancelAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:NULL];
}

- (void)setFileModel:(SDFileModel *)fileModel {
    _nameLabel.text = fileModel.name;
    
    switch (fileModel.type) {
        case SDFileTypeDirectory:
            _imageView.image = [SDImage txtFileImage];
            break;
          
        case SDFileTypeTxt:
            _imageView.image = [SDImage txtFileImage];
            break;
            
        case SDFileTypeDoc:
            _imageView.image = [SDImage wordFileImage];
            break;
            
        case SDFileTypePPT:
            _imageView.image = [SDImage pptFileImage];
            break;
            
        case SDFileTypeExcel:
            _imageView.image = [SDImage excelFileImage];
            break;
            
        case SDFileTypeVideo:
            _imageView.image = [SDImage videoImage];
            break;
            
        default:
            _imageView.image = [SDImage defaultFileImage];
            break;
    }
}

@end
