//
//  SDTXTReaderLayoutProtocol.h
//  ShuDu
//
//  Created by 邵帅 on 2017/12/6.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SDTXTReaderLayoutProtocol <NSObject>

@optional

//  顶部点击X，退出阅读
- (void)close;

//  更新UI
- (void)updateAppearance;

@end
