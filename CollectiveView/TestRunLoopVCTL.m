//
//  TestRunLoopVCTL.m
//  CollectiveView
//
//  Created by user on 15/12/31.
//  Copyright © 2015年 user. All rights reserved.
//

#import "TestRunLoopVCTL.h"
#import "RunLoopTask.h"

@interface TestRunLoopVCTL ()

@property (nonatomic, assign) BOOL downloadFinish;
@property (nonatomic, assign) CGFloat downloadPercent;

@end

@implementation TestRunLoopVCTL

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	
	RunLoopTask *task1 = [[RunLoopTask alloc] init];
	
	[queue addOperation:task1];
	
	RunLoopTask *task2 = [[RunLoopTask alloc] init];
	
	[queue addOperation:task2];
	
	RunLoopTask *task3 = [[RunLoopTask alloc] init];
	
	[queue addOperation:task3];
}

- (IBAction)onStart:(id)sender {
	
	_downloadFinish = NO;
	
	[NSThread detachNewThreadSelector:@selector(downLoadData:) toTarget:self withObject:nil];
	
	[_ibProgress setProgress:_downloadPercent];
	
	while (!_downloadFinish) {
		
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	}
	
	[_ibProgress setHidden:YES];
}

- (void)downLoadData:(id)sender {
	
	
}

@end
