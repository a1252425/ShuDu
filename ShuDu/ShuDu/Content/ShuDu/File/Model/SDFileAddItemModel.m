//
//  SDFileAddItemModel.m
//  ShuDu
//
//  Created by 邵帅 on 2017/11/22.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDFileAddItemModel.h"

@implementation SDFileAddItemModel

+ (instancetype)item:(NSString *)title image:(UIImage *)image {
    SDFileAddItemModel *item = [[SDFileAddItemModel alloc] init];
    item.title = title;
    item.image = image;
    return item;
}

@end
