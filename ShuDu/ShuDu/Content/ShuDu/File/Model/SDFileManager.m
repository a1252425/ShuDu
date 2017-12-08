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
            
            NSString *createFileTableSql = @"CREATE TABLE IF NOT EXISTS FILE(file_id integer PRIMARY KEY, file_name varchar(64), file_md5 varchar(32), file_path varchar(256), file_type integer, file_createtime integer)";
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
            
            FMResultSet *resultSet = [db executeQuery:@"SELECT 1 FROM CATALOG LIMIT 1"];
            if (![resultSet next]) {
                [db executeUpdate:@"INSERT INTO CATALOG (catalog_id, catalog_pid, catalog_name, catalog_md5, catalog_path, catalog_createtime) VALUES (?, ?, ?, ?, ?, ?)", @(1), @(0), SD(@"舒读"), kShuDu_Folder_MD5, [kShuDu_File_Path lastPathComponent], @([[NSDate date] timeIntervalSince1970])];
            }
            [db close];
            manager.db = db;
            [manager log];
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

- (void)log {
    if ([_db open]) {
        NSString *logString = [SSUtils dateToString:[NSDate date]];
        NSString *logPath = [kShuDu_File_Path stringByAppendingPathComponent:@"log.txt"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:logPath]) {
            [self component:[self rootComponent] addData:[logString dataUsingEncoding:NSUTF8StringEncoding] fileName:@"log.txt" type:SDFileTypeTxt error:NULL];
        }
        else {
            NSData *data = [NSData dataWithContentsOfFile:logPath];
            NSString *log = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            log = [NSString stringWithFormat:@"%@\n%@", log, logString];
            [[log dataUsingEncoding:NSUTF8StringEncoding] writeToFile:logPath atomically:YES];
        }
    }
    [_db close];
}

//  从其它文件夹添加

- (BOOL)component:(SDFileModel *)component addFile:(NSString *)filePath error:(NSError **)error {
    if (component.type != SDFileTypeDirectory) {
        return NO;
    }
    
    NSDictionary *attribute = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:error];
    if (!attribute) {
        return NO;
    }
    
    if (![_db open]) {
        if (*error) *error = _db.lastError;
        return NO;
    }
    
    SDFileModel *fileModel = [[SDFileModel alloc] init];
    fileModel.pID = component.ID;
    
    //  判断文件是否是文件夹
    if ([attribute[NSFileType] isEqualToString:NSFileTypeDirectory]) {
        fileModel.name = filePath.lastPathComponent;
        fileModel.type = SDFileTypeDirectory;
        fileModel.path = [component.path stringByAppendingPathComponent:fileModel.name];
        fileModel.md5 = kShuDu_Folder_MD5;
        
        //  更新CATALOG表
        BOOL result = [_db executeUpdate:@"INSERT INTO CATALOG (catalog_pid, catalog_name, catalog_md5, catalog_path, catalog_type, catalog_createtime) VALUES (?, ?, ?, ?, ?)", @(component.ID), fileModel.name, kShuDu_Folder_MD5, fileModel.path, @(fileModel.type), @([[NSDate date] timeIntervalSince1970])];
        if (!result) {
            if (*error) *error = _db.lastError;
            return NO;
        }
        
        //  获取刚插入的id
        FMResultSet *rs = [_db executeQuery:@"SELECT MAX(catalog_id) FROM CATALOG"];
        if (!rs.next) {
            if (*error) *error = _db.lastError;
            return NO;
        }
        fileModel.ID = [rs intForColumn:@"catalog_id"];
        
        //  插入成功后，查看文件夹里面文件，并添加
        NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:error];
        if (*error) {
            return NO;
        }
        
        for (NSString *fileName in files) {
            [self component:fileModel addFile:[fileModel.path stringByAppendingPathComponent:fileName] error:error];
        }
        [_db close];
        return YES;
    }
    
    //  查询FILE表中是否存在改MD5的文件
    NSString *md5 = [SSUtils fileMD5:filePath];
    FMResultSet *rs = [_db executeQuery:@"SELECT 1 FROM FILE WHERE file_md5=? LIMIT 1", md5];
    
    //  如果FILE表中没有改文件，添加
    if (!rs.next) {
        NSString *fileFullName = filePath.lastPathComponent;
        NSString *realPath = [kShuDu_File_Path stringByAppendingPathComponent:fileFullName];
        BOOL result = [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:realPath error:error];
        if (!result) {
            return NO;
        }
        NSString *fileName = [fileFullName stringByDeletingPathExtension];
        NSString *extension = fileFullName.pathExtension;
        fileModel.name = fileName;
        fileModel.path = [component.path stringByAppendingPathComponent:fileFullName];
        fileModel.md5 = md5;
        fileModel.fileRealPath = [kShuDu_File_Path.lastPathComponent stringByAppendingPathComponent:fileFullName];
        fileModel.extension = extension;
        
        result = [_db executeUpdate:@"INSERT INTO FILE (file_name, file_md5, file_path, file_type, file_createtime) VALUES (?, ?, ?, ?, ?)", fileModel.name, fileModel.md5, fileModel.fileRealPath, @(fileModel.type), @([[NSDate date] timeIntervalSince1970])];
        if (!result) {
            if (*error) *error = _db.lastError;
            return NO;
        }
        //  更新CATALOG表
        [_db executeUpdate:@"INSERT INTO CATALOG (catalog_pid, catalog_name, catalog_md5, catalog_path, catalog_type, catalog_createtime) VALUES (?, ?, ?, ?, ?, ?)", @(component.ID), fileModel.name, md5, fileModel.path, @(fileModel.type), @([[NSDate date] timeIntervalSince1970])];
    }
    
    return [_db close];
}

