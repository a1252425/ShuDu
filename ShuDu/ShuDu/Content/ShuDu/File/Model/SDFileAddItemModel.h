//
//  SDFileAddItemModel.h
//  ShuDu
//
//  Created by 邵帅 on 2017/11/22.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SSModel.h"

@interface SDFileAddItemModel : SSModel

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *image;

+ (instancetype)item:(NSString *)title image:(UIImage *)image;

@end
