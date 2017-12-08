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
#import "SDFileModel.h"
#import "SDFileManager.h"

@interface SDFileViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UIView *_topView;
    BOOL _topShowing, _dragging;
    UICollectionView *_collectionView;
    UITableView *_tableView;
    
    SDFileViewModel *_viewModel;
    SDFileModel *_fileModel;
}

@end

@implementation SDFileViewController

- (instancetype)initWithFile:(SDFileModel *)fileModel {
    if (self = [super init]) {
        _fileModel = fileModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (!_fileModel) {
        _fileModel = [[SDFileManager sharedInstance] rootComponent];
    }
    
    self.navigationItem.title = _fileModel.name;
    
    _viewModel = [[SDFileViewModel alloc] initWithFile:_fileModel];
    
    [self loadFileView];
    [self loadTopView];
}

- (void)loadTopView {
    _topView = [[UIView alloc] init];
    _topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topView];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(_viewModel.fileAddViewOrignalY);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(_viewModel.fileAddViewHeight);
    }];
    
    //  添加文件页面
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [_collectionView registerClass:[SDFileAddCell class] forCellWithReuseIdentifier:@"SDFileAddCell"];
    [_topView addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_topView);
    }];
    
    [_topView showLine:SSLinePositionBottom];
    
    _topView.layer.opacity = 0;
}

- (void)loadFileView {
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
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(_viewModel.fileAddViewOrignalY);
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
    [_viewModel viewController:self openFile:_viewModel.files[indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kFileCellHeight;
}

#pragma mark - UIScrollViewDelegate -

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_collectionView]) {
        return;
    }
    _dragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_collectionView] || !_dragging) {
        return;
    }
    
    CGFloat progress = scrollView.contentOffset.y;
    CGFloat franction = (-progress)/_viewModel.fileAddViewHeight;
    franction = MAX(MIN(franction, 1), 0);
    CGFloat displacement = - (_viewModel.fileAddViewHeight + progress)/2;
    displacement = MAX(MIN(displacement, 0), -_viewModel.fileAddViewHeight/2);
    
    CATransform3D transform = CATransform3DConcat(CATransform3DMakeRotation(acos(franction), 1, 0, 0), CATransform3DMakeTranslation(0, displacement, 0));
    _topView.layer.transform = transform;
    _topView.layer.opacity = franction;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([scrollView isEqual:_collectionView]) {
        return;
    }
    _dragging = NO;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_collectionView]) {
        return;
    }
    CGFloat progress = scrollView.contentOffset.y;
    CGFloat franction = - progress/_viewModel.fileAddViewHeight;
    franction = MAX(MIN(franction, 1), 0);
    if (_topShowing) {
        if (progress > 0) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _tableView.contentInset = UIEdgeInsetsZero;
                _topView.layer.transform = CATransform3DConcat(CATransform3DMakeRotation(acos(1), 0, 1, 0), CATransform3DMakeTranslation(0, -_viewModel.fileAddViewHeight/2, 0));
                _topView.layer.opacity = 0;
            } completion:^(BOOL finished) {
                _topShowing = NO;
            }];
        }else {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _topView.layer.transform = CATransform3DIdentity;
                _topView.layer.opacity = 1;
            } completion:^(BOOL finished) {
                _topShowing = YES;
            }];
        }
    }
    else {
        if (franction >= 0.618) {
            UIEdgeInsets insets = UIEdgeInsetsZero;
            insets.top += _viewModel.fileAddViewHeight;
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _tableView.contentInset = insets;
                _topView.layer.transform = CATransform3DIdentity;
                _topView.layer.opacity = 1;
            } completion:^(BOOL finished) {
                _topShowing = YES;
            }];
        }
        else{
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _topView.layer.transform = CATransform3DConcat(CATransform3DMakeRotation(acos(1), 0, 1, 0), CATransform3DMakeTranslation(0, -_viewModel.fileAddViewHeight/2, 0));
                _topView.layer.opacity = 0;
            } completion:NULL];
        }
    }
}

#pragma mark - end

@end
