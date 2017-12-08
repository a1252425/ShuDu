//
//  SDTXTRecordModel.h
//  ShuDu
//
//  Created by 邵帅 on 2017/12/5.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SSModel.h"

@class SDFileModel, SDTXTChapterModel, SDTXTReaderMarkModel;

@interface SDTXTRecordModel : SSModel

@property (nonatomic, assign) NSInteger chapterCount;
@property (nonatomic, assign) NSInteger chapter;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSArray<SDTXTReaderMarkModel *> *bookmarks;
@property (nonatomic, weak) SDTXTChapterModel *chapterModel;

+ (instancetype)recordOfFile:(SDFileModel *)fileModel;

//  添加书签
- (void)addBookmark;

//  查询书签
- (SDTXTReaderMarkModel *)currentBookMark;

//  删除书签
- (void)deleteBookmark;

//  实时缓存
- (void)cache;

@end
