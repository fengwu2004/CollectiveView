//
//  SearchTableViewController.m
//  CollectiveView
//
//  Created by user on 16/1/14.
//  Copyright © 2016年 user. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController () <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
	
  [super viewDidLoad];
	
	_bar = [[UISearchBar alloc] initWithFrame:CGRectMake(40, 0, 320, 44)];
	
	_bar.delegate = self;
	
	_displayController = [[UISearchDisplayController alloc] initWithSearchBar:_bar contentsController:self];
	
	_displayController.delegate = self;
	
	_displayController.searchResultsDataSource = self;
	
	_displayController.searchResultsDelegate = self;
	
	[_displayController.searchResultsTableView setBackgroundColor:[UIColor greenColor]];
	
	[_ibTableView setTableHeaderView:_bar];
	
	_ibTableView.backgroundColor = [UIColor redColor];
	
	[_bar setShowsCancelButton:YES animated:YES];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [[UITableViewCell alloc] init];
	
	cell.textLabel.text = @"1";
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return 1;
}

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
	
	NSLog(@"searchDisplayControllerWillBeginSearch");
}

- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller {
	
	NSLog(@"searchDisplayControllerDidBeginSearch");
}

- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller  {
	
	NSLog(@"searchDisplayControllerWillEndSearch");
}

- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {
	
	NSLog(@"searchDisplayControllerDidEndSearch");
}

// called when the table is created destroyed, shown or hidden. configure as necessary.
- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView  {
	
	NSLog(@"didLoadSearchResultsTableView");
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView {
	
	NSLog(@"willUnloadSearchResultsTableView");
}

// called when table is shown/hidden
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView {
	
	NSLog(@"willShowSearchResultsTableView");
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView {
	
	NSLog(@"didShowSearchResultsTableView");
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView  {
	
	NSLog(@"willHideSearchResultsTableView");
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView {
	
	NSLog(@"didHideSearchResultsTableView");
}

// return YES to reload table. called when search string/option changes. convenience methods on top UISearchBar delegate methods
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(nullable NSString *)searchString {
	
	return NO;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
	
	return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	
	NSLog(@"searchBarSearchButtonClicked");
	
	[_displayController setActive:NO animated:YES];
	
//	[_bar setShowsCancelButton:YES animated:NO];
}

@end
