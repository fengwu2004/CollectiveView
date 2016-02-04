//
//  GCProgressBar.m
//  GameChat
//
//  Created by user on 15/8/6.
//  Copyright (c) 2015年 Ruoogle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCProgressBar.h"

#define CGRectSet(view, xx, yy, ww, hh) [view setFrame:CGRectMake((xx)==-1?view.frame.origin.x:(xx), (yy)==-1?view.frame.origin.y:(yy),(ww)==-1?view.frame.size.width:(ww), (hh)==-1?view.frame.size.height:(hh))]

@implementation GCProgressBar

- (id)initWithSize:(CGSize)size {
	
	self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
	
	_progressBarBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
	
	[_progressBarBg setBackgroundColor:[UIColor whiteColor]];
	
	[self addSubview:_progressBarBg];
	
	_progressBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, size.height)];
	
	[_progressBar setBackgroundColor:[UIColor orangeColor]];
	
	[self addSubview:_progressBar];
	
	_maxValue = size.width;
	
	self.layer.borderWidth = 1;
	
	self.layer.cornerRadius = 10;
	
	self.clipsToBounds = YES;

	return self;
}

- (void)setPercent:(CGFloat)value {
	
	CGFloat width = value * _maxValue;
	
	CGRectSet(_progressBar, -1, -1, width, -1);
}

@end