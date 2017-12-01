//
//  SDFileManager.m
//  ShuDu
//
//  Created by 邵帅 on 2017/11/30.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDFileManager.h"
#import "SDFileModel.h"
#import <FMDB/FMDB.h>

#define kShuDu_File_Path      [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"ShuDu_File"]
#define kShuDu_DB_Path        [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"ShuDu.db"]

#define kShuDu_Folder_MD5       @"1111111111111111"

@interface SDFileManager ()
{
    
}

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation SDFileManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SDFileManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[SDFileManager alloc] init];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:kShuDu_File_Path]) {
            if ([fileManager createDirectoryAtPath:kShuDu_File_Path withIntermediateDirectories:YES attributes:NULL error:NULL]) {
                NSLog(@"文件目录已创建");
            }
        }
        
        if (![fileManager fileExistsAtPath:kShuDu_DB_Path]) {
            if ([fileManager createFileAtPath:kShuDu_DB_Path contents:NULL attributes:NULL]) {
                NSLog(@"数据库文件已创建");
            }
        }
        
        FMDatabase *db = [FMDatabase databaseWithPath:kShuDu_DB_Path];
        if ([db open]) {
            NSLog(@"数据库已打开");
            
            NSString *createFileTableSql = @"CREATE TABLE IF NOT EXISTS FILE(file_id integer PRIMARY KEY, file_name varchar(64), file_md5 varchar(32), file_path varchar(256), file_type integer, file_retain integer, file_createtime integer)";
            if ([db executeUpdate:createFileTableSql]) {
                NSLog(@"文件表已创建");
            }
            
            NSString *createCatalogTableSql = @"CREATE TABLE IF NOT EXISTS CATALOG(catalog_id integer PRIMARY KEY, catalog_pid integer, catalog_name varchar(64), catalog_md5 varchar(32), catalog_path varchar(256), catalog_type integer, catalog_createtime integer)";
            if ([db executeUpdate:createCatalogTableSql]) {
                NSLog(@"目录表已创建");
            }
            
            NSString *createHistoryTableSql = @"CREATE TABLE IF NOT EXISTS HISTORY(history_id integer PRIMARY KEY, history_file_id integer, history_file_name varchar(64), history_file_md5 varchar(32), history_file_path varchar(256), history_file_type integer, history_createtime integer)";
            if ([db executeUpdate:createHistoryTableSql]) {
                NSLog(@"足迹表已创建");
            }
            
            FMResultSet *resultSet = [db executeQuery:@"SELECT 1 FROM FILE LIMIT 1"];
            if (![resultSet next]) {
                [db executeUpdate:@"INSERT INTO CATALOG (catalog_id, catalog_pid, catalog_name, catalog_md5, catalog_path, catalog_createtime) VALUES (?, ?, ?, ?, ?)", @(1), @(1), SD(@"舒读"), kShuDu_Folder_MD5, kShuDu_File_Path, @([[NSDate date] timeIntervalSince1970])];
            }
            [db close];
            manager.db = db;
        }
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)component:(SDFileModel *)component addFileDirectly:(NSString *)filePath error:(NSError **)error {
    
}

- (void)component:(SDFileModel *)component addFileDirectory:(NSString *)filePath error:(NSError **)error {
    [_db executeUpdate:@"INSERT INTO CATALOG (catalog_pid, catalog_name, catalog_md5, catalog_path, catalog_createtime) VALUES (?, ?, ?, ?, ?)", @(1), SD(@"舒读"), kShuDu_Folder_MD5, kShuDu_File_Path, @([[NSDate date] timeIntervalSince1970])];
}

