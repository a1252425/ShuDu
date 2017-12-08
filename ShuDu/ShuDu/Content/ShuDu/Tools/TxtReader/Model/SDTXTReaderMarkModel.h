//
//  SDTXTReaderMarkModel.h
//  ShuDu
//
//  Created by 邵帅 on 2017/12/7.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SSModel.h"

@interface SDTXTReaderMarkModel : SSModel

@property (nonatomic, assign) NSInteger chapter;
@property (nonatomic, assign) NSInteger offset;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSDate *date;

@end
