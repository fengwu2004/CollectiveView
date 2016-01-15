//
//  SearchTableViewController.h
//  CollectiveView
//
//  Created by user on 16/1/14.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITableView *ibTableView;
@property (nonatomic, retain) UISearchBar *bar;
@property (nonatomic, retain) UISearchDisplayController *displayController;

@end
