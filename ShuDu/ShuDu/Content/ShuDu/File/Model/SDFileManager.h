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
- (void)component:(SDFileModel *)component addData:(NSData *)data fileName:(NSString *)fileName type:(NSInteger)type error:(NSError **)error;

//  删

//  查
- (SDFileModel *)rootComponent;
- (NSArray<SDFileModel *> *)componentsOfFile:(SDFileModel *)fileModel;

//  改
- (void)copyComponent:(SDFileModel *)component to:(SDFileModel *)toComponent error:(NSError **)error;
- (void)moveComponent:(SDFileModel *)component to:(SDFileModel *)toComponent error:(NSError **)error;

@end
