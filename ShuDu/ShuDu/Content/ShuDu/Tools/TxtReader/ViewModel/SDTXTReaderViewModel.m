//
//  SDTXTReaderViewModel.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/4.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderViewModel.h"

#import "SDFileModel.h"
#import "SDFileManager.h"
#import "SDTXTChapterModel.h"
#import "SDTXTRecordModel.h"
#import "SDTXTConfigModel.h"

#import "SDTXTReaderPageViewController.h"

#define kSDTXTReaderViewModelBeforeChapter  @"前言"

@interface SDTXTReaderViewModel ()
{
    SDFileModel *_fileModel;
    
    NSInteger _chapter, _page;
    NSInteger _chapterChange, _pageChange;
}

@end

@implementation SDTXTReaderViewModel

- (instancetype)initWithFile:(SDFileModel *)fileModel {
    if (self = [super init]) {
        _fileModel = fileModel;
        _chapter = 0;
        
        [self transforContentToChapters];
        
        _recordModel = [SDTXTRecordModel recordOfFile:_fileModel];
        _recordModel.chapterCount = _chapters.count;
        _chapter = _recordModel.chapter;
        _page = _recordModel.page;
        _recordModel.chapterModel = [self chapterAtIndex:_chapter];
    }
    return self;
}

/*  *
 *  加载TXT文件内容:
 *  TXT分带编码和不带编码两种，带编码的如UTF-8格式TXT，不带编码的如ANSI格式TXT
 *  带编码的，尝试NSUTF8StringEncoding编码
 *  不带编码的，可以依次尝试GBK（0x80000632）和GB18030（0x80000631）编码
 *
 *  分章逻辑：
 *  1、使用正则表达式，找到各章节标题位置，生产数组；
 *  2、遍历章节标题数组；
 *  3、第一章之前的为开始，自定义标题为 文件名；
 *  4、根据当前章节的range和上一章的range，实例化上一章内容；
 *  5、当遍历到最后一章，将最后一章实例化。
 */

- (void)transforContentToChapters {
    
    NSError *error;
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:_fileModel.path];
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (!content) {
        //  用GBK进行编码
        content = [NSString stringWithContentsOfFile:filePath encoding:0x80000632 error:&error];
    }
    if (!content) {
        //  用GBK编码不行,再用GB18030编码
        content = [NSString stringWithContentsOfFile:filePath encoding:0x80000631 error:&error];
    }
    if (!content) {
        content = @"";
    }
    
    NSString *pattern = @"第[0-9一二三四五六七八九十百千]*[章回].*";
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *match = [expression matchesInString:content options:NSMatchingReportCompletion range:NSMakeRange(0, content.length)];
    if (match.count == 0) {
        SDTXTChapterModel *model = [[SDTXTChapterModel alloc] initWithTitle:kSDTXTReaderViewModelBeforeChapter content:content];
        model.fileModel = _fileModel;
        _chapters = @[model];
        return;
    }
    
    NSMutableArray *chapters = [NSMutableArray array];
    __block NSRange chapterRange = NSMakeRange(0, 0);
    [match enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [obj range];
        NSInteger location = range.location;
        if (idx == 0) {
            SDTXTChapterModel *model = [[SDTXTChapterModel alloc] initWithTitle:_fileModel.name content:[content substringWithRange:NSMakeRange(0, location)]];
            model.fileModel = _fileModel;
            model.chapter = idx;
            [chapters addObject:model];
        }
        else if (idx > 0) {
            NSUInteger len = location - chapterRange.location;
            SDTXTChapterModel *model = [[SDTXTChapterModel alloc] initWithTitle:[content substringWithRange:chapterRange] content:[content substringWithRange:NSMakeRange(chapterRange.location, len)]];
            model.fileModel = _fileModel;
            model.chapter = idx;
            [chapters addObject:model];
        }
        if (idx == match.count-1) {
            NSUInteger len = content.length - location;
            SDTXTChapterModel *model = [[SDTXTChapterModel alloc] initWithTitle:[content substringWithRange:range] content:[content substringWithRange:NSMakeRange(location, len)]];
            model.fileModel = _fileModel;
            model.chapter = match.count;
            [chapters addObject:model];
        }
        chapterRange = range;
    }];
    
    _chapters = [NSMutableArray arrayWithArray:chapters];
}

- (SDTXTChapterModel *)chapterAtIndex:(NSInteger)index {
    SDTXTChapterModel *chapterModel;
    if (index >= _chapters.count) {
        chapterModel = _chapters.lastObject;
    }
    else if (index <= 0) {
        chapterModel = _chapters.firstObject;
    }
    else
        chapterModel = _chapters[index];
    if (chapterModel.pageCount == 0) {
        [chapterModel updatePage:[SDTXTConfigModel sharedInstance].fontSize bounds:[SDTXTConfigModel sharedInstance].bounds];
    }
    return chapterModel;
}

