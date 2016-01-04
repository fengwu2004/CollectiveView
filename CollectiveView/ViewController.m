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
#import "TestRunLoopVCTL.h"
#import "UICopyLabel.h"
#import "UILabel+CopyMenu.h"

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()

@property (nonatomic, retain) UICopyLabel *myCopyEnableLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
//	UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onLabelTap:)];
//	
//	[_ibLabel setBackgroundColor:[UIColor redColor]];
//	
//	[_ibLabel addGestureRecognizer:tap];
	
	_myCopyEnableLabel = [[UICopyLabel alloc] initWithFrame:CGRectMake(100, 100, 100, 32)];
	
	_myCopyEnableLabel.text = @"abcdefghi";
	
	[self.view addSubview:_myCopyEnableLabel];
}

- (void)onLabelTap:(UITapGestureRecognizer*)sender {
	
	NSLog(@"点击label");
	
	[_ibLabel becomeFirstResponder];
	
	UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"" action:@selector(xxxx:)];
	
	[[UIMenuController sharedMenuController] setMenuItems:@[copyItem]];
	
	[[UIMenuController sharedMenuController] setTargetRect:_ibLabel.frame inView:self.view];
	
	[[UIMenuController sharedMenuController] setMenuVisible:YES animated:NO];
	
	if ([[UIMenuController sharedMenuController] isMenuVisible]) {
		
		NSLog(@"可见");
	}
}

- (void)xxxx:(id)sender {
	
	NSLog(@"点击label");
	
	NSLog(@"点击label");
}

- (void)addGradientLayer {
	
	id color1 = (id)[UIColor redColor].CGColor;
	
	id color2 = (id)[UIColor greenColor].CGColor;
	
	id color3 = (id)[UIColor blueColor].CGColor;
	
	NSArray *colors = @[color1, color2, color3];
	
	NSArray *locations = @[@0.0, @0.4, @1.0];
	
	CAGradientLayer *layer = [CAGradientLayer layer];
	
	layer.colors = colors;
	
	layer.locations = locations;
	
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
	
	layer.frame = view.bounds;
	
	[view.layer insertSublayer:layer atIndex:0];
	
	[self.view addSubview:view];
}

- (void)addTap {
	
	UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
	
	btn.backgroundColor = [UIColor redColor];
	
	[btn addTarget:self action:@selector(onTap:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:btn];
	
	[UIView animateWithDuration:100 animations:^{
		
		[btn setCenter:CGPointMake(0, 100)];
	}];
	
	[self performSelector:@selector(display:) withObject:btn afterDelay:2];
}

- (void)display:(id)sender {
	
	UIButton *btn = (UIButton *)sender;
	
	NSLog(@"sdfsdfsadffsd:%@", NSStringFromCGRect(btn.frame));
}

- (void)onTap:(id)sender {
	
	[self addGradientLayer];
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

- (IBAction)testRunLoop:(id)sender {
	
	TestRunLoopVCTL *vctl = [[TestRunLoopVCTL alloc] init];
	
	[self.navigationController pushViewController:vctl animated:NO];
}

@end
