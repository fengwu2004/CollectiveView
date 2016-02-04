//
//  InkeStyleVCTL.m
//  CollectiveView
//
//  Created by user on 16/2/2.
//  Copyright © 2016年 user. All rights reserved.
//

#import "InkeStyleVCTL.h"

@interface InkeStyleVCTL ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView* ibTableView;
@property (nonatomic, assign) CGFloat contentOffsetY;
@property (nonatomic, weak) UIView *navigationBar;
@property (nonatomic, assign) BOOL draging;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat originalCenterY;
@property (nonatomic, assign) CGFloat originalTableCenterY;

@end

@implementation InkeStyleVCTL

- (void)viewDidLoad {
	
  [super viewDidLoad];
	
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	[self.navigationController.navigationBar setHidden:YES];
	
	[self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
}

- (void)viewDidAppear:(BOOL)animated {
	
	[super viewDidAppear:animated];
	
	_navigationBar = self.navigationController.navigationBar;
	
	NSLog(@"%@", NSStringFromCGPoint(_navigationBar.center));
	
	_centerY = _ibTableView.center.y;
	
	_width = _ibTableView.bounds.size.width;
	
	_originalCenterY = _navigationBar.center.y;
	
	_originalTableCenterY = _ibTableView.center.y;
}

- (UIColor*)randomColor {
	
	NSInteger value = rand() % 7;
	
	static NSArray *colors;
	
	if (!colors) {
		
		colors = @[[UIColor redColor],
							 [UIColor greenColor],
							 [UIColor blueColor],
							 [UIColor cyanColor],
							 [UIColor yellowColor],
							 [UIColor orangeColor],
							 [UIColor purpleColor]];
	}
	
	return colors[value];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell* cell = [(UITableViewCell*)[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableviewcell"];
	
	cell.backgroundColor = [self randomColor];
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 100;
}

- (void)updateNavigationBar:(UIScrollView*)scrollView {
	
	if (!_draging) {
		
		return;
	}
	
	CGFloat offsetY = scrollView.contentOffset.y - _contentOffsetY;
	
	offsetY = _navigationBar.center.y - offsetY;
	
	offsetY = MIN(offsetY, 42);
	
	offsetY = MAX(offsetY, -22);
	
	_navigationBar.center = CGPointMake(_navigationBar.center.x, offsetY);
	
	_ibTableView.center = CGPointMake(_ibTableView.center.x, _originalTableCenterY + offsetY - _originalCenterY);
	
	NSLog(@"%@", NSStringFromCGRect(_ibTableView.frame));
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	
	return 0.001;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	
	_draging = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	
	_draging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	[self updateNavigationBar:scrollView];
	
	_contentOffsetY = scrollView.contentOffset.y;
}

@end
