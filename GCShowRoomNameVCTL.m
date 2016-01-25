//
//  GCShowRoomNameVCTL.m
//  CollectiveView
//
//  Created by user on 16/1/25.
//  Copyright © 2016年 user. All rights reserved.
//

#import "GCShowRoomNameVCTL.h"

@interface GCShowRoomNameVCTL()<UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *ibInput;
@property (nonatomic, retain) IBOutlet UILabel *ibLabelInfo;

@end

@implementation GCShowRoomNameVCTL

- (void)viewDidAppear:(BOOL)animated {
	
	[super viewDidAppear:animated];
	
	[_ibInput becomeFirstResponder];
	
	NSString *info = @"0/12";
	
	NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:info];
	
	[str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, info.length - 3)];
	
	[_ibLabelInfo setAttributedText:str];
	
	[_ibInput addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[textField resignFirstResponder];
	
	return YES;
}

- (void)textFieldDidChange:(UITextField*)sender {
	
	NSString *name = [_ibInput text];
	
	if (name.length >= 12) {
		
		_ibInput.text = [name substringToIndex:12];
	}
	
	NSString *info = [NSString stringWithFormat:@"%d/12", (int)(_ibInput.text.length)];
	
	NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:info];
	
	[str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, info.length - 3)];
	
	[_ibLabelInfo setAttributedText:str];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
	
	return YES;
}

@end
