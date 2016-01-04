//
//  RunLoopTask.m
//  CollectiveView
//
//  Created by user on 15/12/31.
//  Copyright © 2015年 user. All rights reserved.
//

#import "RunLoopTask.h"

@implementation RunLoopTask

- (void)main {
	
	NSLog(@"开始线程=%llx", (long long)self);
	
	NSTimer * timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(handleTime:) userInfo:nil repeats:NO];
	
	[timer fire];
}

- (void)handleTime:(id)sender {
	
	NSLog(@"执行了NSTimer");
}

- (void)dealloc {
	
	NSLog(@"dealloc");
}

@end
