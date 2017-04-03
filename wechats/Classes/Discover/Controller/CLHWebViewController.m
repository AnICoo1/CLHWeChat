//
//  CLHShopViewController.m
//  wechats
//
//  Created by AnICoo1 on 2017/3/5.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import "CLHWebViewController.h"
#import <WebKit/WebKit.h>

@interface CLHWebViewController ()

@property(nonatomic, weak) UIView *contentView;

@property(nonatomic, weak) WKWebView *webView;

@property(nonatomic, strong) UIProgressView *progressView;

@end

@implementation CLHWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化
    [self setUpAll];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.webView.frame = self.contentView.bounds;
}

- (void)setUpAll{
    //占位View
    UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake(0, 66, screenW, screenH - 66)];
    self.contentView = contentV;
    //网页
    WKWebView *webView = [[WKWebView alloc] init];
    NSURLRequest *urlRequst = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [webView loadRequest:urlRequst];
    self.webView = webView;
    // 进度监听
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    //进度条
    UIProgressView *proView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView = proView;
    self.progressView.frame = CGRectMake(0, 64, screenW, 2);
    proView.tintColor = [UIColor blueColor];
    
    
    [self.view addSubview:proView];
    [self.view addSubview:contentV];
    [self.contentView addSubview:webView];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.title = self.webView.title;
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress >= 1;
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end