- (UIViewController *)currentPageViewController {
    SDTXTChapterModel *chapterModel = [self chapterAtIndex:_chapter];
    _recordModel.chapterModel = chapterModel;
    SDTXTReaderPageViewController *controller = [[SDTXTReaderPageViewController alloc] initWithPage:[chapterModel contentOfPage:_page]];
    return controller;
}

- (UIViewController *)nextPageViewController {
    SDTXTChapterModel *chapterModel = [self chapterAtIndex:_chapter];
    _chapterChange = _chapter;
    _pageChange = _page;
    if (_chapter >= _chapters.count - 1 && _pageChange >= chapterModel.pageCount - 1) {
        return NULL;
    }
    if (_pageChange >= chapterModel.pageCount - 1) {
        _pageChange = 0;
        chapterModel = [self chapterAtIndex:++_chapterChange];
        [chapterModel updatePage:[SDTXTConfigModel sharedInstance].fontSize bounds:[SDTXTConfigModel sharedInstance].bounds];
    }
    else
        _pageChange ++;
    
    SDTXTReaderPageViewController *controller = [[SDTXTReaderPageViewController alloc] initWithPage:[chapterModel contentOfPage:_pageChange]];
    return controller;
}

- (UIViewController *)lastPageViewController {
    SDTXTChapterModel *chapterModel = [self chapterAtIndex:_chapter];
    _chapterChange = _chapter;
    _pageChange = _page;
    
    if (_chapterChange == 0 && _pageChange == 0) {
        return NULL;
    }
    
    if (_pageChange <= 0) {
        chapterModel = [self chapterAtIndex:--_chapterChange];
        _pageChange = chapterModel.pageCount-1;
    }
    else
        _pageChange--;
    
    SDTXTReaderPageViewController *controller = [[SDTXTReaderPageViewController alloc] initWithPage:[chapterModel contentOfPage:_pageChange]];
    return controller;
}

- (void)willTransition {
    _chapter = _chapterChange;
    _page = _pageChange;
}

- (void)finishTransition:(BOOL)completed {
    if (!completed) {
        _chapter = _recordModel.chapter;
        _page = _recordModel.page;
    }
    else {
        _recordModel.chapter = _chapter;
        _recordModel.page = _page;
        _recordModel.chapterModel = [self chapterAtIndex:_chapter];
        [_recordModel cache];
    }
}

- (UIViewController *)pageViewController:(NSInteger)chapter page:(NSInteger)page {
    SDTXTChapterModel *chapterModel = [self chapterAtIndex:chapter];
    if (chapterModel.pageCount == 0) {
        [chapterModel updatePage:[SDTXTConfigModel sharedInstance].fontSize bounds:[SDTXTConfigModel sharedInstance].bounds];
    }
    return [[SDTXTReaderPageViewController alloc] initWithPage:[chapterModel contentOfPage:_pageChange]];
}

- (UIViewController *)nextChapterViewController {
    _chapterChange = _chapter;
    _pageChange = 0;
    if (_chapterChange >= _chapters.count - 1) {
        return NULL;
    }
    _chapterChange += 1;
    SDTXTChapterModel *chapterModel = [self chapterAtIndex:_chapterChange];
    return [[SDTXTReaderPageViewController alloc] initWithPage:[chapterModel contentOfPage:_pageChange]];
}

- (UIViewController *)lastChapterViewController {
    _chapterChange = _chapter;
    _pageChange = 0;
    if (_chapterChange <= 0) {
        return NULL;
    }
    _chapterChange -= 1;
    SDTXTChapterModel *chapterModel = [self chapterAtIndex:_chapterChange];
    return [[SDTXTReaderPageViewController alloc] initWithPage:[chapterModel contentOfPage:_pageChange]];
}

- (UIViewController *)chapterViewController:(NSInteger)chapter {
    _chapterChange = chapter;
    _pageChange = 0;
    if (_chapterChange < 0 || _chapterChange >= _chapters.count) {
        return NULL;
    }
    SDTXTChapterModel *chapterModel = [self chapterAtIndex:_chapterChange];
    return [[SDTXTReaderPageViewController alloc] initWithPage:[chapterModel contentOfPage:_pageChange]];
}

- (UIViewController *)chapterViewController:(NSInteger)chapter offset:(NSInteger)offset {
    _chapterChange = chapter;
    if (_chapterChange < 0 || _chapterChange >= _chapters.count) {
        return NULL;
    }
    _pageChange = [_chapters[_chapterChange] pageOfOffset:offset];
    SDTXTChapterModel *chapterModel = [self chapterAtIndex:_chapterChange];
    return [[SDTXTReaderPageViewController alloc] initWithPage:[chapterModel contentOfPage:_pageChange]];
}

@end
