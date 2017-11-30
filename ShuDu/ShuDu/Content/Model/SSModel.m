//
//  SSModel.m
//  ShuDu
//
//  Created by 邵帅 on 2017/11/17.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SSModel.h"
#import <objc/runtime.h>

@implementation NSObject (Helper)

+ (Class)keyValueCodingClassForObjCType:(const char *)type {
    if (type) {
        switch (type[0]) {
            case _C_ID: {
                char *openingQuoteLoc = strchr(type, '"');
                if (openingQuoteLoc) {
                    char *closingQuoteLoc = strchr(openingQuoteLoc+1, '"');
                    if (closingQuoteLoc) {
                        size_t classNameStrLen = closingQuoteLoc-openingQuoteLoc;
                        char className[classNameStrLen];
                        memcpy(className, openingQuoteLoc+1, classNameStrLen-1);
                        // Null-terminate the array to stringify
                        className[classNameStrLen-1] = '\0';
                        return objc_getClass(className);
                    }
                }
                // If there is no quoted class type (id), it can be used as-is.
                return Nil;
            }
                
            case _C_CHR: // char
            case _C_UCHR: // unsigned char
            case _C_SHT: // short
            case _C_USHT: // unsigned short
            case _C_INT: // int
            case _C_UINT: // unsigned int
            case _C_LNG: // long
            case _C_ULNG: // unsigned long
            case _C_LNG_LNG: // long long
            case _C_ULNG_LNG: // unsigned long long
            case _C_FLT: // float
            case _C_DBL: // double
                return [NSNumber class];
                
            case _C_BOOL: // C++ bool or C99 _Bool
                return objc_getClass("NSCFBoolean")
                ?: objc_getClass("__NSCFBoolean")
                ?: [NSNumber class];
                
            case _C_STRUCT_B: // struct
            case _C_BFLD: // bitfield
            case _C_UNION_B: // union
                return [NSValue class];
                
            case _C_ARY_B: // c array
            case _C_PTR: // pointer
            case _C_VOID: // void
            case _C_CHARPTR: // char *
            case _C_CLASS: // Class
            case _C_SEL: // selector
            case _C_UNDEF: // unknown type (function pointer, etc)
            default:
                break;
        }
    }
    return Nil;
}

+ (Class)keyValueCodingClassFromPropertyAttributes:(const char *)attr {
    if (attr) {
        const char *typeIdentifierLoc = strchr(attr, 'T');
        if (typeIdentifierLoc) {
            return [NSObject keyValueCodingClassForObjCType:(typeIdentifierLoc+1)];
        }
    }
    return Nil;
}

+ (Class)getClassTypeOfProperty:(NSString *)propertyName {
    objc_property_t property = class_getProperty([self class], propertyName.UTF8String);
    NSString *attribute = [NSString stringWithUTF8String:property_getAttributes(property)];
    
    return [NSObject keyValueCodingClassFromPropertyAttributes:attribute.UTF8String];
}

+ (SSModel *)entityWithData:(id)entityData entityClass:(Class)entityClass {
    if(![entityData isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    id entity = [[entityClass alloc] init];
    [entity setValuesForKeysWithDictionary:entityData];
    return entity;
}

+ (NSMutableArray *)entityListWithData:(id)entityListData entityClass:(Class)entityClass {
    if(![entityListData isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    if(![entityClass isSubclassOfClass:[SSModel class]]) {
        return nil;
    }
    
    NSMutableArray *entites = [[NSMutableArray alloc] init];
    for(id entity in entityListData) {
        // 非NSDictionary类型的直接放进数组，NSDictionary类型的使用KVC进行对象映射
        if(![entity isKindOfClass:[NSDictionary class]]) {
            [entites addObject:entity];
        }
        else {
            id object = [[entityClass alloc] init];
            [object setValuesForKeysWithDictionary:entity];
            [entites addObject:object];
        }
    }
    return entites;
}

- (NSArray *)allPropertyNames {
    NSMutableArray *names = [[NSMutableArray alloc] init];
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++)
    {
        //get property name
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        [names addObject:name];
    }
    free(properties);
    return names;
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *representation = [NSMutableDictionary dictionary];
    NSArray *keys = [self allPropertyNames];
    for(NSString *key in keys) {
        id value = [self valueForKey:key];
        if(value) {
            if([value isKindOfClass:[SSModel class]]) {
                [representation setValue:[value dictionaryRepresentation] forKey:key];
            }
            else if([value isKindOfClass:[NSArray class]]) {
                NSMutableArray *array = [NSMutableArray array];
                for(id element in value) {
                    [array addObject:[element dictionaryRepresentation]];
                }
                [representation setValue:array forKey:key];
            }
            else {
                [representation setValue:value forKey:key];
            }
        }
    }
    return representation;
}

@end

@implementation SSModel

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if(self) {
        NSArray *propertyNames = [self allPropertyNames];
        for(NSString *key in propertyNames) {
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray *propertyNames = [self allPropertyNames];
    for(NSString *key in propertyNames) {
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}

- (id)copyWithZone:(NSZone *)zone {
    id entity = [[[self class] alloc] init];
    NSDictionary *dict = [self dictionaryRepresentation];
    [entity setValuesForKeysWithDictionary:dict];
    return entity;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"\nsetValue:((%@)%@) forUndefinedKey:(%@) ofEntity:(%@)", [value class], value, key, [self class]);
    return;
}

- (void)setNilValueForKey:(NSString *)key {
    NSLog(@"\nsetNilValueForKey:(%@) ofEntity:(%@)", key, [self class]);
    return;
}

@end

