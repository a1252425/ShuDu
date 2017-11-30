//
//  SDFileModel.h
//  ShuDu
//
//  Created by 邵帅 on 2017/11/17.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SSModel.h"

@interface SDFileModel : SSModel

@property (nonatomic, weak) SDFileModel *component;   //该文件所在的文件夹

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *extension;

@end
