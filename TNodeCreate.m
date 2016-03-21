//
//  TNodeCreate.m
//  CollectiveView
//
//  Created by user on 16/3/21.
//  Copyright © 2016年 user. All rights reserved.
//

#import "TNodeCreate.h"
#import "TNode.h"

#define str1 @"virtualcalbald"
#define str2 @"heading"
#define str3 @"mechanical"
#define str4 @"mekdwoddfanical"
#define str5 @"mecsdfwefjl"
#define str6 @"msdlfe"

@interface TNodeTreeCreater()



@end

@implementation TNodeTreeCreater

+ (TNodeTreeCreater*)sharedInstance {
	
	static TNodeTreeCreater *_instance = nil;
	
	static dispatch_once_t predicate;
	
	dispatch_once(&predicate, ^{
		
		_instance = [[TNodeTreeCreater alloc] init];
	});
	
	return _instance;
}

- (id)init {
	
	self = [super init];
	
	if (self) {
		
		NSLog(@"斯蒂芬金");
		
		_alphabetMap = [[NSMutableDictionary alloc] init];
	}
	
	return self;
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

- (void)start {
	
	NSArray *array = @[str1, str2, str3, str4, str5, str6];
	
	TNode *node = [[TNode alloc] init];
	
	for (NSInteger i = 0; i < array.count; ++i) {
		
		NSString *value = array[i];
		
		[node addWord:value];
	}
	
	NSLog(@"%d", (int)[node.subNodes count]);
	
	NSLog(@"%d", (int)[_alphabetMap count]);
	
	NSLog(@"end");
}

@end
