//
//  SSDeviceLevel.m
//  CourseStudy-Master
//
//  Created by 邵帅 on 2017/8/2.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SSDeviceUILevel.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <sys/utsname.h>

@implementation SSDeviceUILevel

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SSDeviceUILevel *deviceUILevel;
    dispatch_once(&onceToken, ^{
        deviceUILevel = [[SSDeviceUILevel alloc] init];
    });
    return deviceUILevel;
}

- (NSString *)currentDeviceTypeName {
    if (!_currentDeviceTypeName) {
        [self currentDeviceModel];
    }
    return _currentDeviceTypeName;
}

- (SSDeviceLevel)level {
    if (_currentDeviceTypeName.length == 0) {
        [self currentDeviceModel];
    }
    return _level;
}

- (void)currentDeviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) {
        _currentDeviceTypeName = @"iPhone 2G";
        _level = SSDeviceLevelOriginal;
    }
    else if ([platform isEqualToString:@"iPhone1,2"]) {
        _currentDeviceTypeName = @"iPhone 3G";
        _level = SSDeviceLevelOriginal;
    }
    else if ([platform isEqualToString:@"iPhone2,1"])
    {
        _currentDeviceTypeName = @"iPhone 3GS";
        _level = SSDeviceLevelOriginal;
    }
    else if ([platform isEqualToString:@"iPhone3,1"])
    {
        _currentDeviceTypeName = @"iPhone 4";
        _level = SSDeviceLevelPhoneFirst;
    }
    else if ([platform isEqualToString:@"iPhone3,2"])
    {
        _currentDeviceTypeName = @"iPhone 4";
        _level = SSDeviceLevelPhoneFirst;
    }
    else if ([platform isEqualToString:@"iPhone3,3"])
    {
        _currentDeviceTypeName = @"iPhone 4";
        _level = SSDeviceLevelPhoneFirst;
    }
    else if ([platform isEqualToString:@"iPhone4,1"])
    {
        _currentDeviceTypeName = @"iPhone 4s";
        _level = SSDeviceLevelPhoneFirst;
    }
    else if ([platform isEqualToString:@"iPhone5,1"])
    {
        _currentDeviceTypeName = @"iPhone 5";
        _level = SSDeviceLevelPhoneFirst;
    }
    else if ([platform isEqualToString:@"iPhone5,2"])
    {
        _currentDeviceTypeName = @"iPhone 5";
        _level = SSDeviceLevelPhoneFirst;
    }
    else if ([platform isEqualToString:@"iPhone5,3"])
    {
        _currentDeviceTypeName = @"iPhone 5c";
        _level = SSDeviceLevelPhoneFirst;
    }
    else if ([platform isEqualToString:@"iPhone5,4"])
    {
        _currentDeviceTypeName = @"iPhone 5c";
        _level = SSDeviceLevelPhoneFirst;
    }
    else if ([platform isEqualToString:@"iPhone6,1"])
    {
        _currentDeviceTypeName = @"iPhone 5s";
        _level = SSDeviceLevelPhoneFirst;
    }
    else if ([platform isEqualToString:@"iPhone6,2"])
    {
        _currentDeviceTypeName = @"iPhone 5s";
        _level = SSDeviceLevelPhoneFirst;
    }
    else if ([platform isEqualToString:@"iPhone7,1"])
    {
        _currentDeviceTypeName = @"iPhone iPhone 6 Plus";
        _level = SSDeviceLevelPhoneThird;
    }
    else if ([platform isEqualToString:@"iPhone7,2"])
    {
        _currentDeviceTypeName = @"iPhone 6";
        _level = SSDeviceLevelPhoneSecond;
    }
    else if ([platform isEqualToString:@"iPhone8,1"])
    {
        _currentDeviceTypeName = @"iPhone 6s";
        _level = SSDeviceLevelPhoneSecond;
    }
    else if ([platform isEqualToString:@"iPhone8,2"])
    {
        _currentDeviceTypeName = @"iPhone 6s Plus";
        _level = SSDeviceLevelPhoneThird;
    }
    else if ([platform isEqualToString:@"iPhone8,4"])
    {
        _currentDeviceTypeName = @"iPhone SE";
        _level = SSDeviceLevelPhoneFirst;
    }
    else if ([platform isEqualToString:@"iPhone9,1"])
    {
        _currentDeviceTypeName = @"iPhone 7";
        _level = SSDeviceLevelPhoneSecond;
    }
    else if ([platform isEqualToString:@"iPhone9,2"])
    {
        _currentDeviceTypeName = @"iPhone 7 Plus";
        _level = SSDeviceLevelPhoneThird;
    }
    else if ([platform isEqualToString:@"iPod1,1"])
    {
        _currentDeviceTypeName = @"iPod Touch 1G";
        _level = SSDeviceLevelPhoneFirst;
    }
    else if ([platform isEqualToString:@"iPod2,1"])
    {
        _currentDeviceTypeName = @"iPod Touch 2G";
        _level = SSDeviceLevelPhoneFirst;
    }
    else if ([platform isEqualToString:@"iPod3,1"])
    {
        _currentDeviceTypeName = @"iPod Touch 3G";
        _level = SSDeviceLevelPhoneFirst;
    }
    else if ([platform isEqualToString:@"iPod4,1"])
    {
        _currentDeviceTypeName = @"iPod Touch 4G";
        _level = SSDeviceLevelPhoneFirst;
    }
    else if ([platform isEqualToString:@"iPod5,1"])
    {
        _currentDeviceTypeName = @"iPod Touch 5G";
        _level = SSDeviceLevelPhoneFirst;
    }
    else if ([platform isEqualToString:@"i386"])
    {
        _currentDeviceTypeName = @"iPhone Simulator";
        _level = SSDeviceLevelUnkonwn;
    }
    else if ([platform isEqualToString:@"x86_64"])
    {
        _currentDeviceTypeName = @"iPhone Simulator";
        _level = SSDeviceLevelUnkonwn;
    }
    else {
        _currentDeviceTypeName = @"Unkonwn";
        _level = SSDeviceLevelUnkonwn;
    }
}

@end
