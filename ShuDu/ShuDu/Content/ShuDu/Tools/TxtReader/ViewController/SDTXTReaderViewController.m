//
//  SDTXTReaderViewController.m
//  ShuDu
//
//  Created by 邵帅 on 2017/12/4.
//  Copyright © 2017年 邵帅. All rights reserved.
//

#import "SDTXTReaderViewController.h"

#import "SDTXTReader.h"
#import "SDTXTReaderViewModel.h"
#import "SDTXTChapterModel.h"
#import "SDFileModel.h"

#import "SDTXTReaderLayoutView.h"
#import "SDTXTReaderLayoutProtocol.h"

@interface SDTXTReaderViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIGestureRecognizerDelegate, SDTXTReaderLayoutProtocol>
{
    SDTXTReaderViewModel *_viewModel;
    SDFileModel *_fileModel;
    
    UIPageViewController *_pageViewController;
}

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) SDTXTReaderLayoutView *layoutView;

@end

@implementation SDTXTReaderViewController

- (instancetype)initWithFile:(SDFileModel *)fileModel {
    if (self = [super init]) {
        _fileModel = fileModel;
        
        _viewModel = [[SDTXTReaderViewModel alloc] initWithFile:fileModel];
        [SDTXTReader sharedInstance].recordModel = _viewModel.recordModel;
        [SDTXTReader sharedInstance].chapters = _viewModel.chapters;
    }
    return self;
}

- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:NULL];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self.view addSubview:_pageViewController.view];
        [self addChildViewController:_pageViewController];
    }
    
    return _pageViewController;
}

- (SDTXTReaderLayoutView *)layoutView {
    if (!_layoutView) {
        _layoutView = [[SDTXTReaderLayoutView alloc] init];
        _layoutView.delegate = self;
        [self.view addSubview:_layoutView];
        
        UIEdgeInsets insets = UIEdgeInsetsZero;
        if (@available(iOS 11.0, *)) {
            insets = [UIApplication sharedApplication].keyWindow.safeAreaInsets;
        }
        [_layoutView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(insets);
        }];
    }
    return _layoutView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kDefaultBackgroundColor;
    
    [self pageViewController];
    [self.pageViewController setViewControllers:@[[_viewModel currentPageViewController]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:NULL];
    
    [SDTXTReader sharedInstance].layoutView = self.layoutView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.layoutView updateAppearance];
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    [self.layoutView updateAppearance];
    [self updateAppearance];
}

#pragma mark - UIGestureRecognizerDelegate -

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return [touch.view isKindOfClass:NSClassFromString(@"SDTXTReaderPageView")] || [touch.view isKindOfClass:[SDTXTReaderLayoutView class]];
}

#pragma mark - StatusBar -

- (BOOL)prefersStatusBarHidden {
    return self.layoutView.status;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

#pragma mark - UIPageViewControllerDelegate, UIPageViewControllerDataSource -

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    return [_viewModel nextPageViewController];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return [_viewModel lastPageViewController];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    [_viewModel finishTransition:completed];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    [_viewModel willTransition];
}

#pragma mark - SDTXTReaderLayoutProtocol -

- (void)close {
    [[SDTXTReader sharedInstance] clear];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)updateAppearance {
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)finishAnimated {
    [_viewModel finishTransition:YES];
}

- (void)next {
    UIViewController *controller = [_viewModel nextChapterViewController];
    if (!controller) {
        return;
    }
    typeof(self) weakSelf = self;
    [self.pageViewController setViewControllers:@[controller]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:^(BOOL finished) {
                                         [weakSelf finishAnimated];
                                     }];
    [_viewModel willTransition];
}

- (void)last {
    UIViewController *controller = [_viewModel lastChapterViewController];
    if (!controller) {
        return;
    }
    typeof(self) weakSelf = self;
    [self.pageViewController setViewControllers:@[controller]
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:YES
                                     completion:^(BOOL finished) {
                                         [weakSelf finishAnimated];
                                     }];
    [_viewModel willTransition];
}

- (void)index:(NSInteger)index {
    UIViewController *controller = [_viewModel chapterViewController:index];
    if (!controller) {
        return;
    }
    [self.pageViewController setViewControllers:@[controller]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:NULL];
    [_viewModel willTransition];
    [_viewModel finishTransition:YES];
}

- (void)mark:(NSInteger)chapter offset:(NSInteger)offset {
    UIViewController *controller = [_viewModel chapterViewController:chapter offset:offset];
    if (!controller) {
        return;
    }
    [self.pageViewController setViewControllers:@[controller]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:NULL];
    [_viewModel willTransition];
    [_viewModel finishTransition:YES];
}

@end
