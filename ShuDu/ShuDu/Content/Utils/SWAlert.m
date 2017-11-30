//
//  SWUtils.m
//  SuperWatch
//
//  Created by 邵帅 on 2017/8/23.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SWAlert.h"

#define kSWUtilsSure            @"确定"
#define kSWUtilsCancel          @"取消"
#define kSWUtilsTitle           @"提示"

@implementation SWAlert

+ (void)showAlert:(NSString *)message {
    [self showAlert:kSWUtilsTitle message:message];
}

+ (void)showAlert:(NSString *)title message:(NSString *)message {
    [self showAlert:title message:message sureCompletion:NULL];
}

+ (void)showAlert:(NSString *)message sureCompletion:(void(^)(void))completion {
    [self showAlert:kSWUtilsTitle message:message sureCompletion:completion];
}

+ (void)showAlert:(NSString *)title message:(NSString *)message sureCompletion:(void(^)(void))completion {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:kSWUtilsCancel style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (completion) {
            completion();
        }
    }];
    [alertController addAction:sureAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:NULL];
}

+ (void)showAlert:(NSString *)message isSureCompletion:(void(^)(BOOL sure))completion {
    [self showAlert:kSWUtilsTitle message:message isSureCompletion:completion];
}

+ (void)showAlert:(NSString *)title message:(NSString *)message isSureCompletion:(void(^)(BOOL sure))completion {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:kSWUtilsSure style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (completion) {
            completion(NO);
        }
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:kSWUtilsCancel style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (completion) {
            completion(YES);
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:NULL];
}

+ (void)showCustomAlert:(NSString *)message {
    
}

+ (void)showCustomAlert:(NSString *)message sureCompletion:(void(^)(void))completion {
    
}

+ (void)showCustomAlert:(NSString *)message isSureCompletion:(void(^)(BOOL sure))completion {
    
}

@end
