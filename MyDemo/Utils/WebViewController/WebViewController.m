//
//  WebViewController.m
//  BaseFramework
//
//  Created by hztuen on 17/3/20.
//  Copyright © 2017年 Cesar. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()
{
    WKWebView                    *_webView;
    NSURL                        *_url;
    NSMutableURLRequest          *_request;
    CALayer                      *_progresslayer;
}
@end

@implementation WebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"ffffff" alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{ NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000" alpha:0.8], NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f]}];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"title"];
}

- (id)initWithUrl:(NSString *)url title:(NSString *)title {
    self = [super init];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        _url = [NSURL URLWithString:url];
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        [_webView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
        _webView.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
        _request = [NSMutableURLRequest requestWithURL:_url];
        //添加属性监听
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
        //进度条
        UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT_NAVBAR, CGRectGetWidth(self.view.frame), 3)];
        progress.backgroundColor = [UIColor clearColor];
        [self.view addSubview:progress];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, 0, 3);
        layer.backgroundColor = [UIColor colorWithHexString:MainColor alpha:1.0].CGColor;
        [progress.layer addSublayer:layer];
        _progresslayer = layer;
        
        [_webView loadRequest:_request];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == _webView) {
            _progresslayer.opacity = 1;
            _progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[NSKeyValueChangeNewKey] floatValue], 3);
            if ([change[NSKeyValueChangeNewKey] floatValue] == 1) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    _progresslayer.opacity = 0;
                });
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    _progresslayer.frame = CGRectMake(0, 0, 0, 3);
                });
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
        
    } else if ([keyPath isEqualToString:@"title"]) {
        if (object == _webView) {
            self.title = _webView.title;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    
    [self buildNaviBarBackButton];
    [self createUI];
}

- (void)createUI {
    _webView.frame = CGRectMake(0, HEIGHT_NAVBAR, ScreenWidth, ScreenHeight - HEIGHT_NAVBAR);
    [self.view addSubview:_webView];
}

#pragma mark - buttonEvent
// 返回按钮的方法
- (void)clickNaviBarBackButton {
    if (_webView.canGoBack) {
        [_webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
