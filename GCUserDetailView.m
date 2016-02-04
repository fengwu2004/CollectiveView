//
//  GCUserDetailView.m
//  CollectiveView
//
//  Created by user on 16/2/4.
//  Copyright © 2016年 user. All rights reserved.
//

#import "GCUserDetailView.h"

@interface GCUserDetailView()

@property (nonatomic, retain) UIWindow *bgWindow;
@property (nonatomic, retain) IBOutlet UIView *centerView;

@end

@implementation GCUserDetailView

- (void)awakeFromNib {
	
	[super awakeFromNib];
}

- (void)show {

	self.bounds = [UIApplication sharedApplication].keyWindow.bounds;
	
	self.center = [UIApplication sharedApplication].keyWindow.center;
	
	[[UIApplication sharedApplication].keyWindow addSubview:self];
	
	_centerView.transform = CGAffineTransformMakeScale(0.5, 0.5);
	
	[self layoutIfNeeded];

	[UIView animateWithDuration:3 animations:^{
	
		_centerView.transform = CGAffineTransformMakeScale(1, 1);
		
		[self layoutIfNeeded];
	}];
}

- (IBAction)onHide:(id)sender {
	
	[self removeFromSuperview];
}

@end
