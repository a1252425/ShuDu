//
//  SDImageStorage.h
//  SuperWatch
//
//  Created by 邵帅 on 2017/8/22.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDImageStorage : NSObject

+ (instancetype)sharedStorage;

- (NSData *)dataForKey:(NSString *)aKey;
- (void)saveData:(NSData *)data forKey:(NSString *)key;

- (void)clearStorageForKey:(NSString *)key;
- (void)clearStorageForKeys:(NSArray *)keys;
- (void)clearAllStorage;

@end
