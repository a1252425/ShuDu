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
- (BOOL)component:(SDFileModel *)component addFile:(NSString *)filePath error:(NSError **)error;
- (BOOL)component:(SDFileModel *)component addData:(NSData *)data fileName:(NSString *)fileName type:(NSInteger)type error:(NSError **)error;

//  删

//  查
- (SDFileModel *)rootComponent;
- (NSArray<SDFileModel *> *)componentsOfFile:(SDFileModel *)fileModel;

//  改
- (BOOL)copyComponent:(SDFileModel *)component to:(SDFileModel *)toComponent error:(NSError **)error;
- (BOOL)moveComponent:(SDFileModel *)component to:(SDFileModel *)toComponent error:(NSError **)error;

@end
