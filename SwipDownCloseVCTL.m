//
//  SwipDownCloseVCTL.m
//  CollectiveView
//
//  Created by user on 16/3/16.
//  Copyright © 2016年 user. All rights reserved.
//

#import "SwipDownCloseVCTL.h"

@interface SwipDownCloseVCTL()

@property (nonatomic, retain) UISwipeGestureRecognizer *downSwipeGesture;
@property (nonatomic, retain) UISwipeGestureRecognizer *upSwipeGesture;

@end

@implementation SwipDownCloseVCTL

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	_downSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeDown:)];
	
	_downSwipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
	
	[self.view addGestureRecognizer:_downSwipeGesture];
	
	_upSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeUp:)];
	
	_upSwipeGesture.direction = UISwipeGestureRecognizerDirectionUp;
	
	[self.view addGestureRecognizer:_upSwipeGesture];
}

- (void)onSwipeUp:(id)sender {
	
	UISwipeGestureRecognizer *gesture = (UISwipeGestureRecognizer *)sender;
	
	if (!gesture) {
		
		return;
	}
	
	NSLog(@"上");
}

- (void)onSwipeDown:(id)sender {
	
	UISwipeGestureRecognizer *gesture = (UISwipeGestureRecognizer *)sender;
	
	if (!gesture) {
		
		return;
	}
	
	NSLog(@"下");
}

@end
