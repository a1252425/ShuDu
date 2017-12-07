//
//  SSModel.h
//  ShuDu
//
//  Created by 邵帅 on 2017/11/17.
//  Copyright © 2017年 邵帅. All rights reserved.
//

@class SSModel;

@interface NSObject (Helper)

+ (SSModel *)entityWithData:(id)entityData entityClass:(Class)entityClass;

+ (NSMutableArray *)entityListWithData:(id)entityListData entityClass:(Class)entityClass;

+ (Class)getClassTypeOfProperty:(NSString *)propertyName;

- (NSDictionary *)dictionaryRepresentation;

- (NSArray *)allPropertyNames;

@end

@interface SSModel : NSObject <NSCopying, NSCoding>

@end

