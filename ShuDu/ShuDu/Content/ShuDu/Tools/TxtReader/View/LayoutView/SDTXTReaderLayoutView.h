//
//  SDTXTReaderLayoutView.h
//  ShuDu
//
//  Created by 邵帅 on 2017/12/6.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderLayoutProtocol.h"

@interface SDTXTReaderLayoutView : UIView <SDTXTReaderLayoutProtocol>

@property (nonatomic, assign) BOOL status;
@property (nonatomic, weak) id<SDTXTReaderLayoutProtocol> delegate;

@end
