//
//  SWUtils.h
//  SuperWatch
//
//  Created by 邵帅 on 2017/8/23.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWAlert : NSObject

+ (void)showAlert:(NSString *)message;
+ (void)showAlert:(NSString *)title message:(NSString *)message;
+ (void)showAlert:(NSString *)message sureCompletion:(void(^)(void))completion;
+ (void)showAlert:(NSString *)title message:(NSString *)message sureCompletion:(void(^)(void))completion;

+ (void)showAlert:(NSString *)message isSureCompletion:(void(^)(BOOL sure))completion;
+ (void)showAlert:(NSString *)title message:(NSString *)message isSureCompletion:(void(^)(BOOL sure))completion;

+ (void)showCustomAlert:(NSString *)message;
+ (void)showCustomAlert:(NSString *)message sureCompletion:(void(^)(void))completion;
+ (void)showCustomAlert:(NSString *)message isSureCompletion:(void(^)(BOOL sure))completion;

@end
