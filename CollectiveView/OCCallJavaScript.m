//
//  OCCallJavaScript.m
//  CollectiveView
//
//  Created by user on 16/1/8.
//  Copyright © 2016年 user. All rights reserved.
//

#import "OCCallJavaScript.h"
#import <JavaScriptCore/JavaScriptCore.h>

@implementation OCCallJavaScript

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	NSString *urlString = @"https://www.baidu.com";
	
	NSURL *url = [NSURL URLWithString:urlString];
	
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	
	[_ibWebView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	
	JSContext *context = [_ibWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
	
	NSString *jsCode = @"alert('test js oc')";
	
	[context evaluateScript:jsCode];
}


@end
