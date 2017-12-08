//
//  SDTXTRecordModel.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/5.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTRecordModel.h"

#import "SDFileModel.h"
#import "SDTXTChapterModel.h"
#import "SDTXTReaderMarkModel.h"

@interface SDTXTRecordModel ()
{
    NSOperationQueue *_recordQueue;
    SDFileModel *_fileModel;
}
@property (nonatomic, strong) SDFileModel *fileModel;

@end

@implementation SDTXTRecordModel

/*
 *  加载缓存：名字+md5
 */

+ (instancetype)recordOfFile:(SDFileModel *)fileModel {
    NSString *cacheName = [NSString stringWithFormat:@"%@-%@.cache", fileModel.name, fileModel.md5];
    NSString *cacheFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:cacheName];
    SDTXTRecordModel *recordModel = [NSKeyedUnarchiver unarchiveObjectWithFile:cacheFilePath];
    if (!recordModel) recordModel = [[SDTXTRecordModel alloc] init];
    [recordModel setFileModel:fileModel];
    return recordModel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _chapter = 0;
        _page = 0;
        _chapterCount = 1;
        
        _bookmarks = [NSArray array];
    }
    return self;
}

- (void)setFileModel:(SDFileModel *)fileModel {
    _fileModel = fileModel;
}

- (void)addBookmark {
    NSMutableArray *bookmarks = [NSMutableArray arrayWithArray:_bookmarks];
    SDTXTReaderMarkModel *markModel = [_chapterModel markPage:_page];
    if (markModel) [bookmarks addObject:markModel];
    self.bookmarks = bookmarks;
    [self cache];
}

- (SDTXTReaderMarkModel *)currentBookMark {
    NSRange pageRange = [_chapterModel rangeOfPage:_page];
    for (SDTXTReaderMarkModel *markModel in _bookmarks) {
        if (markModel.offset >= pageRange.location && markModel.offset < pageRange.location + pageRange.length) {
            return markModel;
        }
    }
    return NULL;
}

- (void)deleteBookmark {
    NSRange pageRange = [_chapterModel rangeOfPage:_page];
    NSMutableArray *bookMarks = [NSMutableArray arrayWithArray:_bookmarks];
    for (SDTXTReaderMarkModel *markModel in bookMarks) {
        if (markModel.offset >= pageRange.location && markModel.offset <= pageRange.location + pageRange.length) {
            [bookMarks removeObject:markModel];
            self.bookmarks = bookMarks;
            [self cache];
            break;
        }
    }
}

- (void)cache {
    if (!_recordQueue) {
        _recordQueue = [[NSOperationQueue alloc] init];
        _recordQueue.maxConcurrentOperationCount = 1;
    }
    [_recordQueue addOperationWithBlock:^{
        NSString *cacheName = [NSString stringWithFormat:@"%@-%@.cache", _fileModel.name, _fileModel.md5];
        NSString *cacheFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:cacheName];
        if ([NSKeyedArchiver archiveRootObject:self toFile:cacheFilePath]) {
            NSLog(@"record cache");
        }
        else
            NSLog(@"record cache fail");
    }];
}

@end
