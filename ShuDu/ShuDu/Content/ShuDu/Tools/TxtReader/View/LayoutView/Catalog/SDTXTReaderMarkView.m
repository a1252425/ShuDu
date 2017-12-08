//
//  SDTXTReaderMarkView.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/8.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderMarkView.h"
#import "SDTXTReaderMarkCell.h"
#import "UIView+Line.h"

#import "SDTXTReader.h"
#import "SDTXTRecordModel.h"
#import "SDTXTReaderMarkModel.h"
#import "SDTXTReaderLayoutProtocol.h"

@interface SDTXTReaderMarkView () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    SDTXTRecordModel *_recordModel;
}

@end

@implementation SDTXTReaderMarkView

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
        [_tableView registerClass:NSClassFromString(@"SDTXTReaderMarkCell") forCellReuseIdentifier:@"SDTXTReaderMarkCell"];
        [self addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        _recordModel = [SDTXTReader sharedInstance].recordModel;
        [_recordModel addObserver:self forKeyPath:@"bookmarks" options:NSKeyValueObservingOptionNew context:@"SDTXTReaderMarkView"];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"bookmarks"]) {
        [_tableView reloadData];
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [SDTXTReader sharedInstance].recordModel.bookmarks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDTXTReaderMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SDTXTReaderMarkCell" forIndexPath:indexPath];
    cell.mark = _recordModel.bookmarks[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 104.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDTXTReaderMarkModel *markModel = _recordModel.bookmarks[indexPath.row];
    [[SDTXTReader sharedInstance].layoutView mark:markModel.chapter offset:markModel.offset];
}

- (void)dealloc {
    [_recordModel removeObserver:self forKeyPath:@"bookmarks" context:@"SDTXTReaderMarkView"];
}

@end

