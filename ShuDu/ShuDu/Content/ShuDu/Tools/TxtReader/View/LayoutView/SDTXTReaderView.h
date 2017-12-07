//
//  SDTXTReaderView.h
//  ShuDu
//
//  Created by 邵帅 on 2017/12/7.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDTXTReaderLayoutProtocol.h"

@class SDTXTRecordModel;

@interface SDTXTReaderView : UIView <SDTXTReaderLayoutProtocol>

@property (nonatomic, weak) id<SDTXTReaderLayoutProtocol> delegate;
@property (nonatomic, strong) SDTXTRecordModel *recordModel;

- (instancetype)initWithRecord:(SDTXTRecordModel *)recordModel;

@end
