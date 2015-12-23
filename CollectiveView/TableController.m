//
//  TableController.m
//  CollectiveView
//
//  Created by user on 15/12/21.
//  Copyright © 2015年 user. All rights reserved.
//

#import "TableController.h"

@interface TableController ()

@property (nonatomic,retain) NSArray *namelist;

@end

@implementation TableController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	NSArray *group0 = @[@"111", @"222"];
	
	NSArray *group1 = @[@"333", @"444", @"88755"];
	
	NSArray *group2 = @[@"777", @"666"];
	
	_namelist = @[group0, group1, group2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	
	return 0.001;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	NSArray *group = _namelist[section];

	return group.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jlksalkfklsd"];
	
	if (!cell) {
		
		cell = [[UITableViewCell alloc] init];
	}
	
	NSArray *group = _namelist[indexPath.section];
	
	[cell.textLabel setText:group[indexPath.row]];
	
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	return _namelist.count;
}

@end
