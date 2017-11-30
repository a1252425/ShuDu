//
//  SDFileCell.h
//  ShuDu
//
//  Created by 邵帅 on 2017/11/22.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kFileCellHeight     (66)

@class SDFileModel;

@interface SDFileCell : UITableViewCell

@property (nonatomic, strong) SDFileModel *fileModel;

@end
