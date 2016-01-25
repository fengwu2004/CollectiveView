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
#import "OCCallJavaScript.h"
#import "UICopyLabel.h"
#import "GCBackGroundMusicVCTL.h"
#import "SearchVCTLViewController.h"
#import "SearchTableViewController.h"
#import "PopUpBoxItem.h"
#import "PopUpBox.h"
#import "PopUpTestVCTL.h"
#import "GCShowRoomNameVCTL.h"

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()

@property (nonatomic, retain) UICopyLabel *myCopyEnableLabel;
@property (nonatomic, retain) UIButton *bilibiliBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
	
	[super viewDidLoad];
	
//	[self addTap];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBilibili:)];
	
	[self.view addGestureRecognizer:tap];
	
	NSMutableString *str = [NSMutableString stringWithFormat:@"%@", @"acb"];
	
	NSString *str1 = [str copy];
	
	NSLog(@"%lx", (long)str1);
	
	NSString *str2 = str1;
	
	NSLog(@"%lx", (long)str2);
	
	[str appendString:@"ef"];	
}

- (void)onTapBilibili:(UITapGestureRecognizer*)sender {
	
	CGPoint point = [sender locationInView:self.view];
	
	if ([_bilibiliBtn.layer.presentationLayer hitTest:point]) {
		
		_bilibiliBtn.backgroundColor = [UIColor greenColor];
	}
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
	
	_bilibiliBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
	
	_bilibiliBtn.backgroundColor = [UIColor redColor];
	
	[self.view addSubview:_bilibiliBtn];
	
	_bilibiliBtn.userInteractionEnabled = NO;
	
	[_bilibiliBtn addTarget:self action:@selector(display:) forControlEvents:UIControlEventTouchUpInside];
	
	[UIView animateWithDuration:20 animations:^{
		
		[_bilibiliBtn setCenter:CGPointMake(0, 100 + 100)];
	}];
	
	[self performSelector:@selector(display:) withObject:_bilibiliBtn afterDelay:2];
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

- (IBAction)testJs:(id)sender {
	
	OCCallJavaScript* vctl = [[OCCallJavaScript alloc] init];
	
	[self.navigationController pushViewController:vctl animated:YES];
}

- (IBAction)onMusicPanle:(id)sender {
	
	GCBackGroundMusicVCTL *vctl = [[GCBackGroundMusicVCTL alloc] init];
	
	[self.navigationController pushViewController:vctl animated:YES];
}

- (IBAction)onSearch:(id)sender {
	
	SearchVCTLViewController *vctl = [[SearchVCTLViewController alloc] init];
	
	[self.navigationController pushViewController:vctl animated:YES];
}

- (IBAction)onPopUpTest:(id)sender {
	
	PopUpTestVCTL *vctl = [[PopUpTestVCTL alloc] init];
	
	[self.navigationController pushViewController:vctl animated:YES];
}

- (IBAction)onChangeName:(id)sender {
	
	GCShowRoomNameVCTL *vctl = [[GCShowRoomNameVCTL alloc] init];
	
	[self.navigationController pushViewController:vctl animated:YES];
}

@end
