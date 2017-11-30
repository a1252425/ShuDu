//
//  SDImage.h
//  SuperWatch
//
//  Created by 邵帅 on 2017/8/22.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDImage : NSObject

/**
 控制器工具条按钮图标
 0:本地、1:传输、2:设置、3:本地、4:本地
 */
+ (UIImage *)root_tab_bar_item0;
+ (UIImage *)root_tab_bar_item1;
+ (UIImage *)root_tab_bar_item2;
+ (UIImage *)root_tab_bar_item3;
+ (UIImage *)root_tab_bar_item4;

/**
 文件页面，添加页面的图标
 */
+ (UIImage *)folderImage;
+ (UIImage *)albumImage;
+ (UIImage *)shootImage;
+ (UIImage *)musicImage;
+ (UIImage *)downloadImage;

/**
 文件图标
 */
+ (UIImage *)defaultFileImage;
+ (UIImage *)directoryImage;
+ (UIImage *)txtFileImage;
+ (UIImage *)wordFileImage;
+ (UIImage *)pptFileImage;
+ (UIImage *)excelFileImage;
+ (UIImage *)videoImage;

/**
 通用图标
 */
+ (UIImage *)detailImage;
+ (UIImage *)backImage;
+ (UIImage *)closeImage;
+ (UIImage *)doneImage;
+ (UIImage *)moreImage;
+ (UIImage *)storeImage;
+ (UIImage *)storedImage;
+ (UIImage *)headPhoneImage;

/**
 Txt Reader图标
 */
+ (UIImage *)menuImage;
+ (UIImage *)nightImage;
+ (UIImage *)brightnessMaxImage;
+ (UIImage *)brightnessMinImage;

@end
