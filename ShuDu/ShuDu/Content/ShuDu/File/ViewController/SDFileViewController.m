//
//  SDFileViewController.m
//  ShuDu
//
//  Created by 邵帅 on 2017/11/17.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDFileViewController.h"
#import "SDFileViewModel.h"
#import "SDFileAddCell.h"
#import "SDFileCell.h"
#import "UIView+Line.h"

@interface SDFileViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    UITableView *_tableView;
    
    SDFileViewModel *_viewModel;
}

@end

@implementation SDFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _viewModel = [[SDFileViewModel alloc] init];
    
    //  添加文件页面
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    if (@available(ios 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [_collectionView registerClass:[SDFileAddCell class] forCellWithReuseIdentifier:@"SDFileAddCell"];
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(_viewModel.fileAddViewOrignalY);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(_viewModel.fileAddViewHeight);
    }];
    
    [_collectionView showLine:SSLinePositionTop|SSLinePositionBottom];
    
    //  文件列表
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    if (@available(ios 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_tableView registerClass:[SDFileCell class] forCellReuseIdentifier:@"SDFileCell"];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_collectionView.mas_bottom);
    }];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _viewModel.fileAddItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SDFileAddCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SDFileAddCell" forIndexPath:indexPath];
    cell.itemModel = _viewModel.fileAddItems[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.height - 10, collectionView.frame.size.height - 10);
}

#pragma mark - UITableViewDelegate, UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.files.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDFileCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SDFileCell" forIndexPath:indexPath];
    cell.fileModel = _viewModel.files[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kFileCellHeight;
}

@end
