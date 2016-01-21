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
	
	NSDictionary *gift0 = @{@"name":@"别墅", @"coin":@20, @"charming":@120, @"imageurl":@"http://staticnova.ruoogle.com/gift/giftn12.png"};
	
	NSDictionary *gift1 = @{@"name":@"跑车", @"coin":@20, @"charming":@120, @"imageurl":@"http://staticnova.ruoogle.com/gift/giftn11.png"};
	
	NSDictionary *gift2 = @{@"name":@"钻石", @"coin":@20, @"charming":@120, @"imageurl":@"http://staticnova.ruoogle.com/gift/giftn104.png"};
	
	NSDictionary *gift3 = @{@"name":@"包包", @"coin":@20, @"charming":@120, @"imageurl":@"http://staticnova.ruoogle.com/gift/giftn103.png"};
	
	NSDictionary *gift4 = @{@"name":@"充气", @"coin":@20, @"charming":@120, @"imageurl":@"http://staticnova.ruoogle.com/gift/giftn102.png"};
	
	context[@"retriveGiftData"] = ^NSArray*(){
		
		NSArray *array = @[gift0, gift1, gift2, gift3, gift4];
		
		return array;
	};
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
