//
//  SDImageStorage.m
//  SuperWatch
//
//  Created by 邵帅 on 2017/8/22.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDImageStorage.h"

#define kSDImageStorageMaxCacheLength   24576
#define kSDImageStoragePath             [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"SDImageStorage"]

@interface SDImageStorage ()
{
    NSCache *_cache;
}

@end

@implementation SDImageStorage

+ (instancetype)sharedStorage {
    static dispatch_once_t onceToken;
    static SDImageStorage *imageStorage;
    dispatch_once(&onceToken, ^{
        imageStorage = [[SDImageStorage alloc] init];
    });
    return imageStorage;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache = [[NSCache alloc] init];
        if (![[NSFileManager defaultManager] fileExistsAtPath:kSDImageStoragePath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:kSDImageStoragePath withIntermediateDirectories:YES attributes:NULL error:NULL];
        }
    }
    return self;
}

- (NSData *)dataForKey:(NSString *)aKey {
    NSData *imageData = [_cache objectForKey:aKey];
    if (!imageData) {
        imageData = [NSData dataWithContentsOfFile:[kSDImageStoragePath stringByAppendingPathComponent:aKey]];
        if (imageData && imageData.length <= kSDImageStorageMaxCacheLength) {
            [_cache setObject:imageData forKey:aKey];
        }
    }
    return imageData;
}

- (void)saveData:(NSData *)data forKey:(NSString *)key {
    if (data.length == 0) {
        return;
    }
    if (data.length <= kSDImageStorageMaxCacheLength) {
        [_cache setObject:data forKey:key];
    }
    [data writeToFile:[kSDImageStoragePath stringByAppendingPathComponent:key] atomically:YES];
}

- (void)clearStorageForKey:(NSString *)key {
    if ([_cache objectForKey:key]) {
        [_cache removeObjectForKey:key];
    }else{
        [[NSFileManager defaultManager] removeItemAtPath:[kSDImageStoragePath stringByAppendingPathComponent:key] error:NULL];
    }
}

- (void)clearStorageForKeys:(NSArray *)keys {
    for (NSString *key in keys) {
        [self clearStorageForKey:key];
    }
}

- (void)clearAllStorage {
    [_cache removeAllObjects];
    [[NSFileManager defaultManager] removeItemAtPath:kSDImageStoragePath error:NULL];
    [[NSFileManager defaultManager] createDirectoryAtPath:kSDImageStoragePath withIntermediateDirectories:YES attributes:NULL error:NULL];
}

@end
