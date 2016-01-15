//
//  SearchVCTLViewController.m
//  CollectiveView
//
//  Created by user on 16/1/14.
//  Copyright © 2016年 user. All rights reserved.
//

#import "SearchVCTLViewController.h"

@interface SearchVCTLViewController ()

@end

@implementation SearchVCTLViewController

- (void)viewDidLoad {
	
  [super viewDidLoad];
	
	_ibSearchBar.showsCancelButton = YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
	
	NSLog(@"searchBarTextDidEndEditing");
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
	
	NSLog(@"searchBarShouldBeginEditing");
	
	return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	
	NSLog(@"searchBarTextDidBeginEditing");
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
	
	NSLog(@"searchBarShouldEndEditing");
	
	return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	
	NSLog(@"searchBarShouldEndEditing");
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	
	NSLog(@"shouldChangeTextInRange");
	
	return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	
	NSLog(@"searchBarSearchButtonClicked");
	
	[_ibSearchBar resignFirstResponder];
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
	
	NSLog(@"searchBarBookmarkButtonClicked");
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	
	NSLog(@"searchBarCancelButtonClicked");
	
	[_ibSearchBar resignFirstResponder];
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
	
	NSLog(@"searchBarResultsListButtonClicked");
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
	
	NSLog(@"selectedScopeButtonIndexDidChange");
}

- (IBAction)onClick:(id)sender {
	
	
}

@end
