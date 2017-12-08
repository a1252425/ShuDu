//
//  SDTXTChapterModel.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/5.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTChapterModel.h"
#import "SDTXTConfigModel.h"
#import <CoreText/CoreText.h>
#import "SDTXTPageModel.h"
#import "SDTXTReaderMarkModel.h"

@interface SDTXTChapterModel ()
{
    NSMutableArray *_pages;
}

@end

@implementation SDTXTChapterModel

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content {
    if (self = [super init]) {
        _title = title;
        _content = content;
        
        _pages = [NSMutableArray array];
    }
    return self;
}

- (void)updatePage:(CGFloat)fontSize bounds:(CGRect)bounds {
    //  清除已缓存的页码
    //  _pages存储内容：每一页的range
    [_pages removeAllObjects];
    
    NSMutableDictionary *attribute = [NSMutableDictionary dictionaryWithDictionary:[SDTXTConfigModel sharedInstance].attribute];
    [attribute setObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    
    //  根据配置信息，设置页面多属性文字
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:_content attributes:attribute];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
    CGPathRef path = CGPathCreateWithRect(bounds, NULL);
    
    //  起始绘制位置
    NSInteger location = 0;
    
    while (YES) {
        //  绘制
        CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter,
                                                       CFRangeMake(location, 0), // 为什么是0，看说明文档
                                                       path,
                                                       NULL);
        //  获取在bounds中绘制的文字的范围
        CFRange range = CTFrameGetVisibleStringRange(frameRef);
        NSInteger _location = range.location;
        NSInteger _length = range.length;
        NSRange _range = NSMakeRange(_location, _length);
        [_pages addObject:NSStringFromRange(_range)];
        CFRelease(frameRef);
        
        //  是最后一页，停止循环
        if (range.location + range.length >= attributedString.length) {
            break;
        }
        
        //  当前页面结束位置
        location += range.length;
    }
    
    CGPathRelease(path);
    CFRelease(framesetter);
    
    _pageCount = _pages.count;
}

- (NSRange)rangeOfPage:(NSInteger)page {
    return NSRangeFromString(_pages[page]);
}

- (SDTXTPageModel *)contentOfPage:(NSInteger)page {
    NSRange range;
    if (page >= _pages.count) {
        range = NSRangeFromString(_pages.lastObject);
    }
    else if (page <= 0) {
        range = NSRangeFromString(_pages.firstObject);
    }
    else
        range = NSRangeFromString(_pages[page]);
    
    SDTXTPageModel *model = [[SDTXTPageModel alloc] init];
    model.page = page;
    model.content = [_content substringWithRange:range];
    model.chapter = self;
    model.range = range;
    return model;
}

- (SDTXTReaderMarkModel *)markPage:(NSInteger)page {
    if (page >= _pages.count || page < 0) return NULL;
    
    NSRange range = NSRangeFromString(_pages[page]);
    NSInteger offset = range.location;
    NSInteger length = range.length > 30 ? 30 : range.length;
    
    SDTXTReaderMarkModel *markModel = [[SDTXTReaderMarkModel alloc] init];
    markModel.offset = range.location;
    markModel.chapter = _chapter;
    markModel.title = _title;
    markModel.content = [_content substringWithRange:NSMakeRange(offset, length)];
    
    return markModel;
}

- (NSInteger)pageOfOffset:(NSInteger)offset {
    if (offset >= _content.length) {
        return _pageCount-1;
    }
    if (offset<=0) {
        return 0;
    }
    NSInteger index = 0;
    for (; index < _pageCount;index++) {
        NSRange range = NSRangeFromString(_pages[index]);
        if (range.location <= offset && range.location + range.length > offset) {
            break;
        }
    }
    return index;
}

@end
