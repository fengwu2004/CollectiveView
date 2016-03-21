//
//  BadWordFilter.m
//  CollectiveView
//
//  Created by user on 16/2/22.
//  Copyright © 2016年 user. All rights reserved.
//

#import "BadWordFilter.h"
#import "TrieFilter.h"
#import "MyData.h"

@implementation BadWordFilter

+ (BadWordFilter*)sharedInstance {
	
	static BadWordFilter *_instance = nil;
	
	static dispatch_once_t predicate;
	
	dispatch_once(&predicate, ^{
		
		_instance = [[BadWordFilter alloc] init];
	});
	
	return _instance;
}

- (void)test {
	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"txt"];
	
	NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
	
	NSArray *array = [str componentsSeparatedByString:@"\r\n"];
	
	for (NSInteger i = 0; i < array.count; ++i) {
		
		NSString *value = array[i];
		
		[[TrieFilter sharedInstance] AddKey:value];
	}
	
	BOOL b = [[TrieFilter sharedInstance] HasBadWord:@"名字加fuck日本人妖"];
	
	if (b) {
		
		NSLog(@"有屏蔽字");
	}
	else {
		
		NSLog(@"没有屏蔽字");
	}
}

- (void)setMyData:(MyData *)myData {
	
	_myData = myData;
}

- (void)log {
	
	NSLog(@"abcd");
}

@end
