//
//  SDTXTChapterModel.h
//  ShuDu
//
//  Created by 邵帅 on 2017/12/5.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SSModel.h"

@class SDTXTPageModel, SDTXTReaderMarkModel, SDFileModel;

@interface SDTXTChapterModel : SSModel

@property (nonatomic, weak) SDFileModel *fileModel;
@property (nonatomic, assign) NSInteger chapter;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content;

//  获取页码范围
- (NSRange)rangeOfPage:(NSInteger)page;

//  根据字体大小和区域，更新页面数量
- (void)updatePage:(CGFloat)fontSize bounds:(CGRect)bounds;

//  更具页码获取model
- (SDTXTPageModel *)contentOfPage:(NSInteger)page;

//  为当前页面做标签
- (SDTXTReaderMarkModel *)markPage:(NSInteger)page;

- (NSInteger)pageOfOffset:(NSInteger)offset;

@end
