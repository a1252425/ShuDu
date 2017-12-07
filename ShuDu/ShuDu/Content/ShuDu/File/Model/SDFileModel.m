//
//  SDFileModel.m
//  ShuDu
//
//  Created by 邵帅 on 2017/11/17.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDFileModel.h"

@implementation SDFileModel

- (void)setFileRealPath:(NSString *)fileRealPath {
    _fileRealPath = fileRealPath;
    
    if (_md5) {
        _md5 = [SSUtils fileMD5:fileRealPath];
    }
}

- (NSString *)md5 {
    if (!_md5) {
        if (_path) {
            NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:_path];
            _md5 = [SSUtils fileMD5:filePath];
        }
        else
            _md5 = @"";
    }
    return _md5;
}

- (void)setExtension:(NSString *)extension {
    _extension = extension;
    
    if (!extension || extension.length == 0) {
        _type = SDFileTypeUnknown;
        return;
    }
    
    NSString *ext = [extension lowercaseString];
    if ([ext isEqualToString:@"txt"]) {
        _type = SDFileTypeTxt;
    }
    else if ([ext isEqualToString:@"pdf"]) {
        _type = SDFileTypePdf;
    }
    else if ([ext isEqualToString:@"pub"]) {
        _type = SDFileTypePub;
    }
    else if ([ext isEqualToString:@"doc"]) {
        _type = SDFileTypeDoc;
    }
    else if ([ext isEqualToString:@"ppt"]) {
        _type = SDFileTypePPT;
    }
    else if ([ext isEqualToString:@"excel"]) {
        _type = SDFileTypeExcel;
    }
    else if ([ext isEqualToString:@"png"] || [ext isEqualToString:@"jpg"] || [ext isEqualToString:@"jpeg"]) {
        _type = SDFileTypeImage;
    }
    else if ([ext isEqualToString:@"mp4"] || [ext isEqualToString:@"avi"] || [ext isEqualToString:@"mov"]) {
        _type = SDFileTypeVideo;
    }
    else if ([ext isEqualToString:@"mp3"]) {
        _type = SDFileTypeAudio;
    }
    else if ([ext isEqualToString:@"rar"]) {
        _type = SDFileTypeRar;
    }
    else if ([ext isEqualToString:@"zip"]) {
        _type = SDFileTypeZip;
    }
    else
        _type = SDFileTypeUnknown;
}

- (BOOL)isMemberOf:(SDFileModel *)component {
    SDFileModel *dirComponent = _component;
    while (dirComponent) {
        if (dirComponent.ID == component.ID) {
            return YES;
        }
        dirComponent = dirComponent.component;
    }
    return NO;
}

@end
