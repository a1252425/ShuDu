//
//  SDTXTReaderCatalogView.h
//  ShuDu
//
//  Created by 邵帅 on 2017/12/8.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDTXTChapterModel;

@interface SDTXTReaderCatalogView : UIView

@property (nonatomic, strong) NSArray<SDTXTChapterModel *> *chapters;

@end
