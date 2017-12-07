//
//  SDTXTReaderPageViewController.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/5.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderPageViewController.h"

#import "SDTXTPageModel.h"
#import "SDTXTChapterModel.h"
#import "SDTXTReaderPageView.h"
#import "SDTXTConfigModel.h"
#import "SDFileModel.h"

@interface SDTXTReaderPageViewController ()
{
    SDTXTPageModel *_pageModel;
    SDTXTReaderPageView *_pageView;
}

@end

@implementation SDTXTReaderPageViewController

- (instancetype)initWithPage:(SDTXTPageModel *)pageModel {
    if (self = [super init]) {
        _pageModel = pageModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [SDTXTConfigModel sharedInstance].themeColor;
    
    _pageView = [[SDTXTReaderPageView alloc] initWithContent:_pageModel.content];
    [self.view addSubview:_pageView];
    
    [_pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont boldSystemFontOfSize:11];
    titleLabel.textColor = [SDTXTConfigModel sharedInstance].fontColor;
    titleLabel.text = _pageModel.chapter.fileModel.name;
    [self.view addSubview:titleLabel];
    
    UIEdgeInsets insets = [SDTXTConfigModel sharedInstance].contentInsets;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(insets.left);
        make.top.equalTo(self.view).offset(insets.top-20);
    }];
    
    UILabel *chapterLabel = [[UILabel alloc] init];
    chapterLabel.font = [UIFont boldSystemFontOfSize:11];
    chapterLabel.textColor = [SDTXTConfigModel sharedInstance].fontColor;
    chapterLabel.text = _pageModel.chapter.title;
    chapterLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:chapterLabel];
    
    [chapterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(insets.top-20);
        make.right.equalTo(self.view).offset(-insets.right);
        make.width.equalTo(titleLabel);
    }];
}

@end
