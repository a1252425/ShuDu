//
//  SDTXTConfigModel.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/5.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTConfigModel.h"

#define kSDTXTConfigModelArchiveKey @"kSDTXTConfigModelArchiveKey"

@interface SDTXTConfigModel ()

@property (nonatomic, assign) UIEdgeInsets contentInsets;
@property (nonatomic, assign) CGRect bounds;
@property (nonatomic, copy) NSDictionary *attribute;

@end

@implementation SDTXTConfigModel

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SDTXTConfigModel *model;
    dispatch_once(&onceToken, ^{
        NSData *data = [[NSUserDefaults standardUserDefaults] dataForKey:kSDTXTConfigModelArchiveKey];
        if (data) {
            model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }else
            model = [[SDTXTConfigModel alloc] init];
    });
    return model;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lineSpace = 10.f;
        _fontSize = 14.f;
        _leftSpace = 10.f;
        _topSpace = [UIApplication sharedApplication].statusBarFrame.size.height + 12;
        _rightSpace = 10.f;
        _bottomSpace = 10.f;
        
        _fontColor = [UIColor blackColor];
        _themeColor = [UIColor colorWithRed:250.f/255.f green:250.f/255.f blue:250.f/255.f alpha:1];
    }
    return self;
}

//  当边界变化时，更新边界

- (void)setLeftSpace:(CGFloat)leftSpace {
    if (_leftSpace != leftSpace) {
        _leftSpace = leftSpace;
        _contentInsets = UIEdgeInsetsZero;
        _bounds = CGRectZero;
    }
}

- (void)setTopSpace:(CGFloat)topSpace {
    if (_topSpace != topSpace) {
        _topSpace = topSpace;
        _contentInsets = UIEdgeInsetsZero;
        _bounds = CGRectZero;
    }
}

- (void)setRightSpace:(CGFloat)rightSpace {
    if (_rightSpace != rightSpace) {
        _rightSpace = rightSpace;
        _contentInsets = UIEdgeInsetsZero;
        _bounds = CGRectZero;
    }
}

- (void)setBottomSpace:(CGFloat)bottomSpace {
    if (_bottomSpace != bottomSpace) {
        _bottomSpace = bottomSpace;
        _contentInsets = UIEdgeInsetsZero;
        _bounds = CGRectZero;
    }
}

- (UIEdgeInsets)contentInsets {
    if (UIEdgeInsetsEqualToEdgeInsets(_contentInsets, UIEdgeInsetsZero)) {
        _contentInsets = UIEdgeInsetsMake(_topSpace, _leftSpace, _bottomSpace, _rightSpace);
        [self synchronize];
    }
    return _contentInsets;
}

- (CGRect)bounds {
    if (CGRectEqualToRect(_bounds, CGRectZero)) {
        CGRect screenFrame = [UIScreen mainScreen].bounds;
        _bounds = CGRectMake(self.contentInsets.left, self.contentInsets.top, screenFrame.size.width - self.contentInsets.left - self.contentInsets.right, screenFrame.size.height - self.contentInsets.top - self.contentInsets.bottom);
        [self synchronize];
    }
    return _bounds;
}

//  当文字属性参数变化时，更新attribute属性

- (void)setLineSpace:(CGFloat)lineSpace {
    if (_lineSpace != lineSpace) {
        _lineSpace = lineSpace;
        _attribute = nil;
    }
}

- (void)setFontSize:(CGFloat)fontSize {
    if (_fontSize != fontSize) {
        _fontSize = fontSize;
        _attribute = nil;
    }
}

- (void)setFontColor:(UIColor *)fontColor {
    if (![_fontColor isEqual:fontColor]) {
        _fontColor = fontColor;
        _attribute = nil;
    }
}

- (NSDictionary *)attribute {
    if (!_attribute) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSForegroundColorAttributeName] = _fontColor;
        dict[NSFontAttributeName] = [UIFont systemFontOfSize:_fontSize];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = _lineSpace;
        paragraphStyle.alignment = NSTextAlignmentJustified;
        dict[NSParagraphStyleAttributeName] = paragraphStyle;
        _attribute = [NSDictionary dictionaryWithDictionary:dict];
        [self synchronize];
    }
    return _attribute;
}

//  同步数据

- (void)synchronize {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kSDTXTConfigModelArchiveKey];
}

@end
