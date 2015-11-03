//
//  WebViewController.m
//  MapKitView
//
//  Created by Aditya Narayan on 9/2/15.
//  Copyright (c) 2015 Angie Chilmaza. All rights reserved.
//

#import "WebViewController.h"

@import WebKit;

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    webView.frame = self.view.frame;
    self.view = webView;
    
    webView.navigationDelegate = self;
    
    NSURLRequest * request = [NSURLRequest requestWithURL:self.url];
    [webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
