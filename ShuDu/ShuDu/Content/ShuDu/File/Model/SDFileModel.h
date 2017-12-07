//
//  SDFileModel.h
//  ShuDu
//
//  Created by 邵帅 on 2017/11/17.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SSModel.h"

typedef NS_ENUM(NSInteger, SDFileType) {
    SDFileTypeUnknown       = -1,
    SDFileTypeDirectory     = 0,
    
    SDFileTypeTxt,
    SDFileTypePdf,
    SDFileTypePub,
    SDFileTypeDoc,
    SDFileTypePPT,
    SDFileTypeExcel,
    
    SDFileTypeImage,
    SDFileTypeVideo,
    SDFileTypeAudio,
    
    SDFileTypeRar,
    SDFileTypeZip,
};

@interface SDFileModel : SSModel

@property (nonatomic, weak) SDFileModel *component;   //该文件所在的文件夹

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger pID;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *md5;
@property (nonatomic, assign) SDFileType type;

@property (nonatomic, copy) NSString *extension;
@property (nonatomic, copy) NSString *fileRealPath;

- (BOOL)isMemberOf:(SDFileModel *)component;

@end
