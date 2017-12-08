//
//  SDTXTReaderCatalogView.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/8.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderCatalogView.h"
#import "SDTXTReaderCatalogCell.h"
#import "UIView+Line.h"
#import "SDTXTReader.h"

@interface SDTXTReaderCatalogView () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}

@end

@implementation SDTXTReaderCatalogView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:NSClassFromString(@"SDTXTReaderCatalogCell") forCellReuseIdentifier:@"SDTXTReaderCatalogCell"];
        [self addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.bottom.equalTo(self).offset(-44);
        }];
        
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:SD(@"滚到当前阅读页面") forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(scrollToCurrentChapter) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.height.mas_equalTo(44);
        }];
        
        [button showLine:SSLinePositionTop];
    }
    return self;
}

- (void)scrollToCurrentChapter {
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [SDTXTReader sharedInstance].chapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDTXTReaderCatalogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SDTXTReaderCatalogCell" forIndexPath:indexPath];
    cell.chapter = [SDTXTReader sharedInstance].chapters[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
