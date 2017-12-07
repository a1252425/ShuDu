//
//  SSFileViewModel.m
//  ShuDu
//
//  Created by 邵帅 on 2017/11/17.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDFileViewModel.h"
#import "SDFileAddItemModel.h"
#import "SDFileManager.h"
#import "SDImage.h"

#import "SDFileModel.h"

#import "SDFileViewController.h"

//  TXT阅读器
#import "SDTXTReaderViewController.h"

@implementation SDFileViewModel

- (NSArray<SDFileAddItemModel *> *)fileAddItems {
    if (!_fileAddItems) {
        NSMutableArray *items = [NSMutableArray array];
        {
            SDFileAddItemModel *item = [SDFileAddItemModel item:SD(@"文件") image:[SDImage folderImage]];
            [items addObject:item];
        }
        {
            SDFileAddItemModel *item = [SDFileAddItemModel item:SD(@"相册") image:[SDImage albumImage]];
            [items addObject:item];
        }
        {
            SDFileAddItemModel *item = [SDFileAddItemModel item:SD(@"拍摄") image:[SDImage shootImage]];
            [items addObject:item];
        }
        {
            SDFileAddItemModel *item = [SDFileAddItemModel item:SD(@"音乐") image:[SDImage musicImage]];
            [items addObject:item];
        }
        {
            SDFileAddItemModel *item = [SDFileAddItemModel item:SD(@"录音") image:[SDImage musicImage]];
            [items addObject:item];
        }
        {
            SDFileAddItemModel *item = [SDFileAddItemModel item:SD(@"下载") image:[SDImage downloadImage]];
            [items addObject:item];
        }
        _fileAddItems = items;
    }
    return _fileAddItems;
}

- (CGFloat)fileAddViewHeight {
    return 80.f;
}

- (CGFloat)fileAddViewOrignalY {
    return 44 + [UIApplication sharedApplication].statusBarFrame.size.height;
}

- (instancetype)initWithFile:(SDFileModel *)fileModel {
    if (self = [super init]) {
        _files = [[SDFileManager sharedInstance] componentsOfFile:fileModel];
    }
    return self;
}

- (void)viewController:(SDFileViewController *)controller openFile:(SDFileModel *)fileModel {
    if (fileModel.type == SDFileTypeDirectory) {
        SDFileViewController *nextDirectoryController = [[SDFileViewController alloc] initWithFile:fileModel];
        [controller.navigationController pushViewController:nextDirectoryController animated:YES];
    }
    else if (fileModel.type == SDFileTypeTxt) {
        SDTXTReaderViewController *txtReaderController = [[SDTXTReaderViewController alloc] initWithFile:fileModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [controller presentViewController:txtReaderController animated:YES completion:NULL];
        });
    }
}

@end
