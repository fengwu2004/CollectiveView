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
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ganliao.qiniudn.com/giftshop.html"]];
	
	[_ibWebView loadRequest:request];
	
	JSContext *context = [_ibWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
	
	context[@"retriveGiftData"] = ^NSArray*(){
		
		NSArray *array = @[@"1", @"2", @"3"];
		
		return array;
	};
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	
	JSContext *context = [_ibWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
	
	context[@"retriveGiftData"] = ^NSArray*(){
		
		NSArray *array = @[@"1", @"2", @"3"];
		
		return array;
	};
}


@end
