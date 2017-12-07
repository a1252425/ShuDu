//
//  SDTXTConfigModel.h
//  ShuDu
//
//  Created by 邵帅 on 2017/12/5.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SSModel.h"

@interface SDTXTConfigModel : SSModel

@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat lineSpace;

@property (nonatomic, assign) CGFloat leftSpace;
@property (nonatomic, assign) CGFloat topSpace;
@property (nonatomic, assign) CGFloat rightSpace;
@property (nonatomic, assign) CGFloat bottomSpace;

@property (nonatomic, assign, readonly) UIEdgeInsets contentInsets;
@property (nonatomic, assign, readonly) CGRect bounds;

@property (nonatomic, copy) UIColor *fontColor;
@property (nonatomic, copy) UIColor *themeColor;

@property (nonatomic, readonly) NSDictionary *attribute;

+ (instancetype)sharedInstance;

@end
