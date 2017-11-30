//
//  SSUtils.m
//  ShuDu
//
//  Created by 邵帅 on 2017/11/17.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SSUtils.h"
#import "SSDeviceUILevel.h"

@implementation SSUtils

+ (NSString *)dateToString:(NSDate *)date {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd hh:ss:mm";
    return [df stringFromDate:date];
}

+ (UIFont *)customSystemFontOfSize:(CGFloat)fontSize {
    SSDeviceLevel level = [SSDeviceUILevel sharedInstance].level;
    if (level == SSDeviceLevelPhoneSecond) {
        fontSize -= 1;
    }else if (level == SSDeviceLevelPhoneFirst) {
        fontSize -= 2;
    }
    return [UIFont systemFontOfSize:fontSize];
}

@end