- (BOOL)component:(SDFileModel *)component addData:(NSData *)data fileName:(NSString *)fileName type:(NSInteger)type error:(NSError **)error {
    if (!component || !data || !fileName || fileName.length == 0) {
        return NO;
    }
    
    if (![_db open]) {
        if (*error) *error = _db.lastError;
        return NO;
    }
    
    NSString *realPath = [kShuDu_File_Path stringByAppendingPathComponent:fileName];
    if (![data writeToFile:realPath atomically:YES]) {
        return NO;
    }
    NSString *md5 = [SSUtils fileMD5:realPath];
    BOOL result = [_db executeUpdate:@"INSERT INTO FILE (file_name, file_md5, file_path, file_type, file_createtime) VALUES (?, ?, ?, ?, ?)", fileName, md5, realPath, @(type), @([[NSDate date] timeIntervalSince1970])];
    if (!result) {
        if (*error) *error = _db.lastError;
        return NO;
    }
    
    //  更新CATALOG表
    [_db executeUpdate:@"INSERT INTO CATALOG (catalog_pid, catalog_name, catalog_md5, catalog_path, catalog_type, catalog_createtime) VALUES (?, ?, ?, ?, ?, ?)", @(component.ID), fileName, md5, [component.path stringByAppendingPathComponent:fileName], @(type), @([[NSDate date] timeIntervalSince1970])];
    return [_db close];
}

- (SDFileModel *)rootComponent {
    SDFileModel *rootFileModel = [[SDFileModel alloc] init];
    if (![_db open]) {
        return NULL;
    }
    FMResultSet *rs = [_db executeQuery:@"SELECT * FROM CATALOG WHERE catalog_id = 1 LIMIT 1"];
    while (rs.next) {
        rootFileModel.ID = [rs intForColumn:@"catalog_id"];
        rootFileModel.pID = [rs intForColumn:@"catalog_pid"];
        rootFileModel.name = [rs stringForColumn:@"catalog_name"];
        rootFileModel.path = [rs stringForColumn:@"catalog_path"];
        rootFileModel.md5 = [rs stringForColumn:@"catalog_md5"];
        rootFileModel.type = SDFileTypeDirectory;
    }
    [_db close];
    return rootFileModel;
}

