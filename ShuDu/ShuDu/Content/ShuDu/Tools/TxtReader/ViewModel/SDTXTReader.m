//
//  SDTXTReader.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/8.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReader.h"

@implementation SDTXTReader

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SDTXTReader *reader;
    dispatch_once(&onceToken, ^{
        reader = [[SDTXTReader alloc] init];
    });
    return reader;
}

- (void)clear {
    _layoutView = nil;
    _recordModel = nil;
    _chapters = nil;
}

@end
