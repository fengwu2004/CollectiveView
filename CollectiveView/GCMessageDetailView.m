//
//  GCMessageDetailView.m
//  GameChat
//
//  Created by user on 15/12/22.
//  Copyright © 2015年 Ruoogle. All rights reserved.
//

#import "GCMessageDetailView.h"

@interface GCMessageDetailView()

@property (nonatomic, retain) IBOutlet UIImageView *ibImageAvatar;
@property (nonatomic, retain) IBOutlet UILabel *ibLabelMessage;

@end

@implementation GCMessageDetailView

- (void)setMessage:(NSString*)message {
	
	[_ibImageAvatar setImage:[UIImage imageNamed:@"avatar"]];
	
	[_ibLabelMessage setText:message];
}

- (IBAction)onDetailClick:(id)sender {
	
//	CGFloat height = self.frame.size.height;
//	
	CGFloat width = self.frame.size.width;
	
	CGPoint center = self.center;
	
	center.x -= 230;
	
	[UIView animateWithDuration:0.5 animations:^{
	
		self.center = center;
		
//		[self.superview layoutIfNeeded];
	}];
}

@end
