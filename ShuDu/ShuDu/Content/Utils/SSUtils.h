//
//  SSUtils.h
//  ShuDu
//
//  Created by 邵帅 on 2017/11/17.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSUtils : NSObject

//  date to string
+ (NSString *)dateToString:(NSDate *)date;

//  adopt font size
+ (UIFont *)customSystemFontOfSize:(CGFloat)fontSize;

//  file md5
+ (NSString *)fileMD5:(NSString *)filePath;

@end