- (NSArray<SDFileModel *> *)componentsOfFile:(SDFileModel *)fileModel {
    NSMutableArray *files = [NSMutableArray array];
    if ([_db open]) {
        FMResultSet *rs = [_db executeQuery:@"SELECT * FROM CATALOG WHERE catalog_pid=?", @(fileModel.ID)];
        while (rs.next) {
            SDFileModel *_fileModel = [[SDFileModel alloc] init];
            _fileModel.component = fileModel;
            _fileModel.ID = [rs intForColumn:@"catalog_id"];
            _fileModel.pID = [rs intForColumn:@"catalog_pid"];
            _fileModel.name = [rs stringForColumn:@"catalog_name"];
            _fileModel.path = [rs stringForColumn:@"catalog_path"];
            _fileModel.md5 = [rs stringForColumn:@"catalog_md5"];
            _fileModel.type = [rs intForColumn:@"catalog_type"];
            [files addObject:_fileModel];
        }
        [_db close];
    }
    return files;
}

- (BOOL)copyComponent:(SDFileModel *)component to:(SDFileModel *)toComponent error:(NSError **)error {
    if (toComponent.type != SDFileTypeDirectory) {
        if (*error) *error = [NSError errorWithDomain:@"FMDB" code:1 userInfo:@{NSLocalizedDescriptionKey: SD(@"复制目标不是文件夹")}];
        return NO;
    }
    if ([toComponent isMemberOf:component]) {
        if (*error) *error = [NSError errorWithDomain:@"FMDB" code:1 userInfo:@{NSLocalizedDescriptionKey: SD(@"无法复制")}];
        return NO;
    }
    
    if (![_db open]) {
        if (*error) *error =_db.lastError;
        return NO;
    }
    
    if (component.pID == toComponent.ID) {
        component.name = [NSString stringWithFormat:@"%@ %@", component.name, [SSUtils dateToString:[NSDate date]]];
    }
    
    [_db executeUpdate:@"INSERT INTO CATALOG (catalog_pid, catalog_name, catalog_md5, catalog_path, catalog_type, catalog_createtime) VALUES (?, ?, ?, ?, ?, ?)", toComponent.ID, component.name, component.md5, component.path, component.type, @([[NSDate date] timeIntervalSince1970])];
    
    if (component.type == SDFileTypeDirectory) {
        NSInteger catalogID = component.ID;
        FMResultSet *rs = [_db executeQuery:@"SELECT MAX(catalog_id) FROM CATALOG"];
        if (rs.next) {
            component.ID = [rs intForColumn:@"catalog_id"];
        }
        
        rs = [_db executeQuery:@"SELECT * FROM CATALOG WHERE catalog_pid=?", catalogID];
        while (rs.next) {
            SDFileModel *fileModel = [[SDFileModel alloc] init];
            fileModel.pID = [rs intForColumn:@"catalog_pid"];
            fileModel.name = [rs stringForColumn:@"catalog_name"];
            fileModel.md5 = [rs stringForColumn:@"catalog_md5"];
            fileModel.path = [rs stringForColumn:@"catalog_path"];
            fileModel.type = [rs intForColumn:@"catalog_type"];
            [self copyComponent:fileModel to:component error:error];
        }
    }
    
    return [_db close];
}

- (BOOL)moveComponent:(SDFileModel *)component to:(SDFileModel *)toComponent error:(NSError **)error {
    if (component.ID == toComponent.ID || [toComponent isMemberOf:component]) {
        if (*error) *error = [NSError errorWithDomain:@"FMDB" code:1 userInfo:@{NSLocalizedDescriptionKey: SD(@"无法移动")}];
        return NO;
    }
    
    if (toComponent.type != SDFileTypeDirectory) {
        if (*error) *error = [NSError errorWithDomain:@"FMDB" code:1 userInfo:@{NSLocalizedDescriptionKey: SD(@"移动目标不是文件夹")}];
        return NO;
    }
    
    if (![_db open]) {
        if (*error) *error = [_db lastError];
        return NO;
    }
    
    BOOL result = [_db executeUpdate:@"UPDATE CATALOG SET catalog_pid=? WHERE catalog_id=?", toComponent.ID, component.ID];
    [_db close];
    if (!result) {
        if (*error) *error = _db.lastError;
        return NO;
    }
    return result;
}

@end