- (void)component:(SDFileModel *)component addFile:(NSString *)filePath error:(NSError **)error {
    if (component.type != SDFileTypeDirectory) {
        return;
    }
    
    NSDictionary *attribute = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:error];
    if (*error) {
        return;
    }
    
    SDFileModel *fileModel = [[SDFileModel alloc] init];
    fileModel.pID = component.ID;
    
    if (![_db open]) {
        *error = _db.lastError;
        return;
    }
    
    //  判断文件是否是文件夹
    if ([attribute[NSFileType] isEqualToString:NSFileTypeDirectory]) {
        fileModel.name = filePath.lastPathComponent;
        fileModel.type = SDFileTypeDirectory;
        fileModel.path = [component.path stringByAppendingPathComponent:fileModel.name];
        fileModel.md5 = kShuDu_Folder_MD5;
        BOOL result = [_db executeUpdate:@"INSERT INTO CATALOG (catalog_pid, catalog_name, catalog_md5, catalog_path, catalog_createtime) VALUES (?, ?, ?, ?, ?)", component.ID, fileModel.name, kShuDu_Folder_MD5, fileModel.path, @([[NSDate date] timeIntervalSince1970])];
        //  如果插入失败，返回
        if (!result) {
            *error = _db.lastError;
            return;
        }
        
        //  获取刚插入的id
        FMResultSet *rs = [_db executeQuery:@"SELECT MAX(catalog_id) FROM CATALOG"];
        if (!rs.next) {
            *error = _db.lastError;
            return;
        }
        fileModel.ID = [rs intForColumn:@"catalog_id"];
        
        //  插入成功后，查看文件夹里面文件，并添加
        NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:error];
        if (*error) {
            return;
        }
        
        for (NSString *fileName in files) {
            [self component:fileModel addFile:[fileModel.path stringByAppendingPathComponent:fileName] error:error];
        }
    }
    
    NSString *fileFullName = filePath.lastPathComponent;
    NSString *fileName = [fileFullName stringByDeletingPathExtension];
    NSString *extension = fileFullName.pathExtension;
    NSString *path = [kShuDu_File_Path stringByAppendingPathComponent:fileFullName];
    
    BOOL result = [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:path error:error];
    if (result) {
        fileModel.name = fileName;
        fileModel.path = path;
//        fileModel.type =
//        fileModel.md5 =
        
        result = [_db executeUpdate:@"INSERT INTO CATALOG (catalog_pid, catalog_name, catalog_md5, catalog_path, catalog_createtime) VALUES (?, ?, ?, ?, ?)", component.ID, fileModel.name, fileModel.md5, fileModel.path, @([[NSDate date] timeIntervalSince1970])];
    }
    
    [_db close];
}

- (BOOL)component:(SDFileModel *)component addData:(NSData *)data fileName:(NSString *)fileName {
    return YES;
}

- (NSArray<SDFileModel *> *)componentsOfRoot {
    SDFileModel *rootFileModel;
    if ([_db open]) {
        FMResultSet *rs = [_db executeQuery:@"SELECT * FROM CATALOG WHERE catalog_id = 1 LIMIT 1"];
        rootFileModel = [[SDFileModel alloc] init];
        while (rs.next) {
            rootFileModel.name = [rs stringForColumn:@"catalog_name"];
            rootFileModel.ID = [rs intForColumn:@"catalog_id"];;
            rootFileModel.pID = [rs intForColumn:@"catalog_pid"];;
            rootFileModel.path = [rs stringForColumn:@"catalog_path"];
            rootFileModel.md5 = [rs stringForColumn:@"catalog_md5"];
            rootFileModel.type = SDFileTypeDirectory;
        }
        
        [_db close];
    }
    
    if (!rootFileModel) {
        return NULL;
    }
    return [self componentsOfFile:rootFileModel];
}

- (NSArray<SDFileModel *> *)componentsOfFile:(SDFileModel *)fileModel {
    NSMutableArray *files = [NSMutableArray array];
    if ([_db open]) {
        FMResultSet *rs = [_db executeQuery:@"SELECT * FROM CATALOG WHERE catalog_pid = ?", fileModel.ID];
        while (rs.next) {
            SDFileModel *_fileModel = [[SDFileModel alloc] init];
            _fileModel.component = fileModel;
            _fileModel.ID = [rs intForColumn:@"catalog_id"];
            _fileModel.pID = [rs intForColumn:@"catalog_pid"];
            _fileModel.name = [rs stringForColumn:@"catalog_name"];
            _fileModel.path = [rs stringForColumn:@"catalog_path"];
            _fileModel.md5 = [rs stringForColumn:@"catalog_md5"];
            [files addObject:_fileModel];
        }
        [_db close];
    }
    return files;
}

@end
