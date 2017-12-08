//
//  SDTXTReader.h
//  ShuDu
//
//  Created by 邵帅 on 2017/12/8.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SDTXTReaderLayoutProtocol;
@class SDTXTRecordModel, SDTXTChapterModel;

@interface SDTXTReader : NSObject

@property (nonatomic, strong) UIView<SDTXTReaderLayoutProtocol> *layoutView;
@property (nonatomic, strong) SDTXTRecordModel *recordModel;
@property (nonatomic, strong) NSArray<SDTXTChapterModel *> *chapters;

+ (instancetype)sharedInstance;

- (void)clear;

@end
