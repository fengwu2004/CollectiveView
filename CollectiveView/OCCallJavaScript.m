//
//  OCCallJavaScript.m
//  CollectiveView
//
//  Created by user on 16/1/8.
//  Copyright © 2016年 user. All rights reserved.
//

#import "OCCallJavaScript.h"
#import "GCGift.h"

@import JavaScriptCore;

@implementation OCCallJavaScript

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	NSString *urlString = [[NSBundle mainBundle] pathForResource:@"giftshop" ofType:@"html"];
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
	
	[_ibWebView loadRequest:request];
	
	JSContext *context = [_ibWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
	
	NSString *gift20 = [[NSBundle mainBundle] pathForResource:@"lw_gift20" ofType:@"png"];
	
	NSDictionary *gift0 = @{@"name":@"别墅", @"coin":@20, @"charming":@120, @"imageurl":gift20};
	
	NSDictionary *gift1 = @{@"name":@"跑车", @"coin":@20, @"charming":@120, @"imageurl":@"lw_gift30.png"};
	
	NSDictionary *gift2 = @{@"name":@"钻石", @"coin":@20, @"charming":@120, @"imageurl":@"lw_gift40.png"};
	
	NSDictionary *gift3 = @{@"name":@"包包", @"coin":@20, @"charming":@120, @"imageurl":@"lw_gift50"};
	
	NSDictionary *gift4 = @{@"name":@"充气", @"coin":@20, @"charming":@120, @"imageurl":@"giftn104"};
	
	context[@"retriveGiftData"] = ^NSArray*(){
		
		NSArray *array = @[gift0, gift1, gift2, gift3, gift4];
		
		return array;
	};
	
	[context[@"refreshWeb"] callWithArguments:nil];
}

- (GCGift*)createGift:(NSString*)name coin:(int)coin charming:(int)charm imageUrl:(NSString*)imageUrl {
	
	GCGift *gift0 = [[GCGift alloc] init];
	
	gift0.name = name;
	
	gift0.coin = coin;
	
	gift0.charming = charm;
	
	gift0.imageurl = imageUrl;

	return gift0;
}

@end
