//
//  SDTXTReaderViewModel.h
//  ShuDu
//
//  Created by 邵帅 on 2017/12/4.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SSViewModel.h"
#import "SDTXTReaderLayoutProtocol.h"

@class SDFileModel, SDTXTChapterModel, SDTXTRecordModel;

@interface SDTXTReaderViewModel : SSViewModel <SDTXTReaderLayoutProtocol>

@property (nonatomic, strong) NSArray<SDTXTChapterModel *> *chapters;
@property (nonatomic, strong) SDTXTRecordModel *recordModel;

- (instancetype)initWithFile:(SDFileModel *)fileModel;

//  page view 简化操作
- (UIViewController *)currentPageViewController;
- (UIViewController *)nextPageViewController;
- (UIViewController *)lastPageViewController;
- (void)finishTransition:(BOOL)completed;
- (void)willTransition;

@end
