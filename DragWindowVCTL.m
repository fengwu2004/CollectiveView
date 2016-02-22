//
//  DragWindowVCTL.m
//  CollectiveView
//
//  Created by user on 16/2/17.
//  Copyright © 2016年 user. All rights reserved.
//

#import "DragWindowVCTL.h"

@interface DragWindowVCTL ()

@property (nonatomic, retain) UIView *ibDragView;
@property (nonatomic, assign) CGFloat offsetY;

@end

@implementation DragWindowVCTL

- (void)viewDidLoad {
	
  [super viewDidLoad];
	
	_ibDragView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 200, 200)];
	
	_ibDragView.backgroundColor = [UIColor grayColor];
	
	[self.view addSubview:_ibDragView];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)];
	
	[_ibDragView addGestureRecognizer:tap];
	
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onMove:)];
	
	[_ibDragView addGestureRecognizer:pan];
	
	_offsetY = 0;
}

- (void)onClick:(UITapGestureRecognizer*)tap {
	
	
}

- (void)onMove:(UIPanGestureRecognizer*)pan {
	
	CGPoint point = [pan locationInView:self.view];
	
	_ibDragView.center = point;
}


@end
