//
//  SSDeviceLevel.h
//  CourseStudy-Master
//
//  Created by 邵帅 on 2017/8/2.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SSDeviceLevel) {
    SSDeviceLevelUnkonwn = 0,
    SSDeviceLevelOriginal = 1,
    
    SSDeviceLevelPhoneFirst = 2,
    SSDeviceLevelPhoneSecond = 3,
    SSDeviceLevelPhoneThird = 4,
    
    SSDeviceLevelPadFirst = 5,
    SSDeviceLevelPadSecond = 6,
    SSDeviceLevelPadThird = 7
};

@interface SSDeviceUILevel : NSObject

@property (nonatomic, copy) NSString *currentDeviceTypeName;
@property (nonatomic, assign) SSDeviceLevel level;

+ (instancetype)sharedInstance;

@end
