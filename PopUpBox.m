//
//  PopUpBox.m
//  CollectiveView
//
//  Created by user on 16/1/15.
//  Copyright © 2016年 user. All rights reserved.
//

#import "PopUpBox.h"
#import "PopUpBoxItem.h"
#import "PopUpCell.h"
#import "Utilities.h"

@interface PopUpBox()

@property (nonatomic, retain) IBOutlet UITableView *ibTableView;
@property (nonatomic, assign) CGFloat heightForCell;

@end

@implementation PopUpBox

- (id)initWithFrame:(CGRect)frame with:(NSArray*)data {
	
	self = [super initWithFrame:frame];
	
	_ibTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
	
	_ibTableView.scrollEnabled = NO;
	
	_ibTableView.delegate = self;
	
	_ibTableView.dataSource = self;
	
	_ibTableView.layer.borderColor = [[UIColor blackColor] CGColor];
	
	_ibTableView.layer.cornerRadius= 5;
	
	_ibTableView.layer.borderWidth = 1;
	
	[self addSubview:_ibTableView];
	
	[self setDataSource:data];
	
	[_ibTableView reloadData];
	
	_heightForCell = frame.size.height / data.count;
	
	return self;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.row >= _dataSource.count) {
		
		return nil;
	}
	
	PopUpCell *cell = (PopUpCell*)[tableView dequeueReusableCellWithIdentifier:@"PopUpCell"];
	
	if (!cell) {
		
		cell = (PopUpCell*)[Utilities cellByClassName:@"PopUpCell" inNib:@"PopUpCell" forTableView:tableView];
	}
	
	PopUpBoxItem *item = _dataSource[indexPath.row];
	
	[cell.icon setImage:[UIImage imageNamed:item.iconName]];
	
	[cell.title setText:item.title];
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return _heightForCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	return 0.001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return _dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.row >= _dataSource.count) {
		
		return;
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	PopUpBoxItem *item = _dataSource[indexPath.row];
	
	if (item.block) {
		
		item.block();
	}
}

@end
