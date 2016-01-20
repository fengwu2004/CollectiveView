//
//  GCIdentityInputView.m
//  GameChat
//
//  Created by user on 16/1/18.
//  Copyright © 2016年 Ruoogle. All rights reserved.
//

#import "GCIdentityInputView.h"

@interface GCIdentityInputView() <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *ibText;

@end

@implementation GCIdentityInputView

- (void)awakeFromNib {
	
	[super awakeFromNib];
	
	[_ibText setDelegate:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[_ibText resignFirstResponder];
	
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	
	return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
	
	NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
	
	int i = 0;
	
	while (i < number.length) {
		
		NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
		
		NSRange range = [string rangeOfCharacterFromSet:tmpSet];
		
		if (range.length == 0) {
			
			return NO;
		}
		
		i++;
	}
	
	return YES;
}

- (NSString*)retriveIdNumber {
	
	return _ibText.text;
}

@end
