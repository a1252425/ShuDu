//
//  SDTXTPageModel.h
//  ShuDu
//
//  Created by 邵帅 on 2017/12/5.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SSModel.h"

@class SDTXTChapterModel;

@interface SDTXTPageModel : SSModel

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, weak) SDTXTChapterModel *chapter;
@property (nonatomic, assign) NSRange range;

@end
