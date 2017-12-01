//
//  SDFileManager.h
//  ShuDu
//
//  Created by 邵帅 on 2017/11/30.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SDFileModel;

@interface SDFileManager : NSObject

+ (instancetype)sharedInstance;

//  增
- (void)component:(SDFileModel *)component addFile:(NSString *)filePath error:(NSError **)error;
- (BOOL)component:(SDFileModel *)component addData:(NSData *)data fileName:(NSString *)fileName;

//  删

//  查
- (NSArray<SDFileModel *> *)componentsOfRoot;
- (NSArray<SDFileModel *> *)componentsOfFile:(SDFileModel *)fileModel;

//  改

@end
