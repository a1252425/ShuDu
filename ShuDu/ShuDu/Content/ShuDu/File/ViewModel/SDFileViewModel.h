//
//  SSFileViewModel.h
//  ShuDu
//
//  Created by 邵帅 on 2017/11/17.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SSViewModel.h"

@class SDFileAddItemModel, SDFileModel, SDFileViewController;

@interface SDFileViewModel : SSViewModel

@property (nonatomic, strong) NSArray<SDFileAddItemModel *> *fileAddItems;
@property (nonatomic, assign) CGFloat fileAddViewHeight;
@property (nonatomic, assign) CGFloat fileAddViewOrignalY;

@property (nonatomic, strong) NSArray<SDFileModel *> *files;

- (instancetype)initWithFile:(SDFileModel *)fileModel;

- (void)viewController:(SDFileViewController *)controller openFile:(SDFileModel *)fileModel;

@end
