//
//  ViewController.m
//  CollectiveView
//
//  Created by user on 15/12/15.
//  Copyright © 2015年 user. All rights reserved.
//

#import "ViewController.h"
#import "GCGiftView.h"
#import "TableController.h"
#import "AnimViewController.h"

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
	
	//如果你使用代码添加了view并且出现了NSAutoresizingMaskLayoutConstraint相关的问题，你应该将该View的translatesAutoresizingMaskIntoConstraints设置为NO
	view.translatesAutoresizingMaskIntoConstraints = NO;

	[self.view addSubview:view];
	
	NSLayoutConstraint * constrint = [view.topAnchor constraintEqualToAnchor:self.view.bottomAnchor];
	
	constrint.active = YES;
	
	[view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
	
	[view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
	
	[view.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.4].active = YES;
	
	[self.view layoutIfNeeded];
	
	[UIView animateWithDuration:5 animations:^{
		
		constrint.constant = -1 * view.bounds.size.height;
		
		[self.view layoutIfNeeded];
	}];
}

- (IBAction)onTableView:(id)sender {
	
	TableController *vctl = [[TableController alloc] init];
	
	[self.navigationController pushViewController:vctl animated:NO];
}

- (IBAction)onAnimView:(id)sender {
	
	AnimViewController *vctl = [[AnimViewController alloc] init];
	
	[self.navigationController pushViewController:vctl animated:NO];
}

@end
