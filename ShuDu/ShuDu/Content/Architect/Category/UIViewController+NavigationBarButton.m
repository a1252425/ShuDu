//
//  UIViewController+NavigationBarButton.m
//  CourseStudy-Master
//
//  Created by 邵帅 on 2017/8/18.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "UIViewController+NavigationBarButton.h"
#import "SDImage.h"

@interface SSBackBarButton : UIControl
{
    UIImageView *backImageView;
    UILabel *titleLabel;
}

@end

@implementation SSBackBarButton

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 80, 34);
        
        backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 12, 22)];
        backImageView.image = [[SDImage backImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        backImageView.tintColor = kLightColor;
        [self addSubview:backImageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 65, 34)];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = kDarkColor;
        titleLabel.text = title;
        [self addSubview:titleLabel];
        
        [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        [self addTarget:self action:@selector(highlightedBegin) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(highlightedEnd) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    }
    return self;
}

- (void)highlightedBegin {
    backImageView.image = [backImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    titleLabel.textColor = kLightColor;
}

- (void)highlightedEnd {
    backImageView.image = [backImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    titleLabel.textColor = kDarkColor;
}

@end

@implementation UIViewController (NavigationBarButton)

- (void)addCommonBackButton {
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[SDImage backImage] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)addCommonBackButton:(NSString *)backTitle {
    
    SSBackBarButton *backView = [[SSBackBarButton alloc] initWithImage:[SDImage backImage] title:backTitle target:self action:@selector(back)];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addRightBarItem:(UIImage *)image target:(id)target action:(SEL)action {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
}

- (void)addLeftBarItem:(UIImage *)image target:(id)target action:(SEL)action {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
}

@end
