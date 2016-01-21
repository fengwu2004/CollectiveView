//
//  OCCallJavaScript.m
//  CollectiveView
//
//  Created by user on 16/1/8.
//  Copyright © 2016年 user. All rights reserved.
//

#import "OCCallJavaScript.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "GCGift.h"

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

- (GCGift*)createGift:(NSString*)name coin:(int)coin charming:(int)charm imageUrl:(NSString*)imageUrl {
	
	GCGift *gift0 = [[GCGift alloc] init];
	
	gift0.name = name;
	
	gift0.coin = coin;
	
	gift0.charming = charm;
	
	gift0.imageUrl = imageUrl;

	return gift0;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	
	JSContext *context = [_ibWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
	
	GCGift *gift0 = [self createGift:@"别墅" coin:20 charming:120 imageUrl:@"http://staticnova.ruoogle.com/gift/giftn12.png"];
	
	GCGift *gift1 = [self createGift:@"跑车" coin:20 charming:120 imageUrl:@"http://staticnova.ruoogle.com/gift/giftn11.png"];
	
	GCGift *gift2 = [self createGift:@"钻石" coin:20 charming:120 imageUrl:@"http://staticnova.ruoogle.com/gift/giftn104.png"];
	
	GCGift *gift3 = [self createGift:@"包包" coin:20 charming:120 imageUrl:@"http://staticnova.ruoogle.com/gift/giftn103.png"];
	
	GCGift *gift4 = [self createGift:@"充气娃娃" coin:20 charming:120 imageUrl:@"http://staticnova.ruoogle.com/gift/giftn102.png"];
	
	context[@"retriveGiftData"] = ^NSArray*(){
		
		NSArray *array = @[gift0, gift1, gift2, gift3, gift4];
		
		return array;
	};
}


@end
