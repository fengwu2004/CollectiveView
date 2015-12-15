//
//  ViewController.m
//  CollectiveView
//
//  Created by user on 15/12/15.
//  Copyright © 2015年 user. All rights reserved.
//

#import "ViewController.h"
#import "GCGiftView.h"

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (UIView *)viewByClassName:(NSString *)className inNib:(NSString *)nibName {
	
	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
	
	Class cellClass = NSClassFromString(className);
	
	for (id oneObject in nib) {
		
		if ([oneObject isMemberOfClass:cellClass]) {
			
			return oneObject;
		}
	}
	
	return nil;
}

- (IBAction)onGiftBtnClick:(id)sender {
	
	GCGiftView *view = (GCGiftView*)[self viewByClassName:@"GCGiftView" inNib:@"GCGiftView"];
	
	view.frame = CGRectMake(0, SCREEN_HEIGHT- 270, SCREEN_WIDTH, 270);
	
	[self.view addSubview:view];
}

@end
