//
//  TestBlock.m
//  CollectiveView
//
//  Created by user on 16/3/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import "TestBlock.h"

@interface TestBlock()

@property (nonatomic, retain) UIView *view;

@end

@implementation TestBlock

- (id)init {
	
	self = [super init];
	
	[self test];
	
	return self;
}

- (NSString*)datestring {
	
	_view = [[UIView alloc] init];
	
	return [NSString stringWithFormat:@"%@", NSStringFromClass([_view class])];
}

- (void)test {
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		
		NSLog(@"测试内存%@", [self datestring]);
	});
}

- (void)dealloc {
	
	NSLog(@"ABCDEFGHIJKLMN");
}

@end
