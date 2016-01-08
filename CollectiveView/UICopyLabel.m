//
//  UICopyLabel.m
//  CollectiveView
//
//  Created by user on 16/1/4.
//  Copyright © 2016年 user. All rights reserved.
//

#import "UICopyLabel.h"

@implementation UICopyLabel

-(BOOL)canBecomeFirstResponder {
	
	return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
	
	return (action == @selector(copyText:));
}

-(void)copyText:(id)sender {
	
	UIPasteboard *pboard = [UIPasteboard generalPasteboard];
	
	pboard.string = self.text;
}

-(void)attachTapHandler {
	
	self.userInteractionEnabled = YES;  //用户交互的总开关
	
	UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
	
//	touch.numberOfTapsRequired = 1;
	
	[self addGestureRecognizer:touch];
}

- (id)initWithFrame:(CGRect)frame {
	
	self = [super initWithFrame:frame];
	
	if (self)	{
		
		[self attachTapHandler];
	}
	
	return self;
}

-(void)awakeFromNib {
	
	[super awakeFromNib];
	
	[self attachTapHandler];
}

-(void)handleTap:(UIGestureRecognizer*) recognizer {
	
 [self becomeFirstResponder];
	
 UIMenuItem *copyLink = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyText:)];
	
 [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyLink, nil]];
	
 [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
	
 [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

@end
